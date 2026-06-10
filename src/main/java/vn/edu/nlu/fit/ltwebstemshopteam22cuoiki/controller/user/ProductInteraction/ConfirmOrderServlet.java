package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;

import java.io.IOException;

@WebServlet("/confirmOrder")
public class ConfirmOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr != null) {
            int orderId = Integer.parseInt(idStr);
            OrderDAO dao = new OrderDAO();
            
            // Khách bấm đã nhận -> Chuyển thành Đã giao (DELIVERED)
            dao.updateOrderStatus(orderId, "DELIVERED");
        }
        
        response.sendRedirect(request.getContextPath() + "/orders");
    }
}