package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.BrandDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.CategoryDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductImageDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Brand;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Category;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.List;

@WebServlet("/admin/admin-product-edit")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,  // 2MB
        maxFileSize = 1024 * 1024 * 10,       // 10MB
        maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class AdminProductEditServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private BrandDAO brandDAO;
    private ProductImageDAO productImageDAO;

    @Override
    public void init() throws ServletException {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        brandDAO = new BrandDAO();
        productImageDAO = new ProductImageDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

/*       //check ở filterAdmin

        HttpSession session = request.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || !"admin".equals(admin.getRole())) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }*/

        try {
            int id = Integer.parseInt(request.getParameter("id"));
            Product product = productDAO.findByIdWithImage(id);

            if (product != null) {
                List<Category> categories = categoryDAO.getAllCategories();
                List<Brand> brands = brandDAO.getAllBrands();
                List<String> images = productImageDAO.getImagesByProductId(id);

                request.setAttribute("product", product);
                request.setAttribute("categories", categories);
                request.setAttribute("brands", brands);
                request.setAttribute("images", images);
                request.getRequestDispatcher("/view/admin/admin-product-edit.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/admin-products");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/admin-products");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        try {
            int productId = Integer.parseInt(request.getParameter("id"));

            Product product = new Product();
            product.setId(productId);
            product.setProductName(request.getParameter("productName"));
            product.setDescription(request.getParameter("description"));
            product.setPrice(Double.parseDouble(request.getParameter("price")));
            product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            product.setCategoriesID(Integer.parseInt(request.getParameter("categoryID")));
            product.setBrandID(Integer.parseInt(request.getParameter("brandID")));

            // đỏi lại cho upload nhiều ảnh
/*            // Xử lý upload ảnh
            Part filePart = request.getPart("productImage");
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                // Tạo tên file unique
                String timestamp = String.valueOf(System.currentTimeMillis());
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String newFileName = "product_" + productId + "_" + timestamp + extension;

                // Đường dẫn lưu file
                String uploadPath = getServletContext().getRealPath("") + "assets/images/products";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Lưu file
                String filePath = uploadPath + File.separator + newFileName;
                filePart.write(filePath);

                // Đường dẫn để lưu vào DB
                String imageUrl = "/assets/images/products/" + newFileName;

                // Cập nhật hoặc thêm ảnh vào product_image
                productImageDAO.updateOrAddProductImage(productId, imageUrl);
            }*/
            List<Part> imageParts = request.getParts().stream()
                    .filter(p -> "productImages".equals(p.getName()) && p.getSize() > 0)
                    .toList();

            if (!imageParts.isEmpty()) {

                // XÓA TẤT CẢ ẢNH CŨ TRONG DB
                productImageDAO.deleteAllByProductId(productId);

                // LƯU ẢNH MỚI
                String uploadPath = getServletContext().getRealPath("") + "assets/images/products";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdirs();

                for (Part part : imageParts) {
                    String original = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                    String ext = original.substring(original.lastIndexOf("."));
                    String fileName = "product_" + productId + "_" + System.currentTimeMillis() + ext;

                    part.write(uploadPath + File.separator + fileName);

                    String imageUrl = "/assets/images/products/" + fileName;
                    productImageDAO.insertImage(productId, imageUrl);
                }
            }

            // Cập nhật thông tin sản phẩm
            productDAO.updateProduct(product);

            response.sendRedirect(request.getContextPath() + "/admin/admin-products");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra: " + e.getMessage());
        }
    }
}