package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;

import java.io.IOException;

@WebServlet("/returnOrder")
public class ReturnOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");

        if (idStr != null) {
            int orderId = Integer.parseInt(idStr);
            OrderDAO dao = new OrderDAO();
            
            // Chuyển trạng thái sang "Yêu cầu trả hàng", chờ shop xử lý
            dao.updateOrderStatus(orderId, "RETURN_PENDING");
        }
        
        response.sendRedirect(request.getContextPath() + "/orders");
    }
}