  <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

  <html>
  <head>
    <title>Đăng Ký</title>
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
    <a href="#">Đăng Ký</a>
  </div>
  <main class="auth">
    <section class="auth__container">
      <h1 class="auth__title">Đăng ký tài khoản</h1>
      <c:if test="${not empty error}">
        <p style="color:red">${error}</p>
      </c:if>

      <form class="auth__form" action="${pageContext.request.contextPath}/dang-ky" method="post">
        <div class="auth__group">
          <label for="username" class="auth__label">Tên người dùng</label>
          <input type="text" id="username" name="username" class="auth__input" placeholder="Nhập tên đăng nhập của bạn">
        </div>

        <div class="auth__group">
          <label for="email" class="auth__label">Email</label>
          <input type="text" id="email" name="email" class="auth__input" placeholder="Nhập email của bạn">
        </div>

        <div class="auth__group">
          <label for="password" class="auth__label">Mật khẩu</label>
          <input type="password" id="password" name="password" class="auth__input" placeholder="Tạo mật khẩu" minlength="6">
        </div>

        <div class="auth__group">
          <label for="confirm-password" class="auth__label">Xác nhận mật khẩu</label>
          <input type="password" id="confirm-password" name="confirmPassword" class="auth__input" placeholder="Nhập lại mật khẩu">
        </div>

        <button type="submit" class="auth__button">Đăng ký</button>

        <p class="auth__link">
          Đã có tài khoản?
          <a href="sign-in.jsp" class="auth__link--highlight">Đăng nhập</a>
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
