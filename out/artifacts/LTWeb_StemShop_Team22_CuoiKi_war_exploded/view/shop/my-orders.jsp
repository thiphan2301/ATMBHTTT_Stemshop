<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đơn hàng của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        .order-box {
            max-width: 900px;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background: #fff;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .order-status {
            font-weight: bold;
            padding: 4px 10px;
            border-radius: 6px;
        }

        .order-status.PENDING {
            color: #ff9800;
            background: #fff3e0;
        }

        .order-status.CONFIRMED {
            color: #2e7d32;
            background: #e8f5e9;
        }

        .product-item {
            display: flex;
            gap: 15px;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px dashed #ccc;
        }

        .product-item img {
            width: 90px;
            height: 90px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/components/header.jsp"/>

<h2 style="text-align:center;margin:40px 0">Đơn hàng của tôi</h2>

<c:if test="${empty orders}">
    <p style="text-align:center">Bạn chưa mua sản phẩm nào.</p>
</c:if>

<c:forEach var="item" items="${orders}">
    <div class="order-box">

        <!-- HEADER ĐƠN HÀNG -->
        <div class="order-header">
            <p>
                <strong>Đơn hàng #${item.orderId}</strong>
            </p>

            <!-- ⭐ TRẠNG THÁI ĐƠN HÀNG -->
            <p>
                Trạng thái:
                <span class="order-status ${item.orderStatus}">
                        ${item.orderStatus}
                </span>
            </p>
        </div>

        <!-- SẢN PHẨM -->
        <div class="product-item">
            <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="Ảnh sản phẩm">

            <div>
                <p><strong>${item.productName}</strong></p>
                <p>Số lượng: ${item.quantity}</p>
                <p>
                    Giá:
                    <fmt:formatNumber value="${item.price}"
                                      type="currency"
                                      currencySymbol="₫"/>
                </p>
            </div>
        </div>

    </div>
</c:forEach>

<jsp:include page="/WEB-INF/components/footer.jsp"/>
</body>
</html>