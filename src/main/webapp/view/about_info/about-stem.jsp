<%--
  Created by IntelliJ IDEA.
  User: Truong
  Date: 12/19/2025
  Time: 9:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.T STEMSHOP - Học Tập STEM Sáng Tạo</title>

    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/about-stem.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>
<!--FOOTER-->
<%@ include file="/WEB-INF/components/header.jsp" %>



<main>
    <div class="back">
        <a href="${pageContext.request.contextPath}/">Trang Chủ</a>
        <span>/</span>
        <a href="${pageContext.request.contextPath}/view/main/about.jsp">Giới thiệu</a>
        <span>/</span>
        <a href="#">Về 3.T STEMSHOP</a>
    </div>
    <!-- SECTION 1: GIỚI THIỆU CHUNG -->
    <section class="stem-intro">
        <div class="container">
            <div class="stem-intro__text">
                <h1>Khám phá 3.T STEMSHOP</h1>
                <p>
                    <strong>3.T STEMSHOP</strong> mang đến môi trường học tập STEM tương tác cho trẻ em.
                    Chúng tôi kết hợp <strong>Khoa học, Công nghệ, Kỹ thuật và Toán học</strong> qua bộ kit,
                    robot, mô hình và cảm biến để phát triển tư duy logic, sáng tạo và kỹ năng giải quyết vấn đề.
                </p>
            </div>
            <div class="stem-intro__image">
                <img src="${pageContext.request.contextPath}/assets/images/about/about-stem-1.jpg"
                 alt="Học sinh học STEM">
            </div>
        </div>

    </section>
    <!-- SECTION 2A: THÀNH TỰU / COUNTER -->
    <section class="stem-achievements">
        <div class="container">
            <h2>Thành tựu nổi bật 3.T STEMSHOP</h2>
            <p>Đồng hành cùng hàng nghìn trẻ em, nhà trường và phụ huynh trên hành trình học tập STEM.</p>
            <div class="achievements-grid">
                <div class="achievement-item">
                    <i class="fa-solid fa-award"></i>
                    <h3 class="counter" data-target="10">0</h3>
                    <p>Năm kinh nghiệm</p>
                </div>
                <div class="achievement-item">
                    <i class="fa-solid fa-user-graduate"></i>
                    <h3 class="counter" data-target="5000">0</h3>
                    <p>Học sinh tham gia</p>
                </div>
                <div class="achievement-item">
                    <i class="fa-solid fa-lightbulb"></i>
                    <h3 class="counter" data-target="300">0</h3>
                    <p>Dự án STEM</p>
                </div>
                <div class="achievement-item">
                    <i class="fa-solid fa-handshake"></i>
                    <h3 class="counter" data-target="50">0</h3>
                    <p>Đối tác trường học</p>
                </div>
            </div>
        </div>
    </section>

    <!-- SECTION 2B: 4 LĨNH VỰC CỐT LÕI -->
    <section class="stem-core">
        <div class="container">
            <h2>4 lĩnh vực cốt lõi của 3.T STEMSHOP</h2>
            <div class="stem-core__grid">
                <div class="core-item">
                    <i class="fa-solid fa-flask"></i>
                    <h3>Khoa học</h3>
                    <p>Khám phá thế giới tự nhiên qua thí nghiệm, quan sát và phân tích hiện tượng.</p>
                </div>
                <div class="core-item">
                    <i class="fa-solid fa-microchip"></i>
                    <h3>Công nghệ</h3>
                    <p>Sử dụng robot, lập trình và cảm biến để sáng tạo các dự án STEM thú vị.</p>
                </div>
                <div class="core-item">
                    <i class="fa-solid fa-gears"></i>
                    <h3>Kỹ thuật</h3>
                    <p>Thiết kế, lắp ráp mô hình cơ – điện tử, phát triển kỹ năng giải quyết vấn đề.</p>
                </div>
                <div class="core-item">
                    <i class="fa-solid fa-square-root-variable"></i>
                    <h3>Toán học</h3>
                    <p>Rèn luyện tư duy logic, tính toán và phân tích dữ liệu thực tế.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- SECTION 3: LỢI ÍCH HỌC TẬP -->
    <section class="stem-benefits">
        <div class="container">
            <h2>Tại sao trẻ nên học STEM sớm?</h2>
            <ul class="benefits-list">
                <li><i class="fa-solid fa-check"></i> Phát triển tư duy phản biện và sáng tạo qua thực hành.</li>
                <li><i class="fa-solid fa-check"></i> Hiểu “vì sao” chứ không chỉ học thuộc công thức.</li>
                <li><i class="fa-solid fa-check"></i> Rèn kỹ năng teamwork, giải quyết vấn đề và trình bày ý tưởng.
                </li>
                <li><i class="fa-solid fa-check"></i> Khơi dậy đam mê khoa học, công nghệ và sáng chế.</li>
                <li><i class="fa-solid fa-check"></i> Định hướng nghề nghiệp sớm trong kỷ nguyên 4.0.</li>
            </ul>
        </div>
    </section>

    <!-- SECTION 4: LỘ TRÌNH HỌC -->
    <section class="stem-levels">
        <div class="container">
            <h2>Lộ trình học STEM theo độ tuổi</h2>
            <div class="levels-grid">
                <div class="level-card">
                    <h3>Mầm non (4–6 tuổi)</h3>
                    <p>Khám phá màu sắc, khối hình, chuyển động qua dụng cụ trực quan và trò chơi an toàn.</p>
                </div>
                <div class="level-card">
                    <h3>Tiểu học (7–11 tuổi)</h3>
                    <p>Chế tạo mô hình đơn giản, robot mini, lắp mạch đèn LED và lập trình cơ bản bằng block coding.
                    </p>
                </div>
                <div class="level-card">
                    <h3>THCS & THPT</h3>
                    <p>Học Arduino, Python, robot tự động và thiết kế mạch điện để tạo sản phẩm STEM thực tế.</p>
                </div>
            </div>
            <div class="btn-center">
                <a href="${pageContext.request.contextPath}/view/about_info/guide.jsp" class="btn-readmore-guide">
                    Xem hướng dẫn chi tiết <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- SECTION 6: SẢN PHẨM STEM -->
    <section class="stem-products">
        <div class="container">
            <h2>Bộ kit STEM nổi bật</h2>
            <div class="product-grid">
                <div class="product-item">
                    <img src="../../assets/images/products/Kit STEM Arduino cơ bản.png"
                         alt="Kit STEM Arduino cơ bản">
                    <h4>Kit STEM Arduino cơ bản</h4>
                    <p>Phù hợp THCS & THPT, học lập trình cảm biến và robot mini.</p>
                </div>
                <div class="product-item">
                    <img src="../../assets/images/products/Bộ lắp ráp cơ khí cho trẻ em.png"
                         alt="Bộ lắp ráp cơ khí">
                    <h4>Bộ lắp ráp cơ khí sáng tạo</h4>
                    <p>Dành cho trẻ 7–11 tuổi, khám phá nguyên lý đòn bẩy, bánh răng và lực.</p>
                </div>
                <div class="product-item">
                    <img src="../../assets/images/products/Robot lập trình Scratch.png"
                         alt="Robot lập trình Scratch">
                    <h4>Robot lập trình Scratch</h4>
                    <p>Học tư duy lập trình qua trò chơi trực quan.</p>
                </div>
            </div>
            <div class="btn-center">
                <a href="${pageContext.request.contextPath}/view/shop/shop.jsp" class="btn-readmore">
                    XEM TẤT CẢ SẢN PHẨM <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- SECTION 7: CTA CUỐI -->
    <section class="stem-cta">
        <div class="container">
            <h2>Khám phá thế giới STEM cùng 3.T STEMSHOP</h2>
            <p>Chúng tôi đồng hành cùng nhà trường, phụ huynh và học sinh trên hành trình sáng tạo và khám phá tri
                thức.</p>
            <a href="${pageContext.request.contextPath}/view/main/contact.jsp" class="btn btn-primary">Liên hệ tư vấn</a>
        </div>
    </section>

</main>


<!--FOOTER-->
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
