package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.GHNService;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/admin-orders")
public class AdminOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        OrderDAO orderDAO = new OrderDAO();
        List<Order> orders = orderDAO.getAllOrdersForAdmin();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/view/admin/admin-orders.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            OrderDAO orderDAO = new OrderDAO();
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String action = request.getParameter("action");

            if ("confirm".equals(action)) {
                // 1. Lấy thông tin đơn hàng đầy đủ từ DB
                Order order = orderDAO.getOrderById(orderId);

                if (order != null) {
                    // 2. GỌI API ĐẨY ĐƠN SANG GIAO HÀNG NHANH
                    String trackingCode = GHNService.createShippingOrder(order, order.getDistrictId(), order.getWardCode());

                    if (trackingCode != null) {
                        // 3. Nếu đẩy thành công, cập nhật trạng thái đơn và lưu Mã Vận Đơn
                        orderDAO.updateStatusAndTrackingCode(orderId, "SHIPPING", trackingCode);
                        request.getSession().setAttribute("message", "Duyệt đơn và đẩy sang GHN thành công! Mã vận đơn: " + trackingCode);
                    } else {
                        // Xử lý lỗi nếu GHN từ chối (VD: Sai số điện thoại, địa chỉ ko hợp lệ)
                        request.getSession().setAttribute("error", "Lỗi đẩy đơn Giao Hàng Nhanh. Vui lòng kiểm tra lại thông tin khách hàng!");
                    }
                } else {
                    request.getSession().setAttribute("error", "Không tìm thấy đơn hàng trong hệ thống!");
                }

            } else if ("cancel".equals(action)) {
                orderDAO.updateOrderStatus(orderId, "CANCELLED");
                request.getSession().setAttribute("message", "Đã hủy đơn hàng thành công!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("error", "Đã xảy ra lỗi hệ thống: " + e.getMessage());
        }

        response.sendRedirect(request.getContextPath() + "/admin/admin-orders");
    }
}