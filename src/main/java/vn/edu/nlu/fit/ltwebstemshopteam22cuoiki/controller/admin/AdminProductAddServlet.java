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
        if (productId <= 0) {
            response.sendRedirect(request.getContextPath() + "/admin/admin-products");
            return;
        }

        // Upload nhiều ảnh
        String uploadPath = getServletContext().getRealPath("") + "assets/images/products";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        for (Part part : request.getParts()) {
            if (part.getName().equals("productImages") && part.getSize() > 0) {

                String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
                String newFileName = "product_" + productId + "_" + System.currentTimeMillis()
                        + fileName.substring(fileName.lastIndexOf("."));

                part.write(uploadPath + File.separator + newFileName);

                String imageUrl = "/assets/images/products/" + newFileName;
                productImageDAO.insertImage(productId, imageUrl);
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/admin-products");
    }
}