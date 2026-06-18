package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.CartVsCheckout.checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDetailDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.Promotions.PromotionDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.*;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.VNPayConfig;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private double calculateShippingFee(double subTotal, String city) {
        if (subTotal >= 500000) return 0;
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

        resp.getWriter().println("CHECKOUT GET RUNNING");
        return;
    }

//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
//            throws ServletException, IOException {
//
//        HttpSession session = req.getSession();
//        User user = (User) session.getAttribute("user");
//        Cart cart = (Cart) session.getAttribute("cart");
//
//        if (user == null) {
//            resp.sendRedirect(req.getContextPath() + "/view/user/sign-in.jsp");
//            return;
//        }
//        if (cart == null || cart.isEmpty()) {
//            resp.sendRedirect(req.getContextPath() + "/cart");
//            return;
//        }
//
//        double subTotal = cart.getTotalPrice();
//        String defaultCity = "Hồ Chí Minh";
//        double shippingFee = calculateShippingFee(subTotal, defaultCity);
//
//        req.setAttribute("user", user);
//        req.setAttribute("cart", cart);
//        req.setAttribute("subTotal", subTotal);
//        req.setAttribute("productDiscount", 0.0);
//        req.setAttribute("finalShippingFee", shippingFee);
//        req.setAttribute("finalTotalAmount", subTotal + shippingFee);
//        req.setAttribute("city", defaultCity);
//
//        session.removeAttribute("savedVoucherProduct");
//        session.removeAttribute("savedProductDiscount");
//        session.removeAttribute("savedVoucherShip");
//        session.removeAttribute("savedShipDiscount");
//        session.removeAttribute("savedGHNFee");
//        session.removeAttribute("SAFE_DISTRICT");
//        session.removeAttribute("SAFE_WARD");
//
//        req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
//    }

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

            String action = req.getParameter("action");
            if (action == null) action = "order";

            // LƯU DATA AN TOÀN VÀO SESSION
            String reqDistrict = req.getParameter("districtId");
            String reqWard = req.getParameter("wardCode");

            if (reqDistrict != null && !reqDistrict.trim().isEmpty()) {
                session.setAttribute("SAFE_DISTRICT", reqDistrict);
            }
            if (reqWard != null && !reqWard.trim().isEmpty()) {
                session.setAttribute("SAFE_WARD", reqWard);
            }

            PromotionDAO promotionDAO = new PromotionDAO();
            double subTotal = cart.getTotalPrice();
            double baseShippingFee = 0;

            String ghnFeeStr = req.getParameter("ghnShippingFee");
            if (ghnFeeStr != null && !ghnFeeStr.isEmpty()) {
                baseShippingFee = Double.parseDouble(ghnFeeStr);
                session.setAttribute("savedGHNFee", baseShippingFee);
            } else {
                Double savedFee = (Double) session.getAttribute("savedGHNFee");
                baseShippingFee = (savedFee != null) ? savedFee : calculateShippingFee(subTotal, city);
            }

            if (subTotal >= 500000) baseShippingFee = 0;

            if ("updateShipping".equals(action)) {
                Double pd = (Double) session.getAttribute("savedProductDiscount");
                double finalProductDiscount = (pd != null) ? pd : 0;

                Double sd = (Double) session.getAttribute("savedShipDiscount");
                double finalShipDiscount = (sd != null) ? sd : 0;

                String savedVoucherShip = (String) session.getAttribute("savedVoucherShip");
                if (savedVoucherShip != null && promotionDAO.getCode().contains(savedVoucherShip)) {
                    String discountType = promotionDAO.getDiscountType(savedVoucherShip);
                    double val = promotionDAO.getDiscountValue(savedVoucherShip, discountType);
                    finalShipDiscount = "percent".equals(discountType) ? baseShippingFee * (val / 100) : val;
                    if (finalShipDiscount > baseShippingFee) finalShipDiscount = baseShippingFee;
                    session.setAttribute("savedShipDiscount", finalShipDiscount);
                }

                double finalShippingFee = baseShippingFee - finalShipDiscount;
                if (finalShippingFee < 0) finalShippingFee = 0;
                double finalTotalAmount = (subTotal - finalProductDiscount) + finalShippingFee;

                req.setAttribute("subTotal", subTotal);
                req.setAttribute("productDiscount", finalProductDiscount);
                req.setAttribute("finalShippingFee", finalShippingFee);
                req.setAttribute("finalTotalAmount", finalTotalAmount);
                req.setAttribute("user", user);
                req.setAttribute("cart", cart);

                req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
                return;
            }

            if ("applyVoucherProduct".equals(action)) {
                String codeProduct = req.getParameter("voucherCodeProduct");
                double productDiscount = 0;
                if (promotionDAO.getCode().contains(codeProduct)) {
                    String discountType = promotionDAO.getDiscountType(codeProduct);
                    double val = promotionDAO.getDiscountValue(codeProduct, discountType);
                    productDiscount = "percent".equals(discountType) ? subTotal * (val / 100) : val;
                }
                session.setAttribute("savedVoucherProduct", codeProduct);
                session.setAttribute("savedProductDiscount", productDiscount);
            } else if ("applyVoucherShip".equals(action)) {
                String codeShip = req.getParameter("voucherCodeShip");
                double shipDiscount = 0;
                if (promotionDAO.getCode().contains(codeShip)) {
                    String discountType = promotionDAO.getDiscountType(codeShip);
                    double val = promotionDAO.getDiscountValue(codeShip, discountType);
                    shipDiscount = "percent".equals(discountType) ? baseShippingFee * (val / 100) : val;
                    if (shipDiscount > baseShippingFee) shipDiscount = baseShippingFee;
                }
                session.setAttribute("savedVoucherShip", codeShip);
                session.setAttribute("savedShipDiscount", shipDiscount);
            }

            Double pd = (Double) session.getAttribute("savedProductDiscount");
            double finalProductDiscount = (pd != null) ? pd : 0;
            Double sd = (Double) session.getAttribute("savedShipDiscount");
            double finalShipDiscount = (sd != null) ? sd : 0;

            double finalShippingFee = baseShippingFee - finalShipDiscount;
            if (finalShippingFee < 0) finalShippingFee = 0;
            double finalTotalAmount = (subTotal - finalProductDiscount) + finalShippingFee;

            if ("order".equals(action)) {

                // LẤY TRỰC TIẾP TỪ SESSION
                String finalDistrictId = (String) session.getAttribute("SAFE_DISTRICT");
                String finalWardCode = (String) session.getAttribute("SAFE_WARD");

                if (finalDistrictId == null || finalWardCode == null) {
                    req.setAttribute("error", "Vui lòng chọn đầy đủ Tỉnh/Huyện/Xã để tính phí ship trước khi Đặt hàng!");
                    req.setAttribute("isErrorPage", true);
                    req.setAttribute("receiverPhone", receiverPhone);
                    req.setAttribute("cart", cart);
                    req.setAttribute("subTotal", subTotal);
                    req.setAttribute("productDiscount", finalProductDiscount);
                    req.setAttribute("finalShippingFee", finalShippingFee);
                    req.setAttribute("finalTotalAmount", finalTotalAmount);
                    req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
                    return;
                }

                if(receiverPhone == null || receiverPhone.isEmpty() || !receiverPhone.matches("^0\\d{9}$")){
                    req.setAttribute("error", "Số điện thoại phải bắt đầu bằng 0 và có 10 số!");
                    req.setAttribute("isErrorPage", true);
                    req.setAttribute("receiverPhone", "");
                    req.setAttribute("cart", cart);
                    req.setAttribute("subTotal", subTotal);
                    req.setAttribute("productDiscount", finalProductDiscount);
                    req.setAttribute("finalShippingFee", finalShippingFee);
                    req.setAttribute("finalTotalAmount", finalTotalAmount);
                    req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
                    return;
                }

                ProductDAO productDAO = new ProductDAO();
                for (CartItem item : cart.getItems()) {
                    Product p = productDAO.findById(item.getProduct().getId());
                    if (p == null || p.getQuantity() < item.getQuantity()) {
                        req.setAttribute("error", "Sản phẩm không đủ số lượng tồn kho!");
                        req.setAttribute("isErrorPage", true);
                        req.setAttribute("cart", cart);
                        req.setAttribute("subTotal", subTotal);
                        req.setAttribute("productDiscount", finalProductDiscount);
                        req.setAttribute("finalShippingFee", finalShippingFee);
                        req.setAttribute("finalTotalAmount", finalTotalAmount);
                        req.getRequestDispatcher("/view/shop/checkout.jsp").forward(req, resp);
                        return;
                    }
                }

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

                // TRUYỀN DATA AN TOÀN VÀO ORDER
                order.setDistrictId(Integer.parseInt(finalDistrictId));
                order.setWardCode(finalWardCode);

                OrderDAO orderDAO = new OrderDAO();
                int orderId = orderDAO.insert(order);

                OrderDetailDAO detailDAO = new OrderDetailDAO();
                for (CartItem item : cart.getItems()) {
                    OrderDetail detail = new OrderDetail(orderId, item.getProduct().getId(), item.getQuantity(), item.getProduct().getPrice());
                    detailDAO.insert(detail);
                    productDAO.deductStock(item.getProduct().getId(), item.getQuantity());
                }

                String appliedVoucherProduct = (String) session.getAttribute("savedVoucherProduct");
                String appliedVoucherShip = (String) session.getAttribute("savedVoucherShip");

                if (appliedVoucherProduct != null && !appliedVoucherProduct.isEmpty()) {
                    Integer promoId = promotionDAO.getPromotionIdByCode(appliedVoucherProduct);
                    if (promoId != null && finalProductDiscount > 0) orderDAO.saveOrderPromotion(orderId, promoId, finalProductDiscount);
                }
                if (appliedVoucherShip != null && !appliedVoucherShip.isEmpty()) {
                    Integer promoId = promotionDAO.getPromotionIdByCode(appliedVoucherShip);
                    if (promoId != null && finalShipDiscount > 0) orderDAO.saveOrderPromotion(orderId, promoId, finalShipDiscount);
                }

                session.removeAttribute("cart");
                session.removeAttribute("savedVoucherProduct");
                session.removeAttribute("savedProductDiscount");
                session.removeAttribute("savedVoucherShip");
                session.removeAttribute("savedShipDiscount");
                session.removeAttribute("savedGHNFee");
                session.removeAttribute("SAFE_DISTRICT");
                session.removeAttribute("SAFE_WARD");

                try {
                    orderDAO.updateSignatureStatus(orderId, "CHO_KY_SO");
                } catch (Exception e) {
                    System.out.println("Lỗi cập nhật trạng thái chờ ký: " + e.getMessage());
                }
                resp.sendRedirect(req.getContextPath() + "/verify-signature?orderId=" + orderId);
                return;
            }

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