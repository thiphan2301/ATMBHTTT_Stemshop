<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
  <title>Liên Hệ</title>
  <meta charset="UTF-8">
  <!--LINK CSS-->
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/cart.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/contact.css">
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
  <a href="#">Liên Hệ Với Chúng Tôi</a>
</div>

<main class="contact">
  <section class="contact__container">
    <h1 class="contact__title">Liên hệ với chúng tôi</h1>
    <p class="contact__desc">
      Nếu bạn có thắc mắc hoặc góp ý, hãy gửi tin nhắn cho chúng tôi nhé!
    </p>
    <c:if test="${not empty message}">
      <p class="alert success" style="color:blue">${message}</p>
    </c:if>
    <c:if test="${not empty error}">
      <p class="alert" style="color:red">${error}</p>
    </c:if>
<form class="contact__form"
      method="post"
      action="${pageContext.request.contextPath}/contact">

  <div class="contact__group">
    <label class="contact__label">Họ và tên</label>
    <input type="text" name="fullName" class="contact__input" >
  </div>

  <div class="contact__group">
    <label class="contact__label">Email</label>
    <input type="email" name="email" class="contact__input" >
  </div>

  <div class="contact__group">
    <label class="contact__label">Chủ đề</label>
    <input type="text" name="subject" class="contact__input">
  </div>

  <div class="contact__group">
    <label class="contact__label">Nội dung</label>
    <textarea name="message" class="contact__textarea" rows="5" ></textarea>
  </div>

  <button type="submit" class="contact__button">Gửi liên hệ</button>
</form>
  </section>
</main>

<!--footer-->
<%@ include file="/WEB-INF/components/footer.jsp" %>

<script src="${pageContext.request.contextPath}/assets/js/components.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
