<%--
  Created by IntelliJ IDEA.
  User: Truong
  Date: 12/19/2025
  Time: 8:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Giới thiệu</title>
    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/about.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />



</head>

<body>


<!--HEADER-->
<%@ include file="/WEB-INF/components/header.jsp" %>

<main>

    <div class="back">
        <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
        <span>/</span>
        <a href="#">Giới thiệu</a>
    </div>


    <!-- SECTION: ABOUT BANNER: STEMSHOP -->
    <section class="section__about-banner">
        <div class="about-container">

            <!-- ẢNH CHÍNH -->
            <div class="about-image">

                <img src="../../assets/images/about/about-main.png" alt="Học tập STEM sáng tạo"
                     class="main-image" />

            </div>

            <!-- NỘI DUNG -->
            <div class="about-content">

                <h5><i class="fa-solid fa-graduation-cap"></i> Về 3.T STEMSHOP</h5>
                <h1>Khơi Dậy Đam Mê Khám Phá Của Bạn Nhỏ<br />Cùng Mô Hình Học Tập STEM Sáng Tạo</h1>
                <p>
                    <span>3.T STEMSHOP</span> mang đến trải nghiệm học tập thực hành và tương tác dành cho trẻ em.
                    Chúng tôi kết hợp <strong>Khoa học, Công nghệ, Kỹ thuật và Toán học (STEM)</strong> trong từng
                    sản phẩm,
                    giúp trẻ phát triển tư duy logic, khả năng sáng tạo và niềm yêu thích khám phá thế giới xung
                    quanh.
                </p>
                <a href="${pageContext.request.contextPath}/view/about_info/about-stem.jsp" class="btn-readmore">
                    TÌM HIỂU THÊM <i class="fa-solid fa-arrow-right-long"></i>

                </a>
            </div>

        </div>
    </section>

    <!-- SECTION: ABOUT MISSION -->
    <section class="section__about-mission">
        <div class="about-container">
            <div class="about-content">
                <h5><i class="fa-solid fa-bullseye"></i> Sứ mệnh & Tầm nhìn</h5>
                <h1>Truyền Cảm Hứng Khám Phá<br>Và Phát Triển Toàn Diện</h1>
                <p>
                    Sứ mệnh của STEMSHOP là tạo nên môi trường học tập đầy cảm hứng,
                    nơi trẻ được trải nghiệm và sáng tạo thông qua thực hành.
                    Chúng tôi tin rằng học tập STEM không chỉ là kiến thức,
                    mà là hành trình khám phá thế giới xung quanh.
                </p>
                <a href="${pageContext.request.contextPath}/view/about_info/mission.jsp" class="btn-readmore">
                    XEM CHI TIẾT <i class="fa-solid fa-arrow-right-long"></i>
                </a>
            </div>

            <div class="about-image">

                <img src="../../assets/images/about/about-mission.png" alt="STEM Mission">

            </div>
        </div>
    </section>


    <!-- SECTION: ABOUT GUIDE -->
    <section class="section__about-guide">
        <div class="guide-container">
            <h2>Tài Liệu Hướng Dẫn</h2>
            <p>Khám phá các tài liệu giúp bạn và bé bắt đầu hành trình STEM dễ dàng hơn.</p>

            <div class="guide-grid">
                <div class="guide-card">
                    <i class="fa-solid fa-book-open"></i>
                    <h3>Hướng dẫn học STEM</h3>
                    <p>Tài liệu cơ bản giúp trẻ hiểu và thực hành STEM tại nhà.</p>
                </div>

                <div class="guide-card">
                    <i class="fa-solid fa-robot"></i>
                    <h3>Lắp ráp & Thực hành</h3>
                    <p>Các bước chi tiết giúp trẻ tạo nên sản phẩm sáng tạo.</p>
                </div>

                <div class="guide-card">
                    <i class="fa-solid fa-video"></i>
                    <h3>Video hướng dẫn</h3>
                    <p>Thư viện video sinh động giúp học dễ hiểu và vui hơn.</p>
                </div>
            </div>
        </div>
    </section>



    <!-- SECTION: ABOUT  FAQ-->
    <section class="section__about-faq">
        <div class="faq-container">
            <h2>Câu Hỏi Thường Gặp</h2>
            <div class="faq-item">
                <h4><i class="fa-solid fa-circle-question"></i> Làm sao để đặt hàng sản phẩm STEM?</h4>
                <p>Bạn có thể đặt hàng trực tiếp qua website hoặc liên hệ qua hotline để được tư vấn.</p>
            </div>
            <div class="faq-item">
                <h4><i class="fa-solid fa-circle-question"></i> Sản phẩm có phù hợp với lứa tuổi nào?</h4>
                <p>Mỗi sản phẩm được thiết kế phù hợp với từng nhóm tuổi từ 5–15 tuổi.</p>
            </div>
            <a href="${pageContext.request.contextPath}/view/main/faq.jsp" class="btn-readmore">
                XEM THÊM CÂU HỎI <i class="fa-solid fa-arrow-right-long"></i>
            </a>
        </div>
    </section>




    <!-- SECTION: ABOUT GROUP -->
    <section class="section__about-group">
        <div class="group-container">
            <h2>Nhóm Phát Triển</h2>
            <p>Những người đứng sau hành trình mang STEM đến với mọi trẻ em Việt Nam.</p>

            <div class="team-grid">
                <div class="team-card">

                    <img src="../../assets/images/about/user-male-circle.jpg" alt="Thành viên nhóm 1">
                    <h3>Lê Quang Trường</h3>
                    <p>MSSV: 23130355</p>

                    <p>Software Developer</p>
                </div>

                <div class="team-card">

                    <img src="../../assets/images/about/user-male-circle.jpg" alt="Thành viên nhóm 2">
                    <h3>Phan Văn Thi</h3>
                    <p>MSSV: 23130309</p>

                    <p>Software Developer</p>
                </div>

                <div class="team-card">

                    <img src="../../assets/images/about/user-male-circle.jpg" alt="Thành viên nhóm 3">
                    <h3>Nguyễn Thanh Tuấn</h3>
                    <p>MSSV: 20130456</p>

                    <p>Software Developer</p>
                </div>
            </div>

            <div class="group-btn">
                <a href="${pageContext.request.contextPath}/view/about_info/about-group.jsp" class="btn-readmore">
                    CHI TIẾT VỀ NHÓM <i class="fa-solid fa-arrow-right-long"></i>
                </a>
            </div>
        </div>
    </section>
    <div class="back-to-top">
        <img src="../../assets/images/shop/back-to-top.png" alt="back-to-top">
    </div>
</main>

<!--FOOTER-->
<%@ include file="/WEB-INF/components/footer.jsp" %>

<script>
    // Back to top button
    const backToTopBtn = document.querySelector('.back-to-top');

    window.addEventListener('scroll', () => {
        if (window.scrollY > 600) {
            backToTopBtn.style.display = 'block';
        } else {
            backToTopBtn.style.display = 'none';
        }
    });

    backToTopBtn.addEventListener('click', () => {
        window.scrollTo({
            top: 0,
            behavior: 'smooth'
        });
    });
</script>


</body>

</html>