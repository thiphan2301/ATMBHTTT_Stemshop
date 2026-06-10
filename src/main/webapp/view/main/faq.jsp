


<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.T STEMSHOP - Học Tập STEM Sáng Tạo - FAQ</title>


    <!--LINK CSS-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/faq.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>
<!--HEADER-->
<%@ include file="/WEB-INF/components/header.jsp" %>
<!--MAIN-->

<main class="faq">

    <div class="container">
        <div class="back">
            <a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-arrow-left"></i> Quay lại trang Chủ</a>
        </div>
        <section class="faq__header">

            <h1 class="faq__title">❓ Câu hỏi thường gặp</h1>
            <p class="faq__intro">Giải đáp các thắc mắc phổ biến khi mua hàng và sử dụng sản phẩm STEM tại STEAM
                Shop.
            </p>

        </section>

        <section class="faq__list">
            <!--....-->
            <article class="faq__item">
                <h2 class="faq__question">1. STEM là gì?</h2>
                <p class="faq__answer">
                    STEM là viết tắt của bốn lĩnh vực chính: Science (Khoa học), Technology (Công nghệ), Engineering
                    (Kỹ
                    thuật) và Mathematics (Toán học).
                    Giáo dục STEM giúp trẻ học thông qua thực hành và trải nghiệm, phát triển tư duy logic, khả năng
                    sáng tạo và giải quyết vấn đề.
                </p>
            </article>
            <!--....-->
            <article class="faq__item">
                <h2 class="faq__question">2. Tại sao nên cho trẻ học và chơi với dụng cụ STEM?</h2>
                <p class="faq__answer">
                    Các sản phẩm STEM giúp trẻ em khám phá thế giới khoa học qua việc lắp ráp, thử nghiệm và sáng
                    tạo.
                    Qua đó, trẻ hình thành kỹ năng tư duy phản biện, học cách làm việc nhóm và yêu thích khám phá.
                </p>
            </article>
            <!--....-->
            <article class="faq__item">
                <h2 class="faq__question">3. Sản phẩm phù hợp với độ tuổi nào?</h2>
                <p class="faq__answer">
                    Hầu hết các sản phẩm tại STEAM Shop phù hợp cho học sinh từ 6 đến 15 tuổi.
                    Mỗi bộ sản phẩm đều có hướng dẫn chi tiết và độ khó tương ứng để phụ huynh dễ lựa chọn.
                </p>
            </article>
            <!--....-->
            <article class="faq__item">
                <h2 class="faq__question">4. Làm sao chọn sản phẩm phù hợp cho con?</h2>
                <p class="faq__answer">
                    Phụ huynh có thể tham khảo danh mục sản phẩm theo độ tuổi, lĩnh vực STEM hoặc mục tiêu học tập.
                    Ngoài ra, đội ngũ STEAM Shop sẵn sàng tư vấn trực tiếp qua email hoặc hotline hỗ trợ.
                </p>
            </article>
            <!--....-->
            <article class="faq__item">
                <h2 class="faq__question">5. Chính sách đổi trả và bảo hành như thế nào?</h2>
                <p class="faq__answer">
                    Sản phẩm bị lỗi do nhà sản xuất hoặc giao sai có thể được đổi trả trong vòng 7 ngày.
                    Chi tiết xem tại trang <a href="policy.html">Chính sách bảo hành & đổi trả</a>.
                </p>
            </article>
            <!--....-->
            <article class="faq__item">
                <h2 class="faq__question">6. Tôi có thể thanh toán như thế nào?</h2>
                <p class="faq__answer">
                    Chúng tôi hỗ trợ thanh toán qua chuyển khoản, ví điện tử hoặc COD (thanh toán khi nhận hàng).
                    Mọi giao dịch đều được mã hóa và bảo mật an toàn.
                </p>
            </article>
            <!--....-->
            <article class="faq__item">
                <h2 class="faq__question">7. Tôi có thể liên hệ với STEAM Shop ở đâu?</h2>
                <p class="faq__answer">
                    Bạn có thể gửi thư đến email <b> <a href="" target="_blank"><span><i class="fa-solid fa-envelope"></i>
                        shopstemteam22@gmail.com</span>
                </a></b> hoặc qua form liên hệ tại trang <a
                        href="contact.html">Liên hệ</a>.
                    Đội ngũ hỗ trợ sẽ phản hồi trong vòng 24 giờ làm việc.
                </p>
            </article>
        </section>
    </div>
</main>

<!--FOOTER-->
<%@ include file="/WEB-INF/components/footer.jsp" %>




</body>

</html>

