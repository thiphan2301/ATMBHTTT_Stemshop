<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>



<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>STEAM SHOP</title>
    <!--LINK _ HOME-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/home.css">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>
<!-- HEADER -->
<%@ include file="/WEB-INF/components/header.jsp" %>

<main>
    <!--SECTION: HERO BANNER-->
    <section class="section-hero">
        <div class="section-hero__bg">
            <!--chứa ảnh bg-->
        </div>
        <div class="section-hero__content">
            <div class="container">
                <h1 class="section-hero__title">
                    Khơi dậy niềm đam mê khoa học và sáng tạo cùng STEMSHOP!
                </h1>
                <div class="section-hero__highlight">
                    Khám phá bộ kit STEM, robot, coding kits giúp trẻ học mà chơi!
                </div>
                <a href="${pageContext.request.contextPath}/shop" class="section-hero__cta">Khám phá ngay</a>
                <div class="section-hero__suggestions">
                    <p><strong>Gợi ý:</strong> Bộ kit khoa học, Robot lập trình, Kit điện tử, Máy thí nghiệm mini…</p>
                    <ul class="section-hero__suggestions-list">
                        <li>Bộ kit STEM cho trẻ 6-10 tuổi</li>
                        <li>Robot lập trình & coding kits</li>
                        <li>Thí nghiệm hóa học / vật lý đơn giản</li>
                        <li>Đồ chơi khoa học sáng tạo</li>
                    </ul>
                </div>
            </div>
        </div>
    </section>

    <!--SECTION: DANH MỤC NỔI BẬT-->
    <section class="section-category-hightlight">
        <div class="container">
            <h3 class="subtitle">Danh mục nổi bật</h3>
            <h1 class="category-title">KHÁM PHÁ THẾ GIỚI STEM THÚ VỊ</h1>
            <p class="category-subtitle">Lựa chọn chủ đề mà bạn yêu thích để bắt đầu hành trình sáng tạo!</p>

            <div class="category-grid">
                <div class="category-item">
                    <img src="${pageContext.request.contextPath}/assets/images/products/Robot%20lập%20trình%20Scratch.png" alt="Robot - Lập Trình">
                    <h3>Robot - Lập Trình</h3>
                </div>

                <div class="category-item">
                    <img src="${pageContext.request.contextPath}/assets/images/products/Kit%20STEM%20Arduino%20cơ%20bản.png" alt="Kỹ Thuật – Cơ Khí">
                    <h3>Kỹ Thuật – Cơ Khí</h3>
                </div>

                <div class="category-item">
                    <img src="${pageContext.request.contextPath}/assets/images/workshop/math.jpg" alt="Toán Học – Logic">
                    <h3>Toán Học – Logic</h3>
                </div>

                <div class="category-item">
                    <img src="${pageContext.request.contextPath}/assets/images/products/Bộ%20lắp%20ráp%20cơ%20khí%20cho%20trẻ%20em.png" alt="Khoa Học - Thí Nghiệm">
                    <h3>Khoa Học - Thí Nghiệm</h3>
                </div>

                <div class="category-item">
                    <img src="${pageContext.request.contextPath}/assets/images/workshop/chemistry.jpg" alt="Sáng Tạo - Nghệ Thuật">
                    <h3>Sáng Tạo - Nghệ Thuật</h3>
                </div>
            </div>
        </div>
    </section>
    <style>
        /* Override CSS để fix kích thước ảnh sản phẩm */
        .product-card__image {
            position: relative !important;
            width: 100% !important;
            height: 220px !important;
            margin-bottom: 15px !important;
            overflow: hidden !important;
            border-radius: 15px !important;
            background: #f5f5f5 !important;
        }

        .product-card__image a {
            display: block !important;
            width: 100% !important;
            height: 100% !important;
        }

        .product-card__image img,
        .product-card img {
            width: 100% !important;
            height: 220px !important;
            min-height: 220px !important;
            max-height: 220px !important;
            object-fit: cover !important;
            border-radius: 15px !important;
            display: block !important;
        }
    </style>
    <!-- SECTION: SẢN PHẨM MỚI NHẤT -->
    <section class="section-featured-products">
        <div class="container">
            <h3 class="subtitle">SẢN PHẨM MỚI NHẤT</h3>
            <h1 class="featured-products-title">
                Khám phá các sản phẩm mới nhất
                <br>giúp bé học qua làm và phát triển kỹ năng tương lai
            </h1>
            <p class="featured-products-subtitle">
                Xem chi tiết từng bộ, so sánh và chọn kit phù hợp với độ tuổi —
                mua ngay, trải nghiệm ngay hôm nay!
            </p>
            <div class="feature-products-grid">
                <!-- Hàng trên: 3 sản phẩm đầu -->
                <div class="products-top">
                    <c:forEach var="product" items="${products}" begin="0" end="2">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}${product.imageUrl}"
                                 alt="${product.productName}">
                            <h2 class="product-name">${product.productName}</h2>
                            <p class="product-desc">${product.description}</p>
                            <span class="product-price">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> VNĐ
                        </span>
                            <button class="btn-add-cart">
                                <a href="${pageContext.request.contextPath}/add-to-cart?id=${product.id}">
                                    Thêm vào giỏ hàng <i class="fa fa-plus"></i>
                                </a>
                            </button>
                        </div>
                    </c:forEach>
                </div>

                <!-- Hàng dưới: 3 sản phẩm tiếp -->
                <div class="products-bottom">
                    <c:forEach var="product" items="${products}" begin="3" end="5">
                        <div class="product-card">
                            <img src="${pageContext.request.contextPath}${product.imageUrl}"
                                 alt="${product.productName}">
                            <h2 class="product-name">${product.productName}</h2>
                            <p class="product-desc">${product.description}</p>
                            <span class="product-price">
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> VNĐ
                        </span>
                            <button class="btn-add-cart">
                                <a href="${pageContext.request.contextPath}/add-to-cart?id=${product.id}">
                                    Thêm vào giỏ hàng <i class="fa fa-plus"></i>
                                </a>
                            </button>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="featured-products-viewshop">
                <a href="${pageContext.request.contextPath}/shop">
                    Xem tất cả <i class="fa-solid fa-eye"></i>
                </a>
            </div>
        </div>
    </section>

    <!--SECTION: GIỚI THIỆU STEMSHOP-->
    <section class="section-about-hightlight">
        <img src="${pageContext.request.contextPath}/assets/images/banner/school-bg.jpeg" alt="" class="bg-img">
        <div class="container">
            <div class="about-left">
                <img src="${pageContext.request.contextPath}/assets/images/banner/kid-study-2.png" alt="Giới thiệu STEMSHOP">
            </div>
            <div class="about-right">
                <h3 class="subtitle">Về chúng tôi</h3>
                <h1 class="about-title">Khơi nguồn sáng tạo qua học tập STEM</h1>
                <p class="about-desc">
                    STEMSHOP là nơi mang đến những sản phẩm, khóa học và bộ kit STEM giúp trẻ phát triển tư duy logic,
                    khả năng sáng tạo và niềm đam mê khám phá thế giới. Chúng tôi tin rằng học tập qua thực hành là
                    con đường tốt nhất để chạm tới tri thức.
                </p>
                <div class="about-skills">
                    <div class="skill">
                        <span class="skill-name">Khoa học & Công nghệ</span>
                        <div class="skill-bar"><span class="fill" style="width: 90%"></span></div>
                    </div>
                    <div class="skill">
                        <span class="skill-name">Kỹ năng sáng tạo</span>
                        <div class="skill-bar"><span class="fill" style="width: 85%"></span></div>
                    </div>
                    <div class="skill">
                        <span class="skill-name">Tư duy logic</span>
                        <div class="skill-bar"><span class="fill" style="width: 80%"></span></div>
                    </div>
                </div>
                <a href="${pageContext.request.contextPath}/view/main/about.jsp" class="btn-about">Tìm hiểu thêm</a>
            </div>
        </div>
    </section>

    <!--SECTION: Ưu điểm / Lợi ích học STEM -->
    <section class="section-why-choose-us">
        <div class="container">
            <h3 class="subtitle">VÌ SAO NÊN CHỌN HỌC STEM?</h3>
            <h1 class="why-title">Học qua trải nghiệm – Phát triển toàn diện cho trẻ</h1>
            <p class="why-subtitle">
                Tại STEAM Shop, chúng tôi mang đến môi trường học tập sáng tạo, giúp trẻ tự mình khám phá,
                thử nghiệm và phát triển kỹ năng cần thiết cho tương lai.
            </p>
            <div class="why-grid">
                <div class="why-item">
                    <i class="fa-solid fa-flask-vial"></i>
                    <h3>Học qua trải nghiệm thực tế</h3>
                    <p>Tự tay lắp ráp, thử nghiệm và khám phá nguyên lý khoa học trong mỗi sản phẩm.</p>
                </div>

                <div class="why-item">
                    <i class="fa-solid fa-brain"></i>
                    <h3>Rèn luyện tư duy sáng tạo</h3>
                    <p>Khuyến khích trẻ tìm ra nhiều cách giải quyết vấn đề khác nhau, không ngại sai.</p>
                </div>

                <div class="why-item">
                    <i class="fa-solid fa-shield-heart"></i>
                    <h3>An toàn, chất lượng cao</h3>
                    <p>Tất cả kit được chọn lọc kỹ, thân thiện và đạt tiêu chuẩn an toàn cho trẻ nhỏ.</p>
                </div>

                <div class="why-item">
                    <i class="fa-solid fa-people-group"></i>
                    <h3>Phát triển kỹ năng hợp tác</h3>
                    <p>Cùng nhau sáng tạo và chia sẻ ý tưởng để tạo ra sản phẩm hoàn chỉnh.</p>
                </div>
            </div>
        </div>
    </section>

    <!--SECTION: Blog / Kiến thức STEM -->
    <section class="section-blog">
        <div class="container">
            <h3 class="subtitle">Bài viết mới nhất</h3>
            <h1 class="blog-title">Khám phá thế giới khoa học – Công nghệ – Sáng tạo cùng STEAM Shop</h1>
            <p class="blog-subtitle">
                Cập nhật tin tức, hướng dẫn và mẹo học STEM thú vị giúp trẻ phát triển tư duy sáng tạo,
                yêu thích khám phá và học hỏi không ngừng.
            </p>

            <div class="blog-grid">
                <div class="blog-card">
                    <img src="${pageContext.request.contextPath}/assets/images/blog/Lợi ích học STEM sớm cho trẻ em.jpg" alt="Lợi ích học STEM sớm">
                    <div class="blog-content">
                        <h2>Lợi ích học STEM sớm cho trẻ em</h2>
                        <p>Khám phá tại sao việc cho trẻ tiếp xúc với STEM từ sớm giúp phát triển tư duy logic,
                            khả năng sáng tạo và kỹ năng giải quyết vấn đề vượt trội.</p>
                        <a href="${pageContext.request.contextPath}/view/content/blog-detail" class="btn-readmore">
                            Đọc thêm <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <div class="blog-card">
                    <img src="${pageContext.request.contextPath}/assets/images/blog/Hướng dẫn chọn kit STEM phù hợp.jpg" alt="Hướng dẫn chọn kit STEM phù hợp">
                    <div class="blog-content">
                        <h2>Hướng dẫn chọn bộ Kit STEM phù hợp độ tuổi</h2>
                        <p>Chọn đúng bộ sản phẩm giúp trẻ học hiệu quả hơn – từ robot, hóa học, cơ khí đến sáng tạo nghệ thuật.</p>
                        <a href="${pageContext.request.contextPath}/view/content/blog-detail" class="btn-readmore">
                            Đọc thêm <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>
                </div>

                <div class="blog-card">
                    <img src="${pageContext.request.contextPath}/assets/images/blog/STEM trong đời sống.jpg" alt="STEM trong đời sống">
                    <div class="blog-content">
                        <h2>STEM trong đời sống – Học qua những điều quen thuộc</h2>
                        <p>Từ làm bánh, trồng cây đến chế tạo đồ chơi, STEM có mặt khắp nơi – chỉ cần bé đủ tò mò để khám phá!</p>
                        <a href="${pageContext.request.contextPath}/view/content/blog-detail" class="btn-readmore">
                            Đọc thêm <i class="fa-solid fa-arrow-right"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="blog-viewall">
                <a href="${pageContext.request.contextPath}/view/content/blog.jsp">Xem tất cả bài viết <i class="fa-solid fa-eye"></i></a>
            </div>
        </div>
    </section>

    <!-- SECTION: Hoạt động học tập / Workshop & Gallery -->
    <section class="section-workshop">
        <div class="container">
            <h3 class="subtitle">Học qua trải nghiệm</h3>
            <h1 class="workshop-title">Khoảnh khắc học tập sáng tạo cùng STEM</h1>

            <div class="workshop-gallery">
                <div class="gallery-item">
                    <img src="https://ohstem.vn/wp-content/uploads/2024/02/huong-dan-lap-trinh-nhieu-man-hinh-i2c-voi-yolo-uno-ohstem-avt.png" alt="Workshop STEM 1">
                </div>
                <div class="gallery-item">
                    <img src="https://ohstem.vn/wp-content/uploads/2021/09/Robot-ne-vat-can.jpg" alt="Workshop STEM 2">
                    <h3>Làm robot tránh vật cản</h3>
                </div>
                <div class="gallery-item">
                    <img src="https://ohstem.vn/wp-content/uploads/2021/02/B46.png" alt="Workshop STEM 3">
                </div>
                <div class="gallery-item">
                    <img src="https://ohstem.vn/wp-content/uploads/2021/09/lap-trinh-LED-doi-mau.jpg" alt="Workshop STEM 4">
                </div>
            </div>

            <div class="workshop-viewmore">
                <a href="${pageContext.request.contextPath}/view/workshop/materials.jsp" class="btn-view-all">
                    Xem tất cả dự án <i class="fa-solid fa-arrow-right"></i>
                </a>
            </div>
        </div>
    </section>

    <!-- SECTION: Đánh giá / Cảm nhận khách hàng -->
    <section class="section-customer-reviews">
        <div class="container">
            <h3 class="subtitle">Đánh giá của khách hàng</h3>
            <h1 class="review-title">Phụ huynh & học sinh nói gì về STEM Shop</h1>

            <div class="reviews-grid">
                <div class="review-card">
                    <img src="${pageContext.request.contextPath}/assets/images/workshop/rate/ảnh-phụ-huynh-học-sinh-1.jpg" alt="Phụ huynh 1" class="review-avatar">
                    <p class="review-quote">
                        "Bé nhà tôi rất thích bộ Kit Khoa Học Vui — vừa học vừa chơi, cực kỳ bổ ích và an toàn!"
                    </p>
                    <h4 class="review-name">Nguyễn Thị Minh Hạnh</h4>
                    <span class="review-role">Phụ huynh học sinh lớp 4</span>
                </div>

                <div class="review-card">
                    <img src="${pageContext.request.contextPath}/assets/images/workshop/rate/ảnh-phụ-huynh-học-sinh-2.jpg" alt="Giáo viên" class="review-avatar">
                    <p class="review-quote">
                        "Sản phẩm chất lượng, giúp học sinh dễ hiểu hơn trong các tiết học STEM trên lớp."
                    </p>
                    <h4 class="review-name">Trần Văn Thắng</h4>
                    <span class="review-role">Giáo viên Khoa học</span>
                </div>

                <div class="review-card">
                    <img src="${pageContext.request.contextPath}/assets/images/workshop/rate/ảnh-học-sinh-nam-1.jpg" alt="Học sinh" class="review-avatar">
                    <p class="review-quote">
                        "Em thích nhất là được tự tay lắp robot chạy bằng pin mặt trời. Rất vui và thú vị!"
                    </p>
                    <h4 class="review-name">Lê Hoàng Minh</h4>
                    <span class="review-role">Học sinh lớp 6</span>
                </div>
            </div>
        </div>
    </section>

    <!--SECTION: Đăng ký nhận bản tin -->
    <section class="section-newsletter">
        <div class="container">
            <div class="section-newsletter__img">
                <img src="${pageContext.request.contextPath}/assets/images/newsletter/steamEducation-1-HOME-newslettes.jpg" alt="newsletter1">
                <img src="${pageContext.request.contextPath}/assets/images/newsletter/steamEducation-2-HOME-newslettes.jpg" alt="newsletter2">
            </div>
            <div class="section-newsletter__form">
                <h1><i class="fa-solid fa-envelope"></i>
                    Nhận bản tin STEM thú vị mỗi tuần cùng chúng tôi! 3.T STEMSHOP</h1>
                <p>Đăng ký nhận email để nhận tài liệu học STEM miễn phí,
                    <br> khuyến mãi sản phẩm và thông tin workshop mới nhất từ 3.T STEAM SHOP.
                </p>
                <form action="">
                    <div class="form-infomation">
                        <input type="text" name="name" id="name" placeholder="Họ và tên">
                        <input type="email" name="email" id="email" placeholder="Email">
                    </div>
                    <input type="tel" name="tel" id="tel" placeholder="Số điện thoại">
                    <textarea name="mesage" id="message" placeholder="Lời nhắn đến chúng tôi" maxlength="30"></textarea>
                    <button type="button">GỬI YÊU CẦU <i class="fa fa-paper-plane" aria-hidden="true"></i></button>
                </form>
            </div>
        </div>
    </section>

    <div class="back-to-top">
        <img src="${pageContext.request.contextPath}/assets/images/shop/back-to-top.png" alt="back-to-top">
    </div>
</main>

<!-- FOOTER -->
<%@ include file="/WEB-INF/components/footer.jsp" %>

</body>
</html>