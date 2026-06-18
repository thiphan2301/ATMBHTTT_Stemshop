package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.CartVsCheckout.checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.RSAUtil;

import java.io.IOException;
import java.text.SimpleDateFormat;

@WebServlet("/verify-signature")
public class VerifySignatureServlet extends HttpServlet {

    // lấy chuỗi dl đơn hàng
    private String generateRawData(Order order) {
        // chuyển fortmat về ngày tháng năm vì dl lưu trong db tới giây nên tránh sai số
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        String formattedDate = "";

        if (order.getOrderDate() != null) {
            formattedDate = sdf.format(order.getOrderDate());
        }

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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.getOrderById(orderId);

            req.setAttribute("order", order);
            req.setAttribute("rawOrderData", generateRawData(order));
            req.getRequestDispatcher("/view/shop/verify-signature.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(req.getParameter("orderId"));
            String signature = req.getParameter("signatureData");

            OrderDAO orderDAO = new OrderDAO();
            UserDAO userDAO = new UserDAO();
            Order order = orderDAO.getOrderById(orderId);

            String rawData = generateRawData(order);
            String publicKey = userDAO.getPublicKey(order.getUserId());

            if (publicKey == null || publicKey.isEmpty()) {
                req.setAttribute("error", "Tài khoản của bạn chưa đăng ký Public Key trên hệ thống!");
                req.setAttribute("order", order);
                req.setAttribute("rawOrderData", rawData);
                req.getRequestDispatcher("/view/shop/verify-signature.jsp").forward(req, resp);
                return;
            }

            boolean isValid = RSAUtil.verify(rawData, signature, publicKey);

            if (!isValid) {
                req.setAttribute("error", "Chữ ký không hợp lệ, vui lòng kiểm tra lại khóa hoặc chuỗi dữ liệu!");
                req.setAttribute("order", order);
                req.setAttribute("rawOrderData", rawData);
                req.getRequestDispatcher("/view/shop/verify-signature.jsp").forward(req, resp);
            } else {
                orderDAO.saveSignature(orderId, signature, "DA_KY");

                // ký thành côg thì chck pttt
                if (order.getPaymentMethodId() == 2) {
                    // Chuyển sang thanh toán VNPay
                    resp.sendRedirect(req.getContextPath() + "/vnpay-payment?orderId=" + orderId);
                } else {
                    // nếu thanh toán COD
                    resp.sendRedirect(req.getContextPath() + "/order-success");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}