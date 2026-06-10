<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>Đăng nhập</title>
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
    <a href="#">Đăng nhập</a>
</div>
<main class="auth">
    <section class="auth__container">
        <h1 class="auth__title">Đăng  nhập!</h1>
        <c:if test="${not empty error1}">
            <p style="color:red">${error1}</p>
        </c:if>
        
        <c:if test="${not empty error2}">
            <p style="color:red">${error2}</p>
        </c:if>

        <c:if test="${not empty success}">
            <p style="color:blue">${success}</p>
        </c:if>


        <form class="auth__form" id="signInForm" method="post" action="${pageContext.request.contextPath}/dang-nhap">

            <div class="auth__group">
                <label for="username" class="auth__label">Username</label>
                <input type="text" id="username" name="username" class="auth__input" value="${username}" placeholder="Nhập username">
                <%--trogn input tryyền value=${username} để:
                    Khi login fail → ${username} có giá trị => tự điền lại
                    Khi mở trang lần đầu → ${username} rỗng => không lỗi
                --%>
            </div>

            <div class="auth__group">
                <label for="password" class="auth__label">Mật khẩu</label>
                <input type="password" id="password" name="password" class="auth__input" placeholder="Nhập mật khẩu">
            </div>

            <button type="submit" class="auth__button">Đăng nhập</button>

            <div class="auth__link">
                <a href="forgot-password.jsp" class="auth__link--highlight">Quên mật khẩu?</a>
                <a href="sign-up.jsp" class="auth__link--highlight">Đăng ký</a>
            </div>
        </form>
    </section>
</main>

<!--footer-->
<%@ include file="/WEB-INF/components/footer.jsp" %>

<script src="${pageContext.request.contextPath}/assets/js/components.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
