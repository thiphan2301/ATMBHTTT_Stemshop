<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chính sách trả góp</title>

    <!-- CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/chinh-sach-tra-gop.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>

<body>

<!-- HEADER -->
<jsp:include page="/WEB-INF/components/header.jsp"/>

<main>

    <!-- breadcrumb -->
    <div class="back">
        <a href="${pageContext.request.contextPath}/shop">
            <i class="fa-solid fa-arrow-left"></i> Tiếp tục mua sắm
        </a>
    </div>

    <div class="warranty-containers">

        <!-- header -->
        <div class="head">
            <h2>Chính Sách Trả Góp</h2>
            <p>
                Nhằm mang đến trải nghiệm mua sắm tiện lợi và linh hoạt hơn cho khách hàng,
                STEMSHOP triển khai chương trình mua hàng trả góp với các điều khoản cụ thể như sau:
            </p>
        </div>

        <!-- 1. Đối tượng -->
        <div class="warranty">
            <h3><i class="fa-regular fa-user"></i> 1. Đối tượng áp dụng</h3>
            <ul>
                <li>Áp dụng cho mọi khách hàng cá nhân mua sắm tại website.</li>
                <li>Đơn hàng từ <strong>3.000.000 VNĐ</strong> trở lên (sau khuyến mãi nếu có).</li>
            </ul>
        </div>

        <!-- 2. Kỳ hạn -->
        <div class="warranty">
            <h3><i class="fa-solid fa-calendar-days"></i> 2. Kỳ hạn trả góp</h3>
            <ul>
                <li>3 tháng</li>
                <li>6 tháng</li>
            </ul>
        </div>

        <!-- 3. Điều khoản -->
        <div class="warranty">
            <h3><i class="fa-solid fa-clipboard-list"></i> 3. Điều khoản & điều kiện</h3>
            <ol>
                <li>Áp dụng cho thẻ tín dụng Visa, MasterCard, JCB, Amex.</li>
                <li>Không áp dụng thẻ ghi nợ (Debit).</li>
                <li>Giao dịch trả góp do ngân hàng xử lý.</li>
                <li>Ngân hàng có thể thu thêm phí quản lý trả góp.</li>
                <li>Đơn hàng trả góp không áp dụng hoàn tiền theo nhu cầu cá nhân.</li>
            </ol>
        </div>

        <!-- 4. Quy trình -->
        <div class="warranty">
            <h3>4. Quy trình đăng ký trả góp</h3>
            <ul>
                <li>Chọn sản phẩm có tổng giá trị ≥ 3.000.000 VNĐ.</li>
                <li>Chọn hình thức “Trả góp qua thẻ tín dụng”.</li>
                <li>Chọn ngân hàng và kỳ hạn mong muốn.</li>
                <li>Hoàn tất thanh toán.</li>
            </ul>
        </div>

        <!-- 5. Bảo mật -->
        <div class="warranty">
            <h3>5. Bảo mật thông tin</h3>
            <p>
                STEMSHOP cam kết bảo mật tuyệt đối thông tin khách hàng
                và chỉ chia sẻ trong các trường hợp cần thiết theo quy định pháp luật.
            </p>
        </div>

        <!-- 6. Trường hợp từ chối -->
        <div class="warranty">
            <h3>6. Trường hợp ngân hàng từ chối</h3>
            <ul>
                <li>Thẻ tín dụng không đủ hạn mức.</li>
                <li>Thẻ sắp hết hạn.</li>
                <li>Khách hàng đang nợ quá hạn.</li>
            </ul>
        </div>

        <!-- hỗ trợ -->
        <div class="warranty contact-support">
            <h3><i class="fa-solid fa-phone"></i> Liên hệ hỗ trợ</h3>
            <p>Hotline: <strong>1900 xxxx</strong></p>
            <p>Email: <strong>shopstemteam22@gmail.com</strong></p>
            <p>Thời gian: 8:00 – 21:00 (T2 – CN)</p>
        </div>

    </div>
</main>

<!-- FOOTER -->
<jsp:include page="/WEB-INF/components/footer.jsp"/>

</body>
</html>
