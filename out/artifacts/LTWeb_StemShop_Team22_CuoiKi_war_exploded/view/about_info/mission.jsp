<%--
  Created by IntelliJ IDEA.
  User: Truong
  Date: 12/19/2025
  Time: 9:38 PM
  To change this template use File | Settings | File Templates.
--%>


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Su Menh</title>


    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/mission.css">
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
        <a href="#">Sứ mệnh & Tầm nhìn</a>
    </div>
    <!-- SECTION 1: MISSION INTRO -->
    <section class="mission-intro">
        <div class="container">
            <div class="mission-text">
                <h1>Sứ mệnh của STEMSHOP</h1>
                <p>
                    Chúng tôi tin rằng mỗi đứa trẻ đều có tiềm năng trở thành nhà sáng chế tương lai.
                    Sứ mệnh của <strong>STEMSHOP</strong> là mang đến những công cụ học tập thực tế, giúp học sinh Việt Nam tiếp
                    cận
                    <strong>giáo dục STEM</strong> theo hướng sáng tạo, thực hành và hội nhập quốc tế.
                </p>
            </div>
            <div class="mission-image">
                <img src="../../assets/images/about/about-misson-logo.png" alt="Học sinh STEM sáng tạo trong lớp học">
            </div>
        </div>
    </section>

    <!-- SECTION 2: CORE VALUES -->
    <section class="mission-values">
        <div class="container">
            <h2>GIÁ TRỊ CỐT LÕI CỦA CHÚNG TÔI</h2>
            <div class="values-grid">
                <div class="value-card">
                    <i class="fa-solid fa-lightbulb"></i>
                    <h3>Sáng tạo</h3>
                    <p>Khuyến khích học sinh tư duy độc lập, sáng tạo và dám thử nghiệm ý tưởng mới.</p>
                </div>
                <div class="value-card">
                    <i class="fa-solid fa-hand-holding-heart"></i>
                    <h3>Trách nhiệm</h3>
                    <p>Đặt lợi ích và sự an toàn của học sinh lên hàng đầu trong mọi sản phẩm giáo dục.</p>
                </div>
                <div class="value-card">
                    <i class="fa-solid fa-users"></i>
                    <h3>Hợp tác</h3>
                    <p>Kết nối giữa nhà trường, phụ huynh và doanh nghiệp để cùng thúc đẩy giáo dục STEM.</p>
                </div>
                <div class="value-card">
                    <i class="fa-solid fa-earth-asia"></i>
                    <h3>Phát triển bền vững</h3>
                    <p>Đóng góp cho cộng đồng học tập thân thiện, hướng đến tương lai xanh và công nghệ.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- SECTION 3: VISION -->
    <section class="mission-vision">
        <div class="container">
            <div class="vision-content">
                <h2>Tầm nhìn</h2>
                <p>
                    Trở thành nền tảng hàng đầu trong lĩnh vực <strong>học liệu STEM tại Việt Nam</strong>,
                    giúp học sinh phát triển kỹ năng tư duy, <br>sáng tạo và làm chủ công nghệ trong kỷ nguyên số.
                    Chúng tôi hướng tới việc tạo ra hệ sinh thái học tập – sáng tạo – thực hành STEM toàn diện.
                </p>
                <ul>
                    <li><i class="fa-solid fa-check"></i> Mở rộng hợp tác với trường học & trung tâm giáo dục trên toàn quốc.
                    </li>
                    <li><i class="fa-solid fa-check"></i> Xây dựng thư viện học liệu và khóa học STEM trực tuyến.</li>
                    <li><i class="fa-solid fa-check"></i> Phát triển sản phẩm thân thiện môi trường, an toàn cho trẻ nhỏ.</li>
                </ul>
            </div>
            <div class="vision-image">
                <img src="../../assets/images/about/about-misson-vision.png" alt="Tầm nhìn phát triển STEMSHOP">
            </div>
        </div>
    </section>

    <!-- SECTION 4: CTA -->
    <section class="mission-cta">
        <div class="container">
            <h2>Chung tay xây dựng thế hệ sáng tạo Việt Nam</h2>
            <p>Tham gia cùng STEMSHOP để mang STEM đến với mọi lớp học, mọi gia đình.</p>
            <a href="${pageContext.request.contextPath}/view/main/contact.html" class="btn-readmore">
                Liên hệ hợp tác <i class="fa-solid fa-arrow-right"></i>
            </a>
        </div>
    </section>

</main>

<!--HEADER-->
<%@ include file="/WEB-INF/components/footer.jsp" %>



<script>
    // Counter animation
    const counters = document.querySelectorAll('.counter');
    let counted = false;
    function isInViewport(el) {
        const rect = el.getBoundingClientRect();
        return rect.top <= (window.innerHeight || document.documentElement.clientHeight) &&
            rect.bottom >= 0;
    }
    function runCounter() {
        if (!counted && counters.length > 0 && isInViewport(counters[0])) {
            counters.forEach(counter => {
                const target = +counter.getAttribute('data-target');
                let count = 0;
                const increment = target / 200;
                const update = () => {
                    count += increment;
                    if (count < target) {
                        counter.innerText = Math.ceil(count);
                        requestAnimationFrame(update);
                    } else {
                        counter.innerText = target + (target >= 1000 ? "+" : "");
                    }
                };
                update();
            });
            counted = true;
        }
    }
    window.addEventListener('scroll', runCounter);
    window.addEventListener('load', runCounter);
</script>
</body>

</html>

