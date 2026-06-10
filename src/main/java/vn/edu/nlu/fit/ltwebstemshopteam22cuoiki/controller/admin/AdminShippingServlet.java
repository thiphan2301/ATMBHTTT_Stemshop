package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/shipping")
public class AdminShippingServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> shippingOrders = orderDAO.getShippingOrders();

        request.setAttribute("shippingOrders", shippingOrders);
        request.getRequestDispatcher("/view/admin/admin-shipping.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delivered".equals(action)) {
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            try {
                // Lấy thông tin đơn hàng
                Order order = orderDAO.getOrderById(orderId);

                //  CHỐNG LỖI NULL: Nếu paymentMethodId bị null trong DB thì cho nó mặc định là 0
                int methodId = (order.getPaymentMethodId() != null) ? order.getPaymentMethodId() : 0;

                //  Truyền methodId đã xử lý an toàn vào hàm
                boolean updated = orderDAO.confirmDelivered(orderId, methodId, order.getPaymentStatus());

                if (updated) {
                    request.getSession().setAttribute("success", "Đã xác nhận giao hàng thành công cho đơn #" + orderId);
                } else {
                    request.getSession().setAttribute("error", "Xác nhận thất bại, vui lòng thử lại!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                request.getSession().setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            }
        }

        // Redirect về trang danh sách
        response.sendRedirect(request.getContextPath() + "/admin/shipping");
    }
}