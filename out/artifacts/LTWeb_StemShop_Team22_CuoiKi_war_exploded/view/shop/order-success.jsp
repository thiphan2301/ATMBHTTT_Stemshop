<%@ page contentType="text/html;charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Đặt hàng thành công</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <style>
        .success-box {
            max-width: 600px;
            margin: 80px auto;
            background: #fff;
            padding: 40px;
            text-align: center;
            border-radius: 10px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.1);
        }
        .success-box h1 {
            color: #4CAF50;
        }
        .success-box a {
            display: inline-block;
            margin-top: 20px;
            padding: 12px 25px;
            background: #ff9800;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }
    </style>
</head>
<body>

<div class="success-box">
    <h1>Đặt hàng thành công!</h1>
    <p>Cảm ơn bạn đã mua sắm tại <strong>3T STEMSHOP</strong>.</p>
    <p>Đơn hàng của bạn đang được xử lý.</p>

    <a href="${pageContext.request.contextPath}/shop">
        Tiếp tục mua sắm
    </a>
</div>

</body>
</html>