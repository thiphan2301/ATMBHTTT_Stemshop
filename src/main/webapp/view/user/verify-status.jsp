<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <title>Xác thực tài khoản - StemShop</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background: #f0f2f5;
            margin: 0;
        }

        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
        }

        .success {
            color: #27ae60;
        }

        .error {
            color: #e74c3c;
        }

        .expired {
            color: #e67e22;
        }

        .btn {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 20px;
            background: #3498db;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn:hover {
            background: #2980b9;
        }

        .resend-link {
            margin-top: 15px;
            display: inline-block;
            color: #3498db;
            text-decoration: none;
        }
    </style>
</head>
<body>
<div class="container">
    <%
        String status = (String) request.getAttribute("status");
        String message = (String) request.getAttribute("message");

        if ("success".equals(status)) {
    %>
    <h2 class="success"><i class="fa-regular fa-circle-check"></i> <%= message %>
    </h2>
    <p>Bạn sẽ được chuyển sang trang đăng nhập sau 3 giây...</p>
    <a href="${pageContext.request.contextPath}/dang-nhap" class="btn">Đăng nhập ngay</a>
    <script>
        setTimeout(function () {
            window.location.href = "${pageContext.request.contextPath}/dang-nhap";
        }, 3000);
    </script>
    <%
    } else if ("expired".equals(status)) {
    %>
    <h2 class="expired"><i class="fa-regular fa-clock"></i> <%= message %>
    </h2>
    <p>Vui lòng yêu cầu gửi lại link xác thực mới.</p>
    <form action="${pageContext.request.contextPath}/gui-lai-xac-thuc" method="post">
        <input type="email" name="email" placeholder="Nhập email của bạn" required
               style="padding: 10px; width: 80%; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px;">
        <br>
        <button type="submit" class="btn" style="background: #e67e22;">Gửi lại link xác thực</button>
    </form>
    <%
    } else {
    %>
    <h2 class="error"><i class="fa-regular fa-circle-xmark"></i> <%= message %>
    </h2>
    <a href="${pageContext.request.contextPath}/dang-ky" class="btn">Đăng ký lại</a>
    <%
        }
    %>
</div>
</body>
</html>