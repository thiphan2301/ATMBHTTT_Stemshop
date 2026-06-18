package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;
@WebServlet("/confirmOrder")
public class ConfirmOrderServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // 1. Kiểm tra bảo mật: Phải đăng nhập mới được thao tác
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/view/user/sign-in.jsp");
            return;
        }

        String orderIdStr = request.getParameter("id");

        if (orderIdStr != null && !orderIdStr.isEmpty()) {
            try {
                int orderId = Integer.parseInt(orderIdStr);
                OrderDAO orderDAO = new OrderDAO();

                // 2. Lấy thông tin đơn hàng lên để kiểm tra
                Order order = orderDAO.getOrderById(orderId);

                // 3. Kiểm tra bảo mật kép:
                // - Đơn hàng phải có thật
                // - Đơn hàng phải thuộc về user đang đăng nhập (chống hack qua URL)
                // - Đơn hàng phải đang ở trạng thái SHIPPING mới được bấm nhận
                if (order != null && order.getUserId() == user.getId() && "SHIPPING".equals(order.getOrderStatus())) {

                    // 4. Gọi hàm đã viết sẵn trong DAO để hoàn tất đơn hàng
                    boolean success = orderDAO.confirmDelivered(
                            orderId,
                            order.getPaymentMethodId(),
                            order.getPaymentStatus()
                    );

                    if (success) {
                        // Thêm thông báo thành công (nếu giao diện của bạn có hỗ trợ hiển thị alert)
                        session.setAttribute("message", "Xác nhận nhận hàng thành công! Cảm ơn bạn đã mua sắm.");
                    } else {
                        session.setAttribute("error", "Có lỗi xảy ra khi xác nhận!");
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            }
        }

        // 5. Làm mới lại trang Quản lý đơn hàng của User
        // Sửa lại chuỗi "/my-orders" thành đường dẫn urlPatterns đúng của trang quản lý đơn hàng của nhóm bạn
        response.sendRedirect(request.getContextPath() + "/my-orders");
    }
}