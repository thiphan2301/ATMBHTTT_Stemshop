package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;

import java.io.IOException;


@WebServlet("/orderDetails")
public class OrderDetailServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            // Lấy id từ URL (vd: /orderDetails?id=123)
            String orderIdStr = request.getParameter("id");

            if (orderIdStr != null && !orderIdStr.isEmpty()) {
                int orderId = Integer.parseInt(orderIdStr);

                // 1. Gọi OrderDAO
                OrderDAO orderDAO = new OrderDAO();

                // 2. Lấy dữ liệu Order thật từ Database
                Order orderFromDB = orderDAO.getOrderById(orderId);

                if (orderFromDB != null) {
                    // 3. Set vào biến 'order' để truyền sang JSP
                    request.setAttribute("order", orderFromDB);

                    // 4. Forward sang file JSP của bạn

                    request.getRequestDispatcher("/view/FT/order_detail.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Không tìm thấy đơn hàng này trong CSDL!");
                }
            } else {
                response.sendRedirect(request.getContextPath() + "/orders");
            }
        } catch (Exception e) {

        e.printStackTrace();
        response.setContentType("text/html; charset=UTF-8");
        response.getWriter().println("<h3 style='color:red;'>LỖI RỒI: " + e.getMessage() + "</h3>");
        response.getWriter().println("<p>Nếu có chữ 'Column not found', tức là tên cột trong Database khác với tên trong code rs.get...()</p>");
    }
    }
}