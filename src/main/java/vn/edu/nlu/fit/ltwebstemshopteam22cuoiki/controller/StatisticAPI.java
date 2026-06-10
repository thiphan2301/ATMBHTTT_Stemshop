package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller;


import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.StatisticDAO;

import java.io.IOException;
import java.util.List;

@WebServlet("/api-admin/statistical") // Đường dẫn gọi API
public class StatisticAPI extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Mặc định lấy tháng, năm hiện tại nếu người dùng chưa chọn
        java.time.LocalDate currentDate = java.time.LocalDate.now();
        int month = currentDate.getMonthValue();
        int year = currentDate.getYear();

        // Đọc tham số từ JavaScript gửi lên (ví dụ: ?month=10&year=2023)
        String monthParam = request.getParameter("month");
        String yearParam = request.getParameter("year");

        if (monthParam != null && yearParam != null) {
            month = Integer.parseInt(monthParam);
            year = Integer.parseInt(yearParam);
        }

        StatisticDAO dao = new StatisticDAO();
        // Gọi hàm DAO mới với tháng/năm linh hoạt
        List<Double> dataRevenue = dao.getRevenueByMonth(month, year);
        java.util.Map<String, Integer> dataStatus = dao.getOrderStatusStats();

        java.util.Map<String, Object> responseData = new java.util.HashMap<>();
        responseData.put("revenue", dataRevenue);
        responseData.put("status", dataStatus);

        String json = new com.google.gson.Gson().toJson(responseData);
        response.getWriter().write(json);
    }
}