<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Giỏ hàng</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/cart.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

</head>
<body>

<style>
    .cart-product-row{
        padding: 20px 0;
    }
    .cart-container__quantity {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .change{
        padding: 20px;
        margin-right:  20px;
        border: 1px solid #333;
        border-radius: 200px;
        width: 40%;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }
    .change a{
        color: black;
    }
    .bin{
        flex: 1;
    }
    .bin a{
        color: black;
    }
    .cart-container__product__title h4 {
        font-size: 1.2rem;
    }
</style>

    <jsp:include page="/WEB-INF/components/header.jsp"/>

    <div class="back">
        <a href="${pageContext.request.contextPath}/index.jsp">Trang Chủ</a>
        <span>/</span>
        <a href="${pageContext.request.contextPath}/shop">Cửa Hàng</a>
        <span>/</span>
        <a href="#">Giỏ hàng</a>
    </div>
    <div class="cart-container__head">
        <h3>Sản Phẩm</h3>
        <h3>Số Lượng</h3>
        <h3>Giá</h3>
    </div>
    <c:if test="${empty cart}">
        <p style="text-align:center; margin: 5%">Giỏ hàng trống</p>
    </c:if>
    <c:forEach items="${cart.items}" var="item">
        <div class="cart-containers-">
            <div class="cart-container cart-product-row">

                <!-- SẢN PHẨM -->
                <div class="cart-container__product">
                    <img src="${pageContext.request.contextPath}/${item.product.imageUrl}" alt="">
                    <div class="cart-container__product__title">
                        <h4 style="color: #989898;">${item.product.brandName}</h4>
                        <h4>${item.product.productName}</h4>
                    </div>
                </div>

                <!-- SỐ LƯỢNG -->
                <div class="cart-container__quantity">
                    <div class="change">
                        <a href="javascript:void(0)"
                           onclick="updateQuantity(${item.product.id}, 'dec')">
                            <i class="fa-solid fa-minus"></i>
                        </a>

                        <span class="quantity-value">${item.quantity}</span>

                        <a href="javascript:void(0)"
                           onclick="updateQuantity(${item.product.id}, 'inc')">
                            <i class="fa-solid fa-plus"></i>
                        </a>
                    </div>

                    <div class="bin">
                        <a href="${pageContext.request.contextPath}/remove-from-cart?id=${item.product.id}">
                            <i class="fa-solid fa-trash delete-btn"></i>
                        </a>
                    </div>
                </div>

                <!-- GIÁ -->
                <div class="cart-container__price">
                    <p class="product-line-price">
                            ${item.totalPrice} Đ
                    </p>
                </div>

            </div>
        </div>
    </c:forEach>
    <div class="total">
        <h2>
            Tổng cộng:
            <span id="total-price">
                ${cart.totalPrice} Đ
            </span>
        </h2>
    </div>
    <div class="continue-shopping">
        <a href="${pageContext.request.contextPath}/shop">
            <h2>Tiếp tục mua hàng</h2>
        </a>
        <a href="${pageContext.request.contextPath}/checkout">
            <h2>Tiến hành thanh toán</h2>
        </a>
    </div>

    <jsp:include page="/WEB-INF/components/footer.jsp"/>

</body>
</html>
