<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/checkout2.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

</head>
<body>
    <jsp:include page="/WEB-INF/components/header.jsp"/>
    <main>
        <!-- breadcrumb -->
        <div class="back">
            <a href="${pageContext.request.contextPath}/">Trang Chủ</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/shop">Cửa Hàng</a>
            <span>/</span>
            <a href="${pageContext.request.contextPath}/cart">Giỏ hàng</a>
            <span>/</span>
            <a href="#">Thanh toán</a>
        </div>

        <div class="checkout-page">
            <div class="checkout-container">

                <h2 class="checkout-title">Thanh toán đơn hàng</h2>

                <!--Thêm hiển thị lỗi-->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger" style="color: red; margin-bottom: 15px; border: 1px solid red; padding: 10px;">
                            ${error}
                    </div>
                </c:if>

                <form class="checkout-form"
                      action="${pageContext.request.contextPath}/checkout"
                      method="post">

                    <div class="checkout-layout">

                        <!-- LEFT: CUSTOMER INFO -->
                        <div class="checkout-left">

                            <h3 class="section-title">Thông tin người nhận</h3>

                            <div class="form-group">
                                <label for="receiverName">Họ và tên</label>
                                <input id="receiverName"
                                       name="receiverName"
                                       class="input-text"
                                       value="${isErrorPage? receiverName : (not empty receiverName? receiverName : user.fullName)}"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="receiverPhone">Số điện thoại</label>
                                <input id="receiverPhone"
                                       name="receiverPhone"
                                       class="input-text"
                                       value="${isErrorPage? receiverPhone: (not empty receiverPhone ? receiverPhone : user.phoneNumber)}"
                                       placeholder="0123456789"
                                       required
                                       pattern="^0\d{9}$"
                                       autocomplete="off"
                                       oninput="this.value=this.value.replace(/[^0-9]/g,'')"
                                       title="Số điện thoại bắt đầu bằng 0 và có 10 số">
                            </div>

                            <div class="form-group">
                                <label>Email</label>
                                <input class="input-text input-disabled"
                                       value="${user.email}"
                                       palceholder="demo123@gmail.com"
                                       disabled>
                            </div>

                            <div class="form-group">
                                <label for="address">Địa chỉ</label>
                                <input id="address"
                                       name="address"
                                       class="input-text"
                                       value="${isErrorPage? address: (not empty address ? address : user.address)}"
                                       plaveholder="Tên đường, số nhà"
                                       required>
                            </div>

                            <div class="form-group">
                                <label for="province">Tỉnh/Thành phố</label>
                                <select id="province" name="province" class="input-text" required>
                                    <option value="">-- Chọn Tỉnh/Thành phố --</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="district">Quận/Huyện</label>
                                <select id="district" name="district" class="input-text" required disabled>
                                    <option value="">-- Chọn Quận/Huyện --</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="ward">Phường/Xã</label>
                                <select id="ward" name="ward" class="input-text" required disabled>
                                    <option value="">-- Chọn Phường/Xã --</option>
                                </select>
                            </div>

                            <input type="hidden" id="fullAddress" name="city" value="">
                            <input type="hidden" id="hiddenDistrictId" name="districtId" value="${param.districtId}">
                            <input type="hidden" id="hiddenWardCode" name="wardCode" value="${param.wardCode}">

                            <div class="form-group">
                                <label for="note">Ghi chú</label>
                                <textarea id="note"
                                          name="note"
                                          placeholder="Ghi chú về đơn hàng của bạn"
                                          class="input-textarea">${note}</textarea>
                            </div>

                        </div>

                        <!-- RIGHT: ORDER SUMMARY -->
                        <div class="checkout-right">

                            <h3 class="section-title">Đơn hàng của bạn</h3>

                            <table class="order-table">
                                <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>SL</th>
                                    <th>Thành tiền</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="item" items="${cart.items}">
                                    <tr>
                                        <td class="product-name">
                                                ${item.product.productName}
                                        </td>
                                        <td class="product-qty">
                                                ${item.quantity}
                                        </td>
                                        <td class="product-price">
                                            <fmt:formatNumber value="${item.totalPrice}"
                                                              type="currency"
                                                              currencySymbol="₫"/>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- VOUCHER -->
                            <div class="voucher-section">
                                <h4 class="sub-title">Mã giảm giá sản phẩm</h4>
                                <div class="voucher_container">
                                    <input name="voucherCodeProduct"
                                           class="input-text"
                                           value="${sessionScope.savedVoucherProduct}"
                                           placeholder="Nhập mã giảm giá cho đơn hàng">

                                    <button type="submit"
                                            name="action"
                                            value="applyVoucherProduct"
                                            class="btn-apply-voucher">
                                        Áp dụng
                                    </button>
                                </div>

                                <h4 class="sub-title">Mã giảm giá phí vận chuyển</h4>
                                <div class="voucher_container">
                                    <input name="voucherCodeShip"
                                           class="input-text"
                                           value="${sessionScope.savedVoucherShip}"
                                           placeholder="Nhập mã giảm giá cho vận chuyển">

                                    <button type="submit"
                                            name="action"
                                            value="applyVoucherShip"
                                            class="btn-apply-voucher">
                                        Áp dụng
                                    </button>
                                </div>
                            </div>

                            <!-- PAYMENT METHOD -->
                            <div class="payment-section">
                                <h4 class="sub-title">Phương thức thanh toán</h4>

                                <label class="payment-option">
                                    <input type="radio"
                                           name="paymentMethod"
                                           value="COD"
                                    ${empty param.paymentMethod or param.paymentMethod eq 'COD' ? 'checked' : ''}>
                                    Thanh toán khi nhận hàng (COD)
                                </label>

                                <label class="payment-option">
                                    <input type="radio"
                                           name="paymentMethod"
                                           value="VNPAY"
                                    ${param.paymentMethod eq 'VNPAY' ? 'checked' : ''}>
                                    Thanh toán qua VNPay
                                </label>
                            </div>

                            <!-- SUMMARY -->
                            <div class="order-summary">
                                <div class="summary-row">
                                    <span>Tạm tính</span>
                                    <span>
                                        <fmt:formatNumber value="${subTotal}"
                                                  type="currency"
                                                  currencySymbol="₫"/>
                                    </span>
                                </div>

                                <c:if test="${productDiscount > 0}">
                                    <div class="summary-row" style="color: red;">
                                        <span>Giảm giá sản phẩm: </span>
                                        <span>- <fmt:formatNumber value="${productDiscount}" type="currency" currencySymbol="₫"/></span>
                                    </div>
                                </c:if>

                                <div class="summary-row">
                                    <span>Phí vận chuyển</span>
                                    <span><fmt:formatNumber value="${finalShippingFee}" type="currency" currencySymbol="₫"/></span>
                                </div>

                                <div class="summary-row summary-total">
                                    <span>Tổng cộng</span>
                                    <span>
                                <fmt:formatNumber value="${finalTotalAmount}"
                                                  type="currency"
                                                  currencySymbol="₫"/>
                            </span>
                                </div>
                            </div>

                            <button type="submit"
                                    name="action"
                                    value="order"
                                    class="btn-order">
                                ĐẶT HÀNG
                            </button>

                        </div>
                    </div>

                </form>
            </div>
        </div>

    </main>

    <jsp:include page="/WEB-INF/components/footer.jsp"/>

<script src="${pageContext.request.contextPath}/assets/js/components.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/pages/checkout.js"></script>
</body>
</html>
