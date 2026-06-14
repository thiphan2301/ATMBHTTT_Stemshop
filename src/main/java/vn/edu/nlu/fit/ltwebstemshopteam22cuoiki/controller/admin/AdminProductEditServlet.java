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

            // Kiểm tra xem người dùng có chọn ảnh mới hay không
            boolean hasNewImages = false;
            for (Part part : request.getParts()) {
                if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                    hasNewImages = true;
                    break;
                }
            }

            // Nếu có ảnh mới thì xóa cũ - thêm mới
            if (hasNewImages) {
                // Xóa ảnh DB cũ
                productImageDAO.deleteAllByProductId(productId);

                // Lấy tên hệ điều hành đang chạy ứng dụng
                String os = System.getProperty("os.name").toLowerCase();
                String uploadPath;
                // Tạo tên thư mục chứa ảnh sp
                String folderName = productId + "-" + createFolderName(product.getProductName());

                // Tự động rẽ nhánh đường dẫn theo môi trường
                if (os.contains("win")) {
                    // Cấu hình chạy trên máy cá nhân của bạn (Windows)
                    uploadPath = "E:/StemShop_Images/product-detail/" + folderName;
                } else {
                    // Cấu hình chạy trên máy chủ VPS thực tế (Linux Ubuntu)
                    uploadPath = "/var/www/stemshop_uploads/product-detail/" + folderName;
                }

                // Tiến hành tạo thư mục vật lý trên ổ cứng
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                boolean isFirst = true; //  chọn ảnh đầu làm ảnh chính
                int count = 1; // Khởi tạo biến đếm

                for (Part part : request.getParts()) {
                    if ("productImages".equals(part.getName()) && part.getSize() > 0) {
                        String original = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                        String ext = original.contains(".") ? original.substring(original.lastIndexOf(".")) : "";

                        // Đặt tên file: 1_16812345.jpg
                        String fileName = count + "_" + System.currentTimeMillis() + ext;

                        // Lưu file vào ổ cứng
                        part.write(uploadPath + File.separator + fileName);

                        // Lưu vào Database
                        String imageUrl = "assets/images/product-detail/" + folderName + "/" + fileName;
                        productImageDAO.insertImage(productId, imageUrl, isFirst ? 1 : 0);

                        isFirst = false; // Các ảnh sau sẽ là 0 (ảnh phụ)
                        count++;
                    }
                }
            }

            // Cập nhật thông tin của sản phẩm
            productDAO.updateProduct(product);

            // nếu cập nhật thành công, lưu thông báo đó vào session để hiển thị ra view
            request.getSession().setAttribute("message", "Cập nhật sản phẩm thành công!");
            response.sendRedirect(request.getContextPath() + "/admin/admin-products");

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, lưu thông báo lỗi vào session và hiển thị ra view
            request.getSession().setAttribute("error", "Có lỗi xảy ra: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/admin/admin-products");
        }
    }

    // Hàm hỗ trợ bỏ dấu tiếng việt và khoảng trắng (để tạo tên thư mục lưu ảnh sp)
    private String createFolderName(String productName) {
        try {
            String temp = java.text.Normalizer.normalize(productName, java.text.Normalizer.Form.NFD);
            java.util.regex.Pattern pattern = java.util.regex.Pattern.compile("\\p{InCombiningDiacriticalMarks}+");
            // Xóa dấu tiếng Việt, xóa khoảng trắng và các ký tự đặc biệt
            return pattern.matcher(temp).replaceAll("").replaceAll("[^a-zA-Z0-9]", "");
        } catch (Exception e) {
            return "Product"; // Tên mặc định nếu lỗi
        }
    }
}