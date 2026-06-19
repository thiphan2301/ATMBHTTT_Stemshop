package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.OrderItem;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.RSAUtil;

import java.io.IOException;
import java.text.SimpleDateFormat;


@WebServlet("/orderDetails")
public class OrderDetailServlet extends HttpServlet {
    private String generateRawData(Order order) {
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String formattedDate = order.getOrderDate() != null ? sdf.format(order.getOrderDate()) : "";

        StringBuilder raw = new StringBuilder();
        raw.append("ID=").append(order.getId())
                .append("|UserID=").append(order.getUserId())
                .append("|Date=").append(formattedDate)
                .append("|Receiver=").append(order.getReceiverName())
                .append("|Phone=").append(order.getReceiverPhone())
                .append("|Address=").append(order.getShippingAddress())
                .append("|Total=").append((long) order.getTotalAmount())
                .append("|ShipFee=").append((long) order.getShippingFee())
                .append("|PayMethod=").append(order.getPaymentMethodId());

        return raw.toString();
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        try {
            // Lấy id từ URL (vd: /orderDetails?id=123)
            String orderIdStr = request.getParameter("id");

            if (orderIdStr != null && !orderIdStr.isEmpty()) {
                int orderId = Integer.parseInt(orderIdStr);

                OrderDAO orderDAO = new OrderDAO();
                Order orderFromDB = orderDAO.getOrderById(orderId);

                if (orderFromDB != null) {
                    orderFromDB.setAppliedPromotions(orderDAO.getOrderPromotions(orderId));

                    //bắt đầu kiểm tra
                    boolean isTampered = false; // Mặc định là an toàn

                    if ("DA_KY".equals(orderFromDB.getSignatureStatus())) {
                        UserDAO userDAO = new UserDAO();
                        String rawData = generateRawData(orderFromDB);
                        String publicKey = userDAO.getPublicKey(orderFromDB.getUserId());
                        String signature = orderFromDB.getSignature();

                        // 1: Xác thực bằng RSA (Kiểm tra xem thông tin cơ bản có bị sửa không)
                        if (publicKey == null || signature == null || !RSAUtil.verify(rawData, signature, publicKey)) {
                            isTampered = true;
                        }

                        // 2: Kiểm tra tổng tiền chi tiết có khớp với TotalAmount không
                        // (Phòng trường hợp hacker giữ nguyên TotalAmount nhưng lén xóa bớt hàng trong order_detail)
                        double calculatedTotal = orderFromDB.getShippingFee();
                        if (orderFromDB.getItems() != null) {
                            for (OrderItem item : orderFromDB.getItems()) {
                                calculatedTotal += item.getPrice() * item.getQuantity();
                            }
                        }
                        // Trừ đi tiền khuyến mãi
                        if (orderFromDB.getAppliedPromotions() != null) {
                            for (Double discount : orderFromDB.getAppliedPromotions().values()) {
                                calculatedTotal -= discount;
                            }
                        }

                        // Nếu lệch nhau  -> Có gian lận
                        if (Math.abs(calculatedTotal - orderFromDB.getTotalAmount()) > 1.0) {
                            isTampered = true;
                        }
                    }

                    // Gửi báo động ra giao diện JSP
                    request.setAttribute("isTampered", isTampered);

                    request.setAttribute("order", orderFromDB);
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
        }
    }
}