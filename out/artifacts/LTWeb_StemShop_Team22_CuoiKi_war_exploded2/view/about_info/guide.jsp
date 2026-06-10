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
    <title>3.T STEMSHOP - Học Tập STEM Sáng Tạo</title>


    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/guide.css">
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
        <a href="#">Tài liệu hướng dẫn</a>
    </div>
    <!-- 1️⃣ HƯỚNG DẪN SỬ DỤNG -->
    <section class="guide-steps">
        <div class="container">
            <h1>Hướng dẫn sử dụng STEMSHOP</h1>
            <p>Chỉ với vài bước đơn giản, bạn có thể dễ dàng tìm kiếm và mua dụng cụ STEM phù hợp.</p>

            <div class="steps-grid">
                <div class="step-card">
                    <i class="fa-solid fa-search"></i>
                    <h3>Bước 1: Tìm kiếm sản phẩm</h3>
                    <p>Sử dụng thanh tìm kiếm hoặc danh mục để tìm các bộ dụng cụ STEM theo độ tuổi, chủ đề hoặc kỹ
                        năng.</p>
                </div>
                <div class="step-card">
                    <i class="fa-solid fa-box-open"></i>
                    <h3>Bước 2: Xem chi tiết</h3>
                    <p>Nhấp vào từng sản phẩm để xem mô tả, hình ảnh, hướng dẫn lắp ráp và đánh giá người dùng.</p>
                </div>
                <div class="step-card">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <h3>Bước 3: Thêm vào giỏ hàng</h3>
                    <p>Chọn số lượng và thêm vào giỏ. Bạn có thể kiểm tra lại đơn hàng trước khi thanh toán.</p>
                </div>
                <div class="step-card">
                    <i class="fa-solid fa-headset"></i>
                    <h3>Bước 4: Liên hệ & hỗ trợ</h3>
                    <p>Gặp khó khăn? Liên hệ với chúng tôi qua chat, hotline hoặc email để được hỗ trợ 24/7.</p>
                </div>
            </div>
        </div>
    </section>


    <!-- 2️⃣ LỢI ÍCH KHI HỌC STEM -->
    <section class="guide-benefits">
        <div class="container">
            <h2>Lợi ích khi học STEM cùng STEMSHOP</h2>
            <div class="benefits-grid">
                <div class="benefit-card">
                    <i class="fa-solid fa-brain"></i>
                    <h3>Tư duy logic</h3>
                    <p>Giúp trẻ phát triển khả năng tư duy phân tích và giải quyết vấn đề thực tế.</p>
                </div>
                <div class="benefit-card">
                    <i class="fa-solid fa-rocket"></i>
                    <h3>Sáng tạo & thực hành</h3>
                    <p>Học sinh được tự tay lắp ráp, thử nghiệm và sáng chế mô hình thật.</p>
                </div>
                <div class="benefit-card">
                    <i class="fa-solid fa-people-group"></i>
                    <h3>Làm việc nhóm</h3>
                    <p>Khuyến khích tinh thần hợp tác, trao đổi ý tưởng và cùng nhau học tập.</p>
                </div>
                <div class="benefit-card">
                    <i class="fa-solid fa-earth-asia"></i>
                    <h3>Hội nhập công nghệ</h3>
                    <p>Tiếp cận sớm công nghệ, lập trình và kỹ năng số trong thời đại 4.0.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- 3️⃣ MỞ RỘNG WEB ĐỘNG -->
    <section class="guide-future">
        <div class="container">
            <h2>Hướng phát triển trong tương lai</h2>
            <p>
                Trong phiên bản tiếp theo, STEMSHOP sẽ được phát triển thành <strong>web động</strong> bằng cách kết
                nối với cơ sở dữ liệu <strong>MySQL</strong>.
            </p>
            <ul>
                <li><i class="fa-solid fa-database"></i> Quản lý sản phẩm: thông tin, giá, tồn kho được lưu trong
                    bảng <code>products</code>.</li>
                <li><i class="fa-solid fa-user"></i> Hệ thống tài khoản khách hàng trong bảng <code>users</code>.
                </li>
                <li><i class="fa-solid fa-cart-shopping"></i> Giỏ hàng và đơn hàng trong bảng <code>orders</code>.
                </li>
                <li><i class="fa-solid fa-book"></i> Bảng <code>guides</code> lưu các bài hướng dẫn, bài viết chia
                    sẻ và nội dung học liệu.</li>
            </ul>
            <p>
                Từ đó, website có thể <strong>hiển thị tự động</strong> nội dung từ CSDL mà không cần chỉnh HTML thủ
                công — giúp quản trị viên dễ dàng cập nhật, và người dùng luôn thấy thông tin mới nhất.
            </p>
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
