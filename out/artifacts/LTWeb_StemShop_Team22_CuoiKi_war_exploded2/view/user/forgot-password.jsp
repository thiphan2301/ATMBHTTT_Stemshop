<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Quên mật khẩu</title>
    <meta charset="UTF-8">
    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/sign-in_sign-up.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/cart.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>
<!--HEADER-->
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- breadcrumb -->
<div class="back">
    <a href="${pageContext.request.contextPath}/">Trang Chủ</a>
    <span>/</span>
    <a href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a>
    <span>/</span>
    <a href="#">Quên mật khẩu</a>
</div>
<main class="auth">
    <section class="auth__container">
        <h1 class="auth__title">Quên mật khẩu?</h1>
        <c:if test="${not empty message}">
            <p style="color:green">${message}</p>
        </c:if>

        <c:if test="${not empty error}">
            <p style="color:red">${error}</p>
        </c:if>
        <form class="auth__form" method="post" action="${pageContext.request.contextPath}/quen-mat-khau">
            <div class="auth__group">
                <label class="auth__label">Username</label>
                <input type="text" name="username" class="auth__input" required>
            </div>

            <div class="auth__group">
                <label class="auth__label">Email đã đăng ký</label>
                <input type="email" name="email" class="auth__input" required>
            </div>

            <button type="submit" class="auth__button">Gửi liên kết đặt lại mật khẩu</button>

            <p class="auth__link">
                Nhớ lại mật khẩu?
                <a href="${pageContext.request.contextPath}/view/user/sign-in.jsp" class="auth__link--highlight">Đăng nhập</a>
            </p>
        </form>
    </section>
</main>

<!--footer-->
<%@ include file="/WEB-INF/components/footer.jsp" %>


<script src="${pageContext.request.contextPath}/assets/js/components.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
