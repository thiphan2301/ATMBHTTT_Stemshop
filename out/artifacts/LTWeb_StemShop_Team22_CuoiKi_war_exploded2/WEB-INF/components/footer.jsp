<%--<!-- Wave Divider -->--%>
<%--<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>--%>
<%--<div class="footer-wave">--%>
<%--  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 100" preserveAspectRatio="none">--%>
<%--    <path fill="rgba(236,117,173,1)" d="M0,50 C80,80 160,30 240,60 C320,90 400,40 480,70 C560,90 640,50 720,80 C800,90 880,50 960,80 C1040,90 1120,50 1200,70 C1280,90 1360,60 1440,80 L1440,100 L0,100 Z"/>--%>
<%--  </svg>--%>
<%--</div>--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--thêm taglib này để viết JSTL--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<footer class="footer">

  <div class="container footer__container">

    <!-- LOGO + ICON -->
    <div class="footer__col footer__logo">
      <div class="logo">
        <a href="${pageContext.request.contextPath}/">
          <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="logo">
        </a>
      </div>

      <div class="footer__icon">
        <a href="#" class="header__icon-right"><i class="fa-brands fa-facebook-f"></i></a>
        <a href="#" class="header__icon-right"><i class="fa-brands fa-instagram"></i></a>
        <a href="#" class="header__icon-right"><i class="fa-brands fa-amazon"></i></a>
        <a href="#" class="header__icon-right"><i class="fa-brands fa-twitter"></i></a>
      </div>

      <p>
        3.T STEMSHOP – Nơi mang đến dụng cụ học tập STEM giúp trẻ em vừa học vừa chơi, <br>
        phát triển tư duy logic, khả năng sáng tạo và niềm đam mê khám phá khoa học từ sớm.
      </p>
    </div>

    <!-- LIÊN KẾT NHANH -->
    <div class="footer__col footer__quickLinks">
      <h3>Liên kết nhanh</h3>
      <ul>
        <li><a href="${pageContext.request.contextPath}/">Trang chủ</a></li>
        <li><a href="${pageContext.request.contextPath}/view/main/about.jsp">Giới thiệu</a></li>
        <li><a href="${pageContext.request.contextPath}/view/shop/shop.jsp">Cửa hàng</a></li>
        <li><a href="${pageContext.request.contextPath}/view/content/blog.jsp">Bài viết</a></li>
        <li><a href="${pageContext.request.contextPath}/view/main/contact.jsp">Liên hệ</a></li>
      </ul>
    </div>

    <!-- HỖ TRỢ -->
    <div class="footer__col footer__customerSupport">
      <h3>Hỗ trợ khách hàng</h3>
      <ul>
        <li><a href="${pageContext.request.contextPath}/view/main/faq.jsp">Câu hỏi thường gặp</a></li>
        <li><a href="${pageContext.request.contextPath}/view/main/policy.jsp">Chính sách bảo hành</a></li>
        <li><a href="${pageContext.request.contextPath}/view/main/terms.jsp">Điều khoản sử dụng</a></li>
      </ul>
    </div>

    <!-- THÔNG TIN LIÊN HỆ -->
    <div class="footer__col footer__contact">
      <h3>Liên hệ</h3>
      <p><i class="fa-solid fa-location-dot"></i> Trường Đại học Nông Lâm TP.HCM</p>
      <p><i class="fa-solid fa-envelope"></i> shopstemteam22@gmail.com</p>
      <p><i class="fa-solid fa-phone"></i> +84 123 456 789</p>
    </div>

    <!-- FORM NHẬN EMAIL -->
    <div class="footer__col footer__contact-sendus">
      <h3>Nhận thông báo ngay!</h3>
      <p>Nhập email của bạn để nhận các chương trình mới nhất từ STEMSHOP!</p>
      <form action="" class="footer__newsletter">
        <input type="email" placeholder="Nhập email của bạn!">
        <button type="submit">Gửi ngay</button>
      </form>
    </div>

  </div>

  <div class="footer__bottom">
    <p>© 2025 STEMSHOP - Nhóm 22 | All rights reserved.</p>
  </div>

</footer>
