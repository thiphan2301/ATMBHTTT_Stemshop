<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/cart.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

</head>
<body>

<jsp:include page="/WEB-INF/components/header.jsp"/>

<div class="cart-wrapper">
    <div class="back">
        <a href="${pageContext.request.contextPath}/index.jsp">Trang Chủ</a>
        <span>/</span>
        <a href="${pageContext.request.contextPath}/shop">Cửa Hàng</a>
        <span>/</span>
        <span style="color: #333;">Giỏ hàng</span>
    </div>

    <div class="cart-content">
        <div class="cart-grid-header">
            <div class="col-product">Sản Phẩm</div>
            <div class="col-quantity">Số Lượng</div>
            <div class="col-price">Giá</div>
        </div>

        <c:if test="${empty cart}">
            <div class="empty-cart">
                <i class="fa-solid fa-cart-shopping"></i>
                <p>Giỏ hàng của bạn đang trống</p>
            </div>
        </c:if>

        <c:forEach items="${cart.items}" var="item">
            <div class="cart-grid-row">
                <div class="col-product">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${item.product.id}"
                       class="product-link">
                        <img src="${pageContext.request.contextPath}/${item.product.imageUrl}" alt="product">
                    </a>

                    <div class="product-info">
                        <p class="brand-name">${item.product.brandName}</p>
                        <h4 class="product-name">${item.product.productName}</h4>
                    </div>
                </div>

                <div class="col-quantity">
                    <div class="qty-control">
                        <a href="javascript:void(0)" class="qty-btn" onclick="updateQuantity(${item.product.id}, 'dec')">
                            <i class="fa-solid fa-minus"></i>
                        </a>
                        <span class="qty-value">${item.quantity}</span>
                        <a href="javascript:void(0)" class="qty-btn" onclick="updateQuantity(${item.product.id}, 'inc')">
                            <i class="fa-solid fa-plus"></i>
                        </a>
                    </div>
                    <a href="${pageContext.request.contextPath}/remove-from-cart?id=${item.product.id}" class="delete-btn" title="Xóa sản phẩm">
                        <i class="fa-solid fa-trash"></i> Xóa
                    </a>
                </div>

                <div class="col-price">
                    <fmt:formatNumber value="${item.totalPrice}" type="number" groupingUsed="true"/> Đ
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="cart-footer">
        <div class="total-section">
            <span>Tổng thanh toán:</span>
            <span class="total-price">
                    <fmt:formatNumber value="${cart.totalPrice}" type="number" groupingUsed="true"/> Đ
                </span>
        </div>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline">
                <i class="fa-solid fa-arrow-left"></i> Tiếp tục mua hàng
            </a>
            <a href="${pageContext.request.contextPath}/checkout" class="btn btn-solid">
                Tiến hành thanh toán <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/components/footer.jsp"/>

</body>
</html>
