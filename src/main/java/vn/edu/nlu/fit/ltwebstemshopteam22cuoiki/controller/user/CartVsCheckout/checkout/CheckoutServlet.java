package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.CartVsCheckout.checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDetailDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.Promotions.PromotionDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.*;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.VNPayConfig;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    // Hàm tính phí vận chuyển theo tổng tiền và thành phố
    private double calculateShippingFee(double subTotal, String city) {
        if (subTotal >= 500000) return 0; // Miễn phí ship nếu đơn trên 500k
        if (city == null) return 50000;
        switch (city) {
            case "Hồ Chí Minh": return 30000;
            case "Hà Nội": return 35000;
            case "Đà Nẵng": return 40000;
            case "Cần Thơ": return 45000;
            default: return 50000;
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/view/user/sign-in.jsp");
            return;
        }
        if (cart == null || cart.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/cart");
            return;
        }

        double subTotal = cart.getTotalPrice();
        String defaultCity = "Hồ Chí Minh";
        double shippingFee = calculateShippingFee(subTotal, defaultCity);

        req.setAttribute("user", user);
        req.setAttribute("cart", cart);
        req.setAttribute("subTotal", subTotal);
        req.setAttribute("productDiscount", 0.0);
        req.setAttribute("finalShippingFee", shippingFee);
        req.setAttribute("finalTotalAmount", subTotal + shippingFee);
        req.setAttribute("city", defaultCity);

        session.removeAttribute("savedVoucherProduct");
        session.removeAttribute("savedProductDiscount");
        session.removeAttribute("savedVoucherShip");
        session.removeAttribute("savedShipDiscount");

        req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            HttpSession session = req.getSession();
            User user = (User) session.getAttribute("user");
            Cart cart = (Cart) session.getAttribute("cart");

            if (user == null || cart == null || cart.isEmpty()) {
                resp.sendRedirect(req.getContextPath() + "/view/user/sign-in.jsp");
                return;
            }

            // Lấy form data
            String receiverName = req.getParameter("receiverName");
            String receiverPhone = req.getParameter("receiverPhone");
            String address = req.getParameter("address");
            String city = req.getParameter("city");
            String note = req.getParameter("note");

            req.setAttribute("receiverName", receiverName);
            req.setAttribute("receiverPhone", receiverPhone);
            req.setAttribute("address", address);
            req.setAttribute("city", city);
            req.setAttribute("note", note);

            String percent = "percent";
            String amount = "amount";
            PromotionDAO promotionDAO = new PromotionDAO();

            String action = req.getParameter("action");
            if (action == null) action = "order";

            // Xử lý cập nhật phí ship
            if ("updateShipping".equals(action)) {
                double subTotal = cart.getTotalPrice();
                double shippingFee = calculateShippingFee(subTotal, city);
                req.setAttribute("subTotal", subTotal);
                req.setAttribute("productDiscount", 0.0);
                req.setAttribute("finalShippingFee", shippingFee);
                req.setAttribute("finalTotalAmount", subTotal + shippingFee);
                req.setAttribute("user", user);
                req.setAttribute("cart", cart);
                req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
                return;
            }

            // Áp dụng voucher sản phẩm
            if ("applyVoucherProduct".equals(action)) {
                String codeProduct = req.getParameter("voucherCodeProduct");
                double productDiscount = 0;
                if (promotionDAO.getCode().contains(codeProduct)) {
                    String discountType = promotionDAO.getDiscountType(codeProduct);
                    double val = promotionDAO.getDiscountValue(codeProduct, discountType);
                    productDiscount = percent.equals(discountType) ? cart.getTotalPrice() * (val / 100) : val;
                }
                session.setAttribute("savedVoucherProduct", codeProduct);
                session.setAttribute("savedProductDiscount", productDiscount);
            }
            // Áp dụng voucher vận chuyển
            else if ("applyVoucherShip".equals(action)) {
                String codeShip = req.getParameter("voucherCodeShip");
                double shipDiscount = 0;
                if (promotionDAO.getCode().contains(codeShip)) {
                    String discountType = promotionDAO.getDiscountType(codeShip);
                    double val = promotionDAO.getDiscountValue(codeShip, discountType);
                    double subTotal = cart.getTotalPrice();
                    double baseShippingFee = calculateShippingFee(subTotal, city);
                    shipDiscount = percent.equals(discountType) ? baseShippingFee * (val / 100) : val;
                    if (shipDiscount > baseShippingFee) shipDiscount = baseShippingFee;
                }
                session.setAttribute("savedVoucherShip", codeShip);
                session.setAttribute("savedShipDiscount", shipDiscount);
            }

            // Tính toán lại tiền sau voucher
            Double pd = (Double) session.getAttribute("savedProductDiscount");
            double finalProductDiscount = (pd != null) ? pd : 0;

            Double sd = (Double) session.getAttribute("savedShipDiscount");
            double finalShipDiscount = (sd != null) ? sd : 0;

            double subTotal = cart.getTotalPrice();
            double baseShippingFee = calculateShippingFee(subTotal, city);
            double finalShippingFee = baseShippingFee - finalShipDiscount;
            if (finalShippingFee < 0) finalShippingFee = 0;

            double finalTotalAmount = (subTotal - finalProductDiscount) + finalShippingFee;

            // Đặt hàng
            if ("order".equals(action)) {
                String paymentMethod = req.getParameter("paymentMethod");
                int paymentMethodId = "VNPAY".equals(paymentMethod) ? 2 : 1;
                String paymentStatus = "COD".equals(paymentMethod) ? "unpaid" : "pending";

                Order order = new Order();
                order.setUserId(user.getId());
                order.setOrderStatus("PENDING");
                order.setShippingFee(finalShippingFee);
                order.setTotalAmount(finalTotalAmount);
                order.setNote(note);
                order.setShippingAddress(address + ", " + city);
                order.setReceiverName(receiverName);
                order.setReceiverPhone(receiverPhone);
                order.setPaymentMethodId(paymentMethodId);
                order.setPaymentStatus(paymentStatus);

                OrderDAO orderDAO = new OrderDAO();
                int orderId = orderDAO.insert(order);

                OrderDetailDAO detailDAO = new OrderDetailDAO();
                for (CartItem item : cart.getItems()) {
                    OrderDetail detail = new OrderDetail(orderId, item.getProduct().getId(), item.getQuantity(), item.getProduct().getPrice());
                    detailDAO.insert(detail);
                }

                // Lưu thông tin khuyến mãi (voucher) đã áp dụng
                String appliedVoucherProduct = (String) session.getAttribute("savedVoucherProduct");
                String appliedVoucherShip = (String) session.getAttribute("savedVoucherShip");

                if (appliedVoucherProduct != null && !appliedVoucherProduct.isEmpty()) {
                    Integer promoId = promotionDAO.getPromotionIdByCode(appliedVoucherProduct);
                    if (promoId != null && finalProductDiscount > 0) {
                        orderDAO.saveOrderPromotion(orderId, promoId, finalProductDiscount);
                    }
                }
                if (appliedVoucherShip != null && !appliedVoucherShip.isEmpty()) {
                    Integer promoId = promotionDAO.getPromotionIdByCode(appliedVoucherShip);
                    if (promoId != null && finalShipDiscount > 0) {
                        orderDAO.saveOrderPromotion(orderId, promoId, finalShipDiscount);
                    }
                }

                session.removeAttribute("cart");
                session.removeAttribute("savedVoucherProduct");
                session.removeAttribute("savedProductDiscount");
                session.removeAttribute("savedVoucherShip");
                session.removeAttribute("savedShipDiscount");

                if ("COD".equals(paymentMethod)) {
                    resp.sendRedirect(req.getContextPath() + "/order-success");
                    return;
                }

                if ("VNPAY".equals(paymentMethod)) {
                    String orderInfo = "Thanh toan don hang #" + orderId;
                    String paymentUrl = VNPayConfig.createPaymentUrl(orderId, finalTotalAmount, orderInfo, req);
                    if (paymentUrl != null) {
                        resp.sendRedirect(paymentUrl);
                    } else {
                        req.setAttribute("error", "Không thể tạo yêu cầu thanh toán, vui lòng thử lại.");
                        req.setAttribute("user", user);
                        req.setAttribute("cart", cart);
                        req.setAttribute("subTotal", subTotal);
                        req.setAttribute("productDiscount", finalProductDiscount);
                        req.setAttribute("finalShippingFee", finalShippingFee);
                        req.setAttribute("finalTotalAmount", finalTotalAmount);
                        req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
                    }
                    return;
                }
            }

            // Hiển thị lại trang (nếu chỉ áp voucher)
            req.setAttribute("user", user);
            req.setAttribute("cart", cart);
            req.setAttribute("subTotal", subTotal);
            req.setAttribute("productDiscount", finalProductDiscount);
            req.setAttribute("finalShippingFee", finalShippingFee);
            req.setAttribute("finalTotalAmount", finalTotalAmount);
            req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(500);
        }
    }
}