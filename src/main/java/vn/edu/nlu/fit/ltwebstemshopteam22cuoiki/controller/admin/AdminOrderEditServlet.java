package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;

@WebServlet("/admin/admin-order-edit")
public class AdminOrderEditServlet extends HttpServlet {
    private OrderDAO orderDAO;
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        orderDAO = new OrderDAO();
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String paramId = request.getParameter("id");
            if (paramId == null || paramId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/admin/admin-orders");
                return;
            }

            int id = Integer.parseInt(paramId);
            Order order = orderDAO.getOrderById(id);

            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/admin/admin-orders");
                return;
            }

            // Định dạng ngày sang yyyy-MM-ddTHH:mm cho datetime-local
            String formattedDate = "";
            if (order.getOrderDate() != null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                formattedDate = sdf.format(order.getOrderDate());
            }

            request.setAttribute("order", order);
            request.setAttribute("formattedDate", formattedDate);
            request.getRequestDispatcher("/view/admin/admin-order-edit.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi tải thông tin đơn hàng");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        // Lấy thông tin từ form
        String oldIdStr = request.getParameter("oldId");
        String idStr = request.getParameter("id");
        String userIdStr = request.getParameter("userId");
        String orderDateStr = request.getParameter("orderDate");
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String shippingAddress = request.getParameter("shippingAddress");
        String totalAmountStr = request.getParameter("totalAmount");
        String shippingFeeStr = request.getParameter("shippingFee");
        String paymentMethodIdStr = request.getParameter("paymentMethodId");

        // Tạo đối tượng tạm để giữ lại dữ liệu nhập nếu xảy ra lỗi
        Order tempOrder = new Order();
        try {
            if (oldIdStr != null && !oldIdStr.isEmpty()) {
                tempOrder.setId(Integer.parseInt(oldIdStr));
            }
            if (userIdStr != null && !userIdStr.isEmpty()) {
                tempOrder.setUserId(Integer.parseInt(userIdStr));
            }
            if (receiverName != null) {
                tempOrder.setReceiverName(receiverName);
            }
            if (receiverPhone != null) {
                tempOrder.setReceiverPhone(receiverPhone);
            }
            if (shippingAddress != null) {
                tempOrder.setShippingAddress(shippingAddress);
            }
            if (totalAmountStr != null && !totalAmountStr.isEmpty()) {
                tempOrder.setTotalAmount(Double.parseDouble(totalAmountStr));
            }
            if (shippingFeeStr != null && !shippingFeeStr.isEmpty()) {
                tempOrder.setShippingFee(Double.parseDouble(shippingFeeStr));
            }
            if (paymentMethodIdStr != null && !paymentMethodIdStr.isEmpty()) {
                tempOrder.setPaymentMethodId(Integer.parseInt(paymentMethodIdStr));
            }
        } catch (NumberFormatException ignored) {}

        String errorMsg = null;

        try {
            int oldId = Integer.parseInt(oldIdStr);
            int newId = Integer.parseInt(idStr);
            int userId = Integer.parseInt(userIdStr);
            double totalAmount = Double.parseDouble(totalAmountStr);
            double shippingFee = Double.parseDouble(shippingFeeStr);
            int paymentMethodId = Integer.parseInt(paymentMethodIdStr);

            // Kiểm tra xem UserID có tồn tại không
            if (userDAO.getUserById(userId) == null) {
                errorMsg = "ID Người dùng (UserID) không tồn tại trong hệ thống!";
            }

            // Parse orderDate
            Timestamp orderTimestamp = null;
            if (orderDateStr != null && !orderDateStr.isEmpty()) {
                String cleanedDate = orderDateStr.replace("T", " ");
                if (cleanedDate.length() == 16) {
                    cleanedDate += ":00";
                }
                try {
                    orderTimestamp = Timestamp.valueOf(cleanedDate);
                } catch (IllegalArgumentException e) {
                    errorMsg = "Định dạng ngày giờ không hợp lệ!";
                }
            } else {
                errorMsg = "Ngày đặt hàng không được để trống!";
            }

            if (errorMsg != null) {
                request.setAttribute("error", errorMsg);
                request.setAttribute("order", tempOrder);
                request.setAttribute("formattedDate", orderDateStr);
                request.getRequestDispatcher("/view/admin/admin-order-edit.jsp").forward(request, response);
                return;
            }

            User currentUser = (User) session.getAttribute("user");
            Integer actorId = currentUser != null ? currentUser.getId() : null;
            String actorName = currentUser != null ? currentUser.getUserName() : null;
            boolean isUpdated = orderDAO.updateOrderAdmin(oldId, newId, userId, orderTimestamp, receiverName, receiverPhone, shippingAddress, totalAmount, shippingFee, paymentMethodId, actorId, actorName);

            if (isUpdated) {
                session.setAttribute("message", "Cập nhật đơn hàng thành công!");
                response.sendRedirect(request.getContextPath() + "/admin/admin-orders");
            } else {
                request.setAttribute("error", "Lỗi cập nhật hệ thống! Vui lòng thử lại.");
                request.setAttribute("order", tempOrder);
                request.setAttribute("formattedDate", orderDateStr);
                request.getRequestDispatcher("/view/admin/admin-order-edit.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Vui lòng nhập đúng định dạng số cho ID, UserID, Tổng tiền và Phí ship!");
            request.setAttribute("order", tempOrder);
            request.setAttribute("formattedDate", orderDateStr);
            request.getRequestDispatcher("/view/admin/admin-order-edit.jsp").forward(request, response);
        } catch (java.sql.SQLIntegrityConstraintViolationException e) {
            request.setAttribute("error", "ID Đơn hàng mới đã tồn tại hoặc vi phạm ràng buộc dữ liệu!");
            request.setAttribute("order", tempOrder);
            request.setAttribute("formattedDate", orderDateStr);
            request.getRequestDispatcher("/view/admin/admin-order-edit.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            String msg = e.getMessage();
            if (msg != null && msg.contains("Duplicate entry")) {
                request.setAttribute("error", "ID Đơn hàng mới đã tồn tại!");
            } else {
                request.setAttribute("error", "Có lỗi xảy ra: " + msg);
            }
            request.setAttribute("order", tempOrder);
            request.setAttribute("formattedDate", orderDateStr);
            request.getRequestDispatcher("/view/admin/admin-order-edit.jsp").forward(request, response);
        }
    }
}
