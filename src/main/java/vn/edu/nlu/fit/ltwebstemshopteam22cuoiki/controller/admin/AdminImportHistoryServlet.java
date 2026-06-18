package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.AdminImportDAO;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/admin/admin-import-history")
public class AdminImportHistoryServlet extends HttpServlet {

    private final AdminImportDAO importDAO = new AdminImportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String filterProductId = request.getParameter("productId");

        // Gọi DAO lấy dữ liệu
        List<Map<String, Object>> productList = importDAO.getProductsWithImportCount();
        List<Map<String, Object>> historyList = importDAO.getImportHistory(filterProductId);

        // Gắn vào request và chuyển trang
        request.setAttribute("productList", productList);
        request.setAttribute("historyList", historyList);
        request.getRequestDispatcher("/view/admin/admin-import-history.jsp").forward(request, response);
    }
}