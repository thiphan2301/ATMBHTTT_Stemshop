<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Kết quả thanh toán - StemShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        .result-box {
            max-width: 600px;
            margin: 80px auto;
            background: #fff;
            padding: 40px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .success {
            color: #4CAF50;
        }

        .error {
            color: #f44336;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background: #ff9800;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .btn:hover {
            background: #e68900;
        }
    </style>
</head>
<body>
<div class="result-box">
    <%
        String status = (String) request.getAttribute("status");
        String message = (String) request.getAttribute("message");
        Integer orderId = (Integer) request.getAttribute("orderId");

        if ("success".equals(status)) {
    %>
    <h1 class="success"><i class="fa-regular fa-circle-check"></i> Thanh toán thành công!</h1>
    <p><%= message %>
    </p>
    <p>Mã đơn hàng: <strong>#<%= orderId %>
    </strong></p>
    <p>Cảm ơn bạn đã mua sắm tại StemShop!</p>
    <a href="${pageContext.request.contextPath}/shop" class="btn">Tiếp tục mua sắm</a>
    <%
    } else {
    %>
    <h1 class="error"><i class="fa-regular fa-circle-xmark"></i> Thanh toán thất bại</h1>
    <p><%= message %>
    </p>
    <p>Vui lòng thử lại hoặc chọn phương thức thanh toán khác.</p>
    <a href="${pageContext.request.contextPath}/cart" class="btn">Quay lại giỏ hàng</a>
    <%
        }
    %>
</div>
</body>
</html>