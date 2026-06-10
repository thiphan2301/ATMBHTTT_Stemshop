package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.CartVsCheckout.checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.VNPayConfig;

import java.io.IOException;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/vnpay-return")
public class VNPayReturnServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Map<String, String> params = new HashMap<>();
        Enumeration<String> paramNames = request.getParameterNames();
        while (paramNames.hasMoreElements()) {
            String paramName = paramNames.nextElement();
            params.put(paramName, request.getParameter(paramName));
        }

        String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
        String vnp_TxnRef = request.getParameter("vnp_TxnRef");
        String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
        String vnp_Amount = request.getParameter("vnp_Amount");
        String vnp_SecureHash = request.getParameter("vnp_SecureHash");

        int orderId = 0;
        if (vnp_TxnRef != null && vnp_TxnRef.contains("_")) {
            orderId = Integer.parseInt(vnp_TxnRef.split("_")[0]);
        }

        boolean isValidSignature = VNPayConfig.validateSignature(params, vnp_SecureHash);

        String message;
        String status;

        if (isValidSignature && "00".equals(vnp_ResponseCode)) {
            try {
                orderDAO.updatePaymentInfo(orderId, "paid", vnp_TransactionNo, new Date());
                message = "Thanh toán thành công! Mã giao dịch: " + vnp_TransactionNo;
                status = "success";
            } catch (Exception e) {
                e.printStackTrace();
                message = "Cập nhật đơn hàng thất bại";
                status = "error";
            }
        } else {
            try {
                orderDAO.updatePaymentStatusAndOrderStatus(orderId, "failed", "CANCELLED");
            } catch (Exception e) {
                e.printStackTrace();
            }
            message = "Thanh toán thất bại. Mã lỗi: " + vnp_ResponseCode;
            status = "error";
        }

        request.setAttribute("message", message);
        request.setAttribute("status", status);
        request.setAttribute("orderId", orderId);
        request.getRequestDispatcher("view/shop/vnpay-return.jsp").forward(request, response);
    }
}