package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;

import java.io.IOException;

@WebServlet("/cancelOrder")
public class CancelOrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String type = request.getParameter("type");

        if (idStr != null && type != null) {
            int orderId = Integer.parseInt(idStr);
            OrderDAO dao = new OrderDAO();

            if ("direct".equals(type) || "auto".equals(type)) {
                // 1. Cập nhật trạng thái đơn hàng thành Đã Hủy
                dao.updateOrderStatus(orderId, "CANCELLED");

                // 2. CẬP NHẬT TRẠNG THÁI CHỮ KÝ THÀNH ĐÃ HỦY
                try {
                    dao.updateSignatureStatus(orderId, "DA_HUY");
                } catch (Exception e) {
                    e.printStackTrace();
                }

            } else if ("request".equals(type)) {
                // Yêu cầu hủy (khi đã lấy hàng - CONFIRMED)
                dao.updateOrderStatus(orderId, "CANCEL_REQUESTED");
            }
        }

        response.sendRedirect(request.getContextPath() + "/orders");
    }
}