


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.T STEMSHOP - Học Tập STEM Sáng Tạo - POLICY</title>


    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/policy.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>
<!--HEADER-->
<%@ include file="/WEB-INF/components/header.jsp" %>

<!-- MAIN -->

<main class="policy-container">
    <div class="back">
        <a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-arrow-left"></i> Quay lại trang Chủ</a>
    </div>


    <div class="policy-header">
        <h1><i class="fa-solid fa-file-shield"></i> Chính sách bảo hành & đổi trả</h1>
        <p>
            <strong>STEMSHOP</strong> cam kết mang đến sản phẩm chất lượng cao, an toàn và trải nghiệm mua sắm tin cậy cho
            phụ huynh & học sinh.
        </p>
    </div>

    <!-- I. BẢO HÀNH -->
    <section class="policy-section">
        <h2><i class="fa-solid fa-shield-heart"></i> 1. Chính sách bảo hành</h2>
        <p>
            Tất cả sản phẩm của <strong>STEMSHOP</strong> được bảo hành theo quy định cụ thể cho từng loại sản phẩm.
        </p>
        <ul>
            <li>
                <i class="fa-regular fa-clock"></i> Thời gian bảo hành:
                <strong>6 tháng</strong> kể từ ngày nhận hàng đối với sản phẩm điện tử hoặc bộ kit có mạch điều khiển.
            </li>
            <li>
                <i class="fa-solid fa-screwdriver-wrench"></i> Sản phẩm lỗi do nhà sản xuất (linh kiện hỏng, mạch lỗi, phụ kiện
                thiếu) sẽ được đổi mới miễn phí.
            </li>
            <li>
                <i class="fa-solid fa-ban"></i> Không bảo hành nếu sản phẩm bị:
                <ul>
                    <li>Rơi vỡ, vào nước, cháy nổ, tác động vật lý mạnh.</li>
                    <li>Sửa chữa hoặc can thiệp bởi bên thứ ba không thuộc hệ thống STEMSHOP.</li>
                </ul>
            </li>
        </ul>
    </section>

    <!-- II. ĐỔI TRẢ -->
    <section class="policy-section">
        <h2><i class="fa-solid fa-rotate-left"></i> 2. Chính sách đổi trả</h2>
        <ul>
            <li><i class="fa-solid fa-box"></i> Hỗ trợ đổi trả trong vòng <strong>7 ngày</strong> kể từ khi nhận hàng.</li>
            <li><i class="fa-solid fa-tag"></i> Sản phẩm còn nguyên vẹn, chưa qua sử dụng, còn tem mác & bao bì.</li>
            <li><i class="fa-solid fa-receipt"></i> Có hóa đơn hoặc thông tin xác thực đơn hàng.</li>
            <li><i class="fa-solid fa-truck-fast"></i> Đổi miễn phí nếu giao sai mẫu hoặc sản phẩm lỗi kỹ thuật.</li>
            <li><i class="fa-solid fa-money-bill-transfer"></i> Trường hợp đổi do chọn sai, khách chịu phí vận chuyển hai
                chiều.</li>
        </ul>
    </section>

    <!-- III. HOÀN TIỀN -->
    <section class="policy-section">
        <h2><i class="fa-solid fa-wallet"></i> 3. Chính sách hoàn tiền</h2>
        <ul>
            <li><i class="fa-solid fa-check"></i> Hoàn 100% giá trị đơn hàng nếu sản phẩm không còn hàng để đổi.</li>
            <li><i class="fa-regular fa-calendar-days"></i> Thời gian xử lý hoàn tiền: <strong>5–7 ngày làm việc</strong>.</li>
            <li><i class="fa-solid fa-building-columns"></i> Phương thức hoàn: chuyển khoản ngân hàng hoặc ví điện tử.</li>
        </ul>
    </section>

    <!-- IV. LIÊN HỆ -->
    <section class="policy-section">
        <h2><i class="fa-solid fa-headset"></i> 4. Hỗ trợ & liên hệ</h2>
        <ul>
            <li><i class="fa-solid fa-phone"></i> Hotline: <strong>0123 456 789</strong></li>
            <li><i class="fa-solid fa-envelope"></i> Email:
                <a href="mailto"> shopstemteam22@gmail.com</a>
            </li>
            <li><i class="fa-solid fa-location-dot"></i> Địa chỉ: VQCR+GP6, khu phố 6, Thủ Đức, Thành phố Hồ Chí Minh</li>
        </ul>
    </section>
</main>

<!--FOOTER-->
<%@ include file="/WEB-INF/components/footer.jsp" %>



</body>

</html>

