<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt lại mật khẩu - StemShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/sign-in_sign-up.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
</head>
<body>
<%@ include file="/WEB-INF/components/header.jsp" %>

<div class="back">
    <a href="${pageContext.request.contextPath}/">Trang Chủ</a>
    <span>/</span>
    <a href="${pageContext.request.contextPath}/dang-nhap">Đăng nhập</a>
    <span>/</span>
    <a href="#">Đặt lại mật khẩu</a>
</div>

<main class="auth">
    <section class="auth__container">
        <h1 class="auth__title">Đặt lại mật khẩu</h1>

        <c:if test="${not empty error}">
            <p style="color: red; background: #ffe6e6; padding: 10px; border-radius: 5px;">❌ ${error}</p>
        </c:if>

        <form class="auth__form" method="post" action="${pageContext.request.contextPath}/dat-lai-mat-khau">
            <input type="hidden" name="token" value="${param.token}">

            <div class="auth__group">
                <label class="auth__label">Mật khẩu mới</label>
                <input type="password" name="newPassword" class="auth__input" required minlength="6">
                <p style="font-size: 12px; color: #7f8c8d;">* Ít nhất 6 ký tự, bao gồm chữ hoa, chữ thường và số</p>
            </div>

            <div class="auth__group">
                <label class="auth__label">Xác nhận mật khẩu mới</label>
                <input type="password" name="confirmPassword" class="auth__input" required>
            </div>

            <button type="submit" class="auth__button">Đặt lại mật khẩu</button>
        </form>
    </section>
</main>

<%@ include file="/WEB-INF/components/footer.jsp" %>
</body>
</html>