package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.*;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.*;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.List;

@WebServlet("/admin/admin-product-add")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50
)
public class AdminProductAddServlet extends HttpServlet {

    private ProductDAO productDAO;
    private CategoryDAO categoryDAO;
    private BrandDAO brandDAO;
    private ProductImageDAO productImageDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
        categoryDAO = new CategoryDAO();
        brandDAO = new BrandDAO();
        productImageDAO = new ProductImageDAO();
    }

    // HIỂN THỊ FORM
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Category> categories = categoryDAO.getAllCategories();
        List<Brand> brands = brandDAO.getAllBrands();

        request.setAttribute("categories", categories);
        request.setAttribute("brands", brands);
        request.getRequestDispatcher("/view/admin/admin-product-add.jsp")
                .forward(request, response);
    }

    // XỬ LÝ THÊM
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        Product product = new Product();
        product.setProductName(request.getParameter("productName"));
        product.setDescription(request.getParameter("description"));
        product.setPrice(Double.parseDouble(request.getParameter("price")));
        product.setQuantity(Integer.parseInt(request.getParameter("quantity")));
        product.setCategoriesID(Integer.parseInt(request.getParameter("categoryID")));
        product.setBrandID(Integer.parseInt(request.getParameter("brandID")));

        // Insert product
        int productId = productDAO.insertProduct(product);

        // Nếu insert thất bại
        if (productId <= 0) {
            request.getSession().setAttribute("error", "Thêm sản phẩm thất bại! Vui lòng thử lại.");
            response.sendRedirect(request.getContextPath() + "/admin/admin-products");
            return;
        }

        // Upload nhiều ảnh vào thư mục riêng
        // Đường dẫn lưu ảnh (máy cá nhân hoặc trên VPS)
        // Lấy tên hệ điều hành đang chạy ứng dụng
        String os = System.getProperty("os.name").toLowerCase();
        String uploadPath;
        // Tạo tên thư mục theo định dạng: ID-TenSanPhamKhongDau
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

        boolean isFirst = true;
        int count = 1; // Khởi tạo biến đếm ảnh (1, 2, 3...)

        for (Part part : request.getParts()) {
            if ("productImages".equals(part.getName()) && part.getSize() > 0) {

                String original = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String ext = original.contains(".") ? original.substring(original.lastIndexOf(".")) : "";

                // Đặt tên file là: 1_16812345.jpg, 2_16812346.jpg
                String newFileName = count + "_" + System.currentTimeMillis() + ext;

                // Lưu vật lý
                part.write(uploadPath + File.separator + newFileName);

                // Đường dẫn lưu DB chuẩn với foder riêng
                String imageUrl = "assets/images/product-detail/" + folderName + "/" + newFileName;

                productImageDAO.insertImage(productId, imageUrl, isFirst ? 1 : 0);

                isFirst = false;
                count++; // Tăng số thứ tự cho ảnh tiếp theo
            }
        }

        //  thêm sp thành công thì gán thông báo và chuyển trang
        request.getSession().setAttribute("message", "Thêm sản phẩm thành công!");
        response.sendRedirect(request.getContextPath() + "/admin/admin-products");
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