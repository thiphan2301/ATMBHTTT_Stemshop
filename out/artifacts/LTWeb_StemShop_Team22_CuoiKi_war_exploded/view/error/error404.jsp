<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Error 404 Trang không tìm thấy</title>
    <meta charset="UTF-8">
    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/sign-in_sign-up.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/cart.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>
<style>
    .error-404 {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 80px 20px;
    }

    .error-404__container {
        text-align: center;
        max-width: 500px;
    }

    .error-404__icon {
        font-size: 60px;
        color: #e74c3c;
        margin-bottom: 20px;
    }

    .error-404__title {
        font-size: 96px;
        font-weight: 700;
        margin: 0;
    }

    .error-404__subtitle {
        font-size: 28px;
        margin: 10px 0;
    }

    .error-404__desc {
        font-size: 16px;
        color: #555;
        margin: 20px 0 30px;
    }

    .error-404__actions {
        display: flex;
        gap: 15px;
        justify-content: center;
    }

    .btn {
        padding: 10px 20px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: 500;
    }

    .btn--primary {
        background: #0d6efd;
        color: #fff;
    }


</style>
    <!-- 404 CONTENT -->
    <section class="error-404">
        <div class="error-404__container">
            <div class="error-404__icon">
                <i class="fa-solid fa-triangle-exclamation"></i>
            </div>

            <h1 class="error-404__title">404</h1>
            <h2 class="error-404__subtitle">Không tìm thấy trang</h2>

            <p class="error-404__desc">
                Trang bạn đang truy cập không tồn tại <br>
                hoặc bạn <strong>không có quyền truy cập</strong> vào khu vực này.
            </p>

            <div class="error-404__actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn--primary">
                    <i class="fa-solid fa-house"></i>
                    Quay về trang chủ
                </a>

        </div>
    </div>
</section>



<script src="${pageContext.request.contextPath}/assets/js/components.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
