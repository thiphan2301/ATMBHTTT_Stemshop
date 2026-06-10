<%--
  Created by IntelliJ IDEA.
  User: Truong
  Date: 12/19/2025
  Time: 9:31 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới thiệu về thành viên sáng lập trang</title>
    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/about-group.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

</head>
<body>

<!--HEADER-->
<%@ include file="/WEB-INF/components/header.jsp" %>
<main>
    <div class="back">
        <a href="${pageContext.request.contextPath}/">Trang Chủ</a>
        <span>/</span>
        <a href="${pageContext.request.contextPath}/view/main/about.jsp">Giới thiệu</a>
        <span>/</span>
        <a href="#">Về nhóm</a>
    </div>
    <!-- HERO -->
    <section class="group-hero">
        <div class="container">
            <h1>Nhóm Phát Triển 3.T STEMSHOP</h1>
            <p>Chúng tôi là nhóm sinh viên cùng chung đam mê về công nghệ và giáo dục STEM, mong muốn mang đến một nền tảng học tập sáng tạo, dễ tiếp cận cho học sinh Việt Nam.</p>
        </div>
    </section>

    <!-- TEAM MEMBERS -->
    <section class="group-team">
        <div class="container">
            <h2>Thành Viên Nhóm</h2>
            <div class="team-grid">
                <div class="team-card">
                    <img src="../../assets/images/about/user-male-circle.jpg" alt="Lê Quang Trường">
                    <h3>Lê Quang Trường</h3>
                    <p>23130355</p>
                    <p>Software Developer</p>
                    <div class="team-socials">
                        <a href="#"><i class="fa-brands fa-facebook"></i></a>
                        <a href="#"><i class="fa-brands fa-github"></i></a>
                        <a href="#"><i class="fa-solid fa-envelope"></i></a>
                    </div>
                </div>

                <div class="team-card">
                    <img src="../../assets/images/about/user-male-circle.jpg" alt="Phan Văn Thi">
                    <h3>Phan Văn Thi</h3>
                    <p>2313009</p>
                    <p>Software Developer</p>
                    <div class="team-socials">
                        <a href="#"><i class="fa-brands fa-facebook"></i></a>
                        <a href="#"><i class="fa-brands fa-github"></i></a>
                        <a href="#"><i class="fa-solid fa-envelope"></i></a>
                    </div>
                </div>

                <div class="team-card">
                    <img src="../../assets/images/about/user-male-circle.jpg" alt="Nguyễn Thanh Tuấn">
                    <h3>Nguyễn Thanh Tuấn</h3>
                    <p>20130456</p>
                    <p>Software Developer</p>
                    <div class="team-socials">
                        <a href="#"><i class="fa-brands fa-facebook"></i></a>
                        <a href="#"><i class="fa-brands fa-github"></i></a>
                        <a href="#"><i class="fa-solid fa-envelope"></i></a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ABOUT PROJECT -->
    <section class="group-project">
        <div class="container">
            <h2>Về Dự Án</h2>
            <p>
                <strong>3.T STEMSHOP</strong> là đồ án môn <em>Lập Trình Web</em>, được phát triển với mục tiêu
                mô phỏng một nền tảng thương mại điện tử chuyên cung cấp dụng cụ và khóa học STEM.
                Dự án không chỉ rèn luyện kỹ năng lập trình mà còn giúp nhóm hiểu rõ hơn về quy trình xây dựng sản phẩm thực tế.
            </p>
            <div class="project-highlights">
                <div class="highlight-card">
                    <i class="fa-solid fa-code"></i>
                    <h4>Frontend</h4>
                    <p>HTML5, CSS3, JavaScript — thiết kế giao diện thân thiện, chuẩn responsive.</p>
                </div>
                <div class="highlight-card">
                    <i class="fa-solid fa-database"></i>
                    <h4>Backend (mở rộng)</h4>
                    <p>Kết nối MySQL để quản lý sản phẩm, người dùng và đơn hàng trong tương lai.</p>
                </div>
                <div class="highlight-card">
                    <i class="fa-solid fa-lightbulb"></i>
                    <h4>Mục tiêu</h4>
                    <p>Thúc đẩy học sinh Việt Nam học STEM theo cách trực quan, thực hành và sáng tạo.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="group-cta">
        <div class="container">
            <h2>Cảm ơn bạn đã đồng hành cùng 3.T STEMSHOP!</h2>
            <p>Mọi góp ý và phản hồi của bạn sẽ giúp nhóm hoàn thiện hơn trong tương lai.</p>
            <a href="/src/pages/main/contact.html" class="btn-readmore">
                Gửi phản hồi <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
    </section>

</main>

<!--FOOTER-->
<%@ include file="/WEB-INF/components/footer.jsp" %>





</body>
</html>
