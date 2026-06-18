package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.AdminImportDAO;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.List;

@WebServlet("/admin/admin-product-import")
public class AdminProductImportServlet extends HttpServlet {

    private final AdminImportDAO importDAO = new AdminImportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Gọi DAO lấy dữ liệu
        List<String[]> products = importDAO.getAllProductsForImport();

        request.setAttribute("products", products);
        request.getRequestDispatcher("/view/admin/admin-product-import.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // Lấy tham số
        int productId = Integer.parseInt(request.getParameter("productId"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        BigDecimal importPrice = new BigDecimal(request.getParameter("importPrice"));
        String lifespanStr = request.getParameter("lifespanMonths");
        String note = request.getParameter("note");

        Timestamp damagedDate = null;
        if (lifespanStr != null && !lifespanStr.trim().isEmpty()) {
            int months = Integer.parseInt(lifespanStr);
            damagedDate = Timestamp.valueOf(LocalDateTime.now().plusMonths(months));
        }

        // Gọi DAO xử lý transaction
        boolean isSuccess = importDAO.importProduct(productId, quantity, importPrice, damagedDate, note);

        // Chuyển hướng dựa trên kết quả
        if (isSuccess) {
            response.sendRedirect(request.getContextPath() + "/admin/admin-products?success=true");
        } else {
            response.sendRedirect(request.getContextPath() + "/admin/admin-products?error=true");
        }
    }
}