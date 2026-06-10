<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>STEAM SHOP - Khơi Nguồn Sáng Tạo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/home.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>

<body>

<c:if test="${not empty sessionScope.lockError}">
    <script>
        alert("${sessionScope.lockError}");
    </script>
    <c:remove var="lockError" scope="session"/>
</c:if>

<%@ include file="/WEB-INF/components/header.jsp" %>

<main class="home-main">
    <section class="hero-section">
        <div class="hero-bg" style="background-image: url('${pageContext.request.contextPath}/assets/images/banner/banner.jpg');"></div>
        <div class="hero-overlay"></div>
        <div class="container hero-container">
            <div class="hero-content">
                <span class="hero-badge">Chào mừng đến với STEMSHOP</span>
                <h1 class="hero-title">Khơi dậy niềm đam mê khoa học & sáng tạo!</h1>
                <p class="hero-desc">Khám phá các bộ kit STEM, robot và thiết bị lập trình giúp trẻ em "Học mà chơi - Chơi mà học" một cách toàn diện nhất.</p>

                <div class="hero-actions">
                    <a href="${pageContext.request.contextPath}/shop" class="btn btn-primary btn-lg">Khám phá cửa hàng <i class="fa-solid fa-rocket"></i></a>
                </div>

                <div class="hero-tags">
                    <span><i class="fa-solid fa-check-circle"></i> Robot lập trình</span>
                    <span><i class="fa-solid fa-check-circle"></i> Kit Arduino</span>
                    <span><i class="fa-solid fa-check-circle"></i> Thí nghiệm khoa học</span>
                </div>
            </div>
        </div>
    </section>

    <section class="category-section pd-section">
        <div class="container">
            <div class="section-header text-center">
                <span class="subtitle">Danh mục nổi bật</span>
                <h2 class="section-title">Khám Phá Thế Giới STEM</h2>
                <p class="section-desc">Lựa chọn chủ đề mà bạn yêu thích để bắt đầu hành trình sáng tạo!</p>
            </div>

            <div class="category-grid">
                <a href="#" class="category-card">
                    <div class="cat-img-wrap border-green"><img src="${pageContext.request.contextPath}/assets/images/products/Robot lập trình Scratch.png" alt="Robot"></div>
                    <h3>Robot - Lập Trình</h3>
                </a>
                <a href="#" class="category-card">
                    <div class="cat-img-wrap border-orange"><img src="${pageContext.request.contextPath}/assets/images/products/Kit STEM Arduino cơ bản.png" alt="Kỹ Thuật"></div>
                    <h3>Kỹ Thuật – Cơ Khí</h3>
                </a>
                <a href="#" class="category-card">
                    <div class="cat-img-wrap border-blue"><img src="${pageContext.request.contextPath}/assets/images/workshop/math.jpg" alt="Toán Học"></div>
                    <h3>Toán Học – Logic</h3>
                </a>
                <a href="#" class="category-card">
                    <div class="cat-img-wrap border-purple"><img src="${pageContext.request.contextPath}/assets/images/products/Bộ lắp ráp cơ khí cho trẻ em.png" alt="Khoa Học"></div>
                    <h3>Khoa Học - Thí Nghiệm</h3>
                </a>
                <a href="#" class="category-card">
                    <div class="cat-img-wrap border-red"><img src="${pageContext.request.contextPath}/assets/images/workshop/chemistry.jpg" alt="Sáng Tạo"></div>
                    <h3>Sáng Tạo - Nghệ Thuật</h3>
                </a>
            </div>
        </div>
    </section>

    <section class="products-section pd-section bg-light">
        <div class="container">
            <div class="section-header text-center">
                <span class="subtitle">Sản phẩm mới nhất</span>
                <h2 class="section-title">Khám Phá Các Bộ Kit Tương Lai</h2>
                <p class="section-desc">Trải nghiệm những sản phẩm mới nhất giúp bé phát triển kỹ năng tư duy và lập trình.</p>
            </div>

            <div class="products-grid">
                <c:forEach var="product" items="${products}" begin="0" end="5">
                    <div class="product-card">
                        <div class="product-thumb">
                            <span class="badge-hot">Mới</span>
                            <img src="${pageContext.request.contextPath}${product.imageUrl}" alt="${product.productName}">
                            <div class="product-overlay">
                                <a href="${pageContext.request.contextPath}/view/product/detail?id=${product.id}" class="btn-view"><i class="fa-regular fa-eye"></i> Xem chi tiết</a>
                            </div>
                        </div>
                        <div class="product-info">
                            <h3 class="product-title"><a href="#">${product.productName}</a></h3>
                            <p class="product-desc">${product.description}</p>
                            <div class="product-bottom">
                                <span class="product-price"><fmt:formatNumber value="${product.price}" pattern="#,###"/> ₫</span>
                                <a href="${pageContext.request.contextPath}/add-to-cart?id=${product.id}" class="btn-cart" title="Thêm vào giỏ"><i class="fa-solid fa-cart-plus"></i></a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/shop" class="btn btn-outline">Xem tất cả sản phẩm <i class="fa-solid fa-arrow-right"></i></a>
            </div>
        </div>
    </section>

    <section class="about-section pd-section">
        <div class="container">
            <div class="about-grid">
                <div class="about-image">
                    <img src="${pageContext.request.contextPath}/assets/images/banner/kid-study-2.png" alt="Giới thiệu STEMSHOP" class="floating-img">
                    <div class="experience-badge">
                        <span>5+</span> Năm kinh nghiệm
                    </div>
                </div>
                <div class="about-content">
                    <span class="subtitle">Về Chúng Tôi</span>
                    <h2 class="section-title">Khơi nguồn sáng tạo qua học tập STEM</h2>
                    <p>STEMSHOP mang đến những sản phẩm, khóa học và bộ kit STEM giúp trẻ phát triển tư duy logic, khả năng sáng tạo. Chúng tôi tin rằng học tập qua thực hành là con đường tốt nhất để chạm tới tri thức.</p>

                    <div class="skill-bars">
                        <div class="skill-item">
                            <div class="skill-info"><span>Khoa học & Công nghệ</span> <span>90%</span></div>
                            <div class="progress"><div class="progress-bar" style="width: 90%;"></div></div>
                        </div>
                        <div class="skill-item">
                            <div class="skill-info"><span>Kỹ năng sáng tạo</span> <span>85%</span></div>
                            <div class="progress"><div class="progress-bar" style="width: 85%;"></div></div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/view/main/about.jsp" class="btn btn-primary mt-3">Tìm hiểu thêm</a>
                </div>
            </div>
        </div>
    </section>

    <section class="features-section pd-section bg-light">
        <div class="container">
            <div class="section-header text-center">
                <span class="subtitle">Vì sao chọn STEM?</span>
                <h2 class="section-title">Học Qua Trải Nghiệm Thực Tế</h2>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="f-icon"><i class="fa-solid fa-flask-vial"></i></div>
                    <h3>Thực Hành Sáng Tạo</h3>
                    <p>Tự tay lắp ráp, thử nghiệm và khám phá nguyên lý khoa học trong mỗi sản phẩm.</p>
                </div>
                <div class="feature-card">
                    <div class="f-icon"><i class="fa-solid fa-brain"></i></div>
                    <h3>Tư Duy Logic</h3>
                    <p>Khuyến khích trẻ tìm ra nhiều cách giải quyết vấn đề khác nhau, không ngại sai.</p>
                </div>
                <div class="feature-card">
                    <div class="f-icon"><i class="fa-solid fa-shield-heart"></i></div>
                    <h3>An Toàn Tuyệt Đối</h3>
                    <p>Tất cả kit được chọn lọc kỹ, thân thiện và đạt tiêu chuẩn an toàn cho trẻ nhỏ.</p>
                </div>
                <div class="feature-card">
                    <div class="f-icon"><i class="fa-solid fa-people-group"></i></div>
                    <h3>Kỹ Năng Làm Việc Nhóm</h3>
                    <p>Cùng nhau sáng tạo và chia sẻ ý tưởng để tạo ra sản phẩm hoàn chỉnh.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="blog-section pd-section">
        <div class="container">
            <div class="section-header d-flex-between">
                <div>
                    <span class="subtitle">Kiến thức & Tin tức</span>
                    <h2 class="section-title">Cẩm Nang STEM</h2>
                </div>
                <a href="${pageContext.request.contextPath}/view/content/blog.jsp" class="btn btn-outline d-none-mobile">Xem tất cả bài viết</a>
            </div>

            <div class="blog-grid">
                <article class="blog-card">
                    <div class="blog-thumb"><img src="${pageContext.request.contextPath}/assets/images/blog/Lợi ích học STEM sớm cho trẻ em.jpg" alt="Blog 1"></div>
                    <div class="blog-info">
                        <span class="blog-date"><i class="fa-regular fa-calendar"></i> 12/05/2024</span>
                        <h3><a href="${pageContext.request.contextPath}/view/content/blog-detail">Lợi ích học STEM sớm cho trẻ em</a></h3>
                        <p>Khám phá tại sao việc cho trẻ tiếp xúc với STEM từ sớm giúp phát triển tư duy logic vượt trội.</p>
                        <a href="${pageContext.request.contextPath}/view/content/blog-detail" class="read-more">Đọc tiếp <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>
                <article class="blog-card">
                    <div class="blog-thumb"><img src="${pageContext.request.contextPath}/assets/images/blog/Hướng dẫn chọn kit STEM phù hợp.jpg" alt="Blog 2"></div>
                    <div class="blog-info">
                        <span class="blog-date"><i class="fa-regular fa-calendar"></i> 08/05/2024</span>
                        <h3><a href="${pageContext.request.contextPath}/view/content/blog-detail">Hướng dẫn chọn Kit STEM phù hợp</a></h3>
                        <p>Chọn đúng bộ sản phẩm giúp trẻ học hiệu quả hơn – từ robot, hóa học đến cơ khí.</p>
                        <a href="${pageContext.request.contextPath}/view/content/blog-detail" class="read-more">Đọc tiếp <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>
                <article class="blog-card">
                    <div class="blog-thumb"><img src="${pageContext.request.contextPath}/assets/images/blog/STEM trong đời sống.jpg" alt="Blog 3"></div>
                    <div class="blog-info">
                        <span class="blog-date"><i class="fa-regular fa-calendar"></i> 01/05/2024</span>
                        <h3><a href="${pageContext.request.contextPath}/view/content/blog-detail">STEM trong đời sống hàng ngày</a></h3>
                        <p>Từ làm bánh, trồng cây đến chế tạo đồ chơi, STEM có mặt khắp nơi trong nhà bạn!</p>
                        <a href="${pageContext.request.contextPath}/view/content/blog-detail" class="read-more">Đọc tiếp <i class="fa-solid fa-arrow-right"></i></a>
                    </div>
                </article>
            </div>
        </div>
    </section>

</main>

<%@ include file="/WEB-INF/components/footer.jsp" %>
</body>
</html>