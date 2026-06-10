package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.CartVsCheckout.checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.VNPayConfig;

import java.io.IOException;

@WebServlet("/vnpay-payment")
public class VNPayPaymentServlet extends HttpServlet {
    private OrderDAO orderDAO = new OrderDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null || orderIdStr.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/?error=MissingOrderId");
                return;
            }
            int orderId = Integer.parseInt(orderIdStr);
            double totalAmount = orderDAO.getTotalAmountByOrderId(orderId);
            String orderInfo = "Thanh toan don hang " + orderId;
            String paymentUrl = VNPayConfig.createPaymentUrl(orderId, totalAmount, orderInfo, request);
            if (paymentUrl != null && !paymentUrl.isEmpty()) {
                response.sendRedirect(paymentUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/?error=CreateUrlFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/?error=PaymentError");
        }
    }
}