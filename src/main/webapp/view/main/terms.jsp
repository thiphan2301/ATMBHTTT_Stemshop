


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.T STEMSHOP - Học Tập STEM Sáng Tạo - TERMS</title>


    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/terms.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>
<!--HEADER-->
<%@ include file="/WEB-INF/components/header.jsp" %>

<!-- MAIN -->
<main class="terms-container">
    <div class="back">
        <a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-arrow-left"></i> Quay lại trang Chủ</a>
    </div>
    <div class="terms-header">
        <h1><i class="fa-solid fa-scale-balanced"></i> Điều khoản sử dụng</h1>
        <p>
            Khi truy cập và mua sắm tại <strong>STEMSHOP</strong>, Quý khách đồng ý tuân thủ các điều khoản và điều kiện dưới đây.
            Vui lòng đọc kỹ để đảm bảo quyền lợi của mình.
        </p>
    </div>

    <!-- I. TỔNG QUAN -->
    <section class="terms-section">
        <h2><i class="fa-solid fa-circle-info"></i> 1. Giới thiệu chung</h2>
        <p>
            Trang web <strong>STEMSHOP.vn</strong> thuộc quyền sở hữu và quản lý của Công ty TNHH 3.T STEMSHOP.
            Mục tiêu của chúng tôi là cung cấp sản phẩm học tập STEM chất lượng, an toàn và truyền cảm hứng sáng tạo cho trẻ em.
        </p>
    </section>

    <!-- II. QUYỀN & NGHĨA VỤ NGƯỜI DÙNG -->
    <section class="terms-section">
        <h2><i class="fa-solid fa-user-shield"></i> 2. Quyền và nghĩa vụ của người dùng</h2>
        <ul>
            <li><i class="fa-solid fa-check"></i> Cung cấp thông tin chính xác khi đăng ký hoặc đặt hàng.</li>
            <li><i class="fa-solid fa-ban"></i> Không sử dụng website để đăng tải, phát tán nội dung vi phạm pháp luật hoặc thuần phong mỹ tục.</li>
            <li><i class="fa-solid fa-triangle-exclamation"></i> Không can thiệp trái phép vào hệ thống hoặc sử dụng trái phép thông tin của người khác.</li>
            <li><i class="fa-solid fa-envelope"></i> Có quyền yêu cầu hỗ trợ, khiếu nại hoặc yêu cầu bảo mật thông tin cá nhân.</li>
        </ul>
    </section>

    <!-- III. TRÁCH NHIỆM CỦA STEMSHOP -->
    <section class="terms-section">
        <h2><i class="fa-solid fa-store"></i> 3. Trách nhiệm của STEMSHOP</h2>
        <ul>
            <li><i class="fa-solid fa-certificate"></i> Đảm bảo cung cấp thông tin sản phẩm chính xác, minh bạch và cập nhật.</li>
            <li><i class="fa-solid fa-shield-heart"></i> Cam kết bảo mật thông tin cá nhân của khách hàng theo chính sách bảo mật.</li>
            <li><i class="fa-solid fa-box-open"></i> Đảm bảo sản phẩm giao đến khách hàng đúng mô tả, chất lượng và thời gian cam kết.</li>
            <li><i class="fa-solid fa-headset"></i> Cung cấp kênh hỗ trợ, tiếp nhận phản hồi và giải quyết khiếu nại kịp thời.</li>
        </ul>
    </section>

    <!-- IV. THANH TOÁN & GIAO HÀNG -->
    <section class="terms-section">
        <h2><i class="fa-solid fa-money-bill-wave"></i> 4. Thanh toán & giao hàng</h2>
        <ul>
            <li><i class="fa-solid fa-credit-card"></i> Hỗ trợ thanh toán qua chuyển khoản, ví điện tử hoặc COD (thanh toán khi nhận hàng).</li>
            <li><i class="fa-solid fa-truck-fast"></i> Thời gian giao hàng phụ thuộc khu vực và được thông báo cụ thể khi đặt đơn.</li>
            <li><i class="fa-solid fa-exclamation-circle"></i> STEMSHOP không chịu trách nhiệm với các đơn hàng sai địa chỉ do lỗi cung cấp thông tin của khách hàng.</li>
        </ul>
    </section>

    <!-- V. SỞ HỮU TRÍ TUỆ -->
    <section class="terms-section">
        <h2><i class="fa-solid fa-lightbulb"></i> 5. Quyền sở hữu trí tuệ</h2>
        <p>
            Tất cả nội dung, hình ảnh, thiết kế, logo và dữ liệu hiển thị trên website <strong>STEMSHOP.vn</strong>
            thuộc quyền sở hữu của 3.T STEMSHOP. Mọi hành vi sao chép, sử dụng mà không có sự cho phép đều bị nghiêm cấm.
        </p>
    </section>

    <!-- VI. THAY ĐỔI ĐIỀU KHOẢN -->
    <section class="terms-section">
        <h2><i class="fa-solid fa-pen-to-square"></i> 6. Thay đổi và cập nhật điều khoản</h2>
        <p>
            <strong>STEMSHOP</strong> có thể thay đổi, cập nhật nội dung của Điều khoản sử dụng mà không cần thông báo trước.
            Các thay đổi sẽ có hiệu lực ngay khi được đăng tải lên website.
        </p>
    </section>

    <!-- VII. LIÊN HỆ -->
    <section class="terms-section">
        <h2><i class="fa-solid fa-headset"></i> 7. Liên hệ</h2>
        <ul>
            <li><i class="fa-solid fa-phone"></i> Hotline: <strong>0123 456 789</strong></li>
            <li><i class="fa-solid fa-envelope"></i> Email:    <a href="mailto"> shopstemteam22@gmail.com</a></li>
            <li><i class="fa-solid fa-location-dot"></i> Địa chỉ: VQCR+GP6, khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh</li>
        </ul>
    </section>
</main>

<!--FOOTER-->
<%@ include file="/WEB-INF/components/footer.jsp" %>




</body>

</html>

