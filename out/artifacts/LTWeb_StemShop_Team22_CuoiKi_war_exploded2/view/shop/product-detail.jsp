<%@ page import="vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Reviews" %>
<%@ page import="vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ReviewDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="java.text.SimpleDateFormat" %>


<html>
<head>
    <title>Chi tiết sản phẩm</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/product-detail.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>

<body>
<style>
    .rating{
        display: flex;
        flex-direction: column;
        width: 30%;
    }
    .rating i {
        font-size: 2rem;
        color: #ec8b0b;
    }
    .rating label input{
        font-size: 2rem;
    }
    .form-reviews{
        display: flex;
    }
    .review__rate{
        width: 50%;
    }
    .review__comment{
        flex:1;
    }
    .review__comment textarea{
        width: 100%;
        height: 35%;
    }
    .star i{
        color: #ec8b0b;
    }

    /* ===== Reviews Section ===== */
    :root {
        --primary: #e91e63;
        --primary-hover: #c2185b;
        --secondary: #ff9800;
        --accent: #9c27b0;
        --success: #4caf50;
        --warning: #ff9800;
        --danger: #f44336;
        --text-dark: #333;
        --text-muted: #666;
        --text-light: #999;
        --bg-light: #f5f5f5;
        --bg-white: #fff;
        --border-color: #e0e0e0;
        --shadow: 0 2px 8px rgba(0,0,0,0.1);
        --shadow-hover: 0 4px 16px rgba(0,0,0,0.15);
        --radius: 8px;
        --radius-lg: 12px;
    }
    .reviews-section {
        padding: 60px 0;
        background: var(--bg-light);
    }

    .section-title {
        font-size: 28px;
        font-weight: 700;
        margin-bottom: 30px;
        color: var(--text-dark);
    }

    .reviews-grid {
        display: grid;
        grid-template-columns: 350px 1fr;
        gap: 40px;
    }

    /* Rating Summary */
    .rating-summary {
        background: var(--bg-white);
        border-radius: var(--radius-lg);
        padding: 30px;
        box-shadow: var(--shadow);
        height: fit-content;
        position: sticky;
        top: 100px;
    }

    .rating-overview {
        text-align: center;
        padding-bottom: 25px;
        border-bottom: 1px solid var(--border-color);
        margin-bottom: 25px;
    }

    .average-rating {
        margin-bottom: 10px;
    }

    .rating-number {
        font-size: 48px;
        font-weight: 700;
        color: var(--text-dark);
    }

    .rating-max {
        font-size: 24px;
        color: var(--text-muted);
    }

    .average-stars {
        margin-bottom: 10px;
    }

    .average-stars .star {
        font-size: 24px;
    }

    .total-reviews {
        color: var(--text-muted);
        font-size: 14px;
    }

    .rating-breakdown {
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    .rating-row {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .rating-row label {
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        min-width: 100px;
    }

    .rating-row input[type="radio"] {
        cursor: pointer;
    }

    .stars-mini {
        color: #ffc107;
        font-size: 14px;
    }

    .stars-mini .empty {
        color: #ddd;
    }

    .rating-bar {
        flex: 1;
        height: 8px;
        background: var(--bg-light);
        border-radius: 4px;
        overflow: hidden;
    }

    .rating-fill {
        height: 100%;
        background: linear-gradient(90deg, #ffc107, #ff9800);
        border-radius: 4px;
        transition: width 0.3s;
    }

    .rating-count {
        font-size: 13px;
        color: var(--text-muted);
        min-width: 30px;
        text-align: right;
    }

    /* Review Content */
    .review-content {
        display: flex;
        flex-direction: column;
        gap: 30px;
    }

    .review-form-container {
        background: var(--bg-white);
        border-radius: var(--radius-lg);
        padding: 30px;
        box-shadow: var(--shadow);
    }

    .review-form-container h3 {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 20px;
        color: var(--text-dark);
    }

    .review-form {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    .form-group label {
        font-size: 14px;
        font-weight: 500;
        color: var(--text-dark);
    }

    .form-group input,
    .form-group textarea {
        padding: 12px 15px;
        border: 1px solid var(--border-color);
        border-radius: var(--radius);
        font-size: 14px;
        font-family: inherit;
        transition: 0.3s;
    }

    .form-group input:focus,
    .form-group textarea:focus {
        outline: none;
        border-color: var(--primary);
        box-shadow: 0 0 0 3px rgba(233, 30, 99, 0.1);
    }

    .form-group textarea {
        resize: vertical;
        min-height: 100px;
    }

    /* Star Rating Input */
    .star-rating-input {
        display: flex;
        gap: 5px;
    }

    .star-input {
        font-size: 28px;
        color: #ddd;
        cursor: pointer;
        transition: 0.2s;
    }

    .star-input:hover,
    .star-input.active {
        color: #ffc107;
        transform: scale(1.1);
    }

    .star-input.hover-fill {
        color: #ffc107;
    }

    .btn-submit-review {
        align-self: flex-start;
        margin: auto;
        padding: 10px;
        border-radius: 25px;
    }
    .btn-submit-review:hover{
        background-color: var(--primary);
        transition: 0.3s;
    }

    /* Review List */
    .review-list {
        background: var(--bg-white);
        border-radius: var(--radius-lg);
        padding: 30px;
        box-shadow: var(--shadow);
    }

    .review-list h3 {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 25px;
        color: var(--text-dark);
    }

    .review-item {
        padding: 20px 0;
        border-bottom: 1px solid var(--border-color);
    }

    .review-item:last-of-type {
        border-bottom: none;
    }

    .review-header {
        display: flex;
        justify-content: space-between;
        align-items: flex-start;
        margin-bottom: 12px;
    }

    .reviewer-info {
        display: flex;
        align-items: center;
        gap: 12px;
    }

    .reviewer-avatar {
        width: 44px;
        height: 44px;
        background: linear-gradient(135deg, var(--primary), var(--accent));
        color: white;
        border-radius: 50%;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: 600;
        font-size: 14px;
    }

    .reviewer-details {
        display: flex;
        flex-direction: column;
    }

    .reviewer-name {
        font-weight: 600;
        color: var(--text-dark);
    }

    .review-date {
        font-size: 12px;
        color: var(--text-light);
    }

    .review-rating .star {
        font-size: 14px;
    }

    .review-text {
        color: var(--text-muted);
        line-height: 1.7;
        margin-bottom: 12px;
    }

    .review-actions {
        display: flex;
        gap: 15px;
    }

    .helpful-btn {
        display: flex;
        align-items: center;
        gap: 6px;
        background: none;
        border: none;
        color: var(--text-muted);
        font-size: 13px;
        cursor: pointer;
        padding: 5px 10px;
        border-radius: var(--radius);
        transition: 0.3s;
    }

    .helpful-btn:hover {
        background: var(--bg-light);
        color: var(--primary);
    }

    .btn-load-more {
        width: 100%;
        margin-top: 20px;
    }

    .average-stars span i{
        color: #FFC107;
    }
    .active-heart {
        color: red !important;
    }

</style>

<!-- HEADER -->
<jsp:include page="/WEB-INF/components/header.jsp"/>

<main>

    <!-- breadcrumb -->
    <div class="back">
        <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
        <span>/</span>
        <a href="${pageContext.request.contextPath}/shop">Cửa hàng</a>
        <span>/</span>
        <a href="#">Chi tiết sản phẩm</a>
    </div>

    <!-- ================= PRODUCT DETAIL ================= -->
    <div class="product-detail">

        <!-- LEFT: IMAGES -->
        <div class="product-images">
            <!-- MAIN IMAGE -->
            <c:if test="${not empty images}">
                <img class="main-image"
                     src="${pageContext.request.contextPath}/${images[0].imageUrl}"
                     alt="${product.productName}">
            </c:if>

            <!-- THUMBNAILS -->
            <div class="thumbnail-images">
                <c:forEach var="img" items="${images}">
                    <img src="${pageContext.request.contextPath}/${img.imageUrl}"
                         alt="${product.productName}">
                </c:forEach>
            </div>

        </div>

        <!-- RIGHT: INFO -->
        <div class="product-info">
            <h1>${product.productName}</h1>

            <div class="product-price">
                ${product.price} Đ
            </div>

            <div class="product-description">
                <ul>
                    <li><i class="fa-solid fa-check-double"></i> Hàng chính hãng</li>
                    <li><i class="fa-solid fa-check-double"></i> Miễn phí giao hàng đơn trên 500K</li>
                    <li><i class="fa-solid fa-check-double"></i> Giao hàng hỏa tốc 4 tiếng</li>
                    <li><i class="fa-solid fa-check-double"></i> Hỗ trợ trả góp đơn hàng từ 3 triệu. <a
                            href="${pageContext.request.contextPath}/view/shop/chinh-sach-tra-gop.jsp" target="_blank">Xem chi tiết</a></li>
                </ul>
            </div>

            <div class="product-actions">
                <button class="add-to-cart"
                        type="button"
                        onclick="addToCart(${product.id})">
                    Thêm vào giỏ hàng
                    <i class="fa-solid fa-cart-plus"></i>
                </button>

                <button type="button"
                        class="wishlist-btn"
                        onclick="toggleWishlist(${product.id}, this)">
                    <i class="fa-solid fa-heart ${isWishlisted ? 'active-heart' : ''}"></i>
                </button>
            </div>

            <div class="product-meta">
                <p><strong>Thương hiệu:</strong> ${product.brandName}</p>
                <p><strong>Số lượng sản phẩm hiện tại:</strong> ${product.quantity}</p>
                <p><strong>ID sản phẩm:</strong> ${product.id}</p>
            </div>
        </div>
    </div>

    <!-- ================= DESCRIPTION ================= -->
    <div class="productDecription">
        <div class="tabContent">
            <h2>Mô tả sản phẩm</h2>
            <p>
                ${product.description}
            </p>
        </div>
    </div>

    <!-- ================= TRUST BADGE ================= -->
    <div class="trust-badge__container">
        <ul>
            <li>
                <img src="${pageContext.request.contextPath}/assets/images/product-detail/chinh-hang.png">
                <p>Sản phẩm chính hãng 100%</p>
            </li>
            <li>
                <img src="${pageContext.request.contextPath}/assets/images/product-detail/an-toan.png">
                <p>Nhựa an toàn cho trẻ em</p>
            </li>
            <li>
                <img src="${pageContext.request.contextPath}/assets/images/product-detail/giao-hang.png">
                <p>Miễn phí giao hàng từ 500K</p>
            </li>
            <li>
                <img src="${pageContext.request.contextPath}/assets/images/product-detail/hoa-toc.png">
                <p>Giao hàng hỏa tốc 4 tiếng</p>
            </li>
        </ul>
    </div>

    <!-- ================= REVIEW ================= -->
    <%
        int productId = Integer.parseInt(request.getParameter("id"));

        List<Reviews> reviews = ReviewDAO.getByProductId(productId);
        double avgRating = ReviewDAO.getAverageRating(productId);
        int totalReviews = ReviewDAO.getTotalReviews(productId);

        User user = (User) session.getAttribute("user");
    %>
    <section class="reviews-section">
        <div class="container">
            <h2 class="section-title">Đánh giá sản phẩm</h2>

            <div class="reviews-grid">

                <!-- ===== LEFT: RATING SUMMARY ===== -->
                <div class="rating-summary">
                    <div class="rating-overview">
                        <div class="average-rating">
                            <span class="rating-number">
                                <%= String.format("%.1f", avgRating) %>
                            </span>
                            <span class="rating-max">/ 5</span>
                        </div>

                        <div class="average-stars">
                            <% for (int i = 1; i <= 5; i++) { %>
                            <span class="star <%= i <= Math.round(avgRating) ? "filled" : "" %>"><i class="fa-solid fa-star"></i></span>
                            <% } %>
                        </div>

                        <p class="total-reviews">
                            Đánh giá trung bình: <%= String.format("%.1f", avgRating) %> / 5
                            (<%= totalReviews %> đánh giá)
                        </p>
                    </div>
                </div>

                <!-- ===== RIGHT: FORM + LIST ===== -->
                <div class="review-content">

                    <!-- ===== REVIEW FORM ===== -->
                    <div class="review-form-container">
                        <h3>Bình luận sản phẩm:</h3>

                        <% if (user != null) { %>
                        <!-- ===== REVIEW FORM ===== -->
                        <form class="review-form"
                              action="${pageContext.request.contextPath}/add-review"
                              method="post">

                            <input type="hidden" name="productId" value="<%= productId %>">
                            <input type="hidden" name="rating" id="ratingValue">

                            <div class="form-group">
                                <label>Đánh giá của bạn:</label>
                                <div class="star-rating-input">
                                    <% for (int i = 1; i <= 5; i++) { %>
                                    <span class="star-input" data-value="<%= i %>"><i class="fa-solid fa-star"></i></span>
                                    <% } %>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Nhận xét của bạn:</label>
                                <textarea name="comment"
                                          rows="4"
                                          placeholder="Chia sẻ cảm nhận của bạn..."
                                          required></textarea>
                            </div>

                            <button class="btn btn-primary btn-submit-review">
                                Viết đánh giá
                            </button>
                        </form>

                        <% } else { %>
                        <p>Vui lòng <a href="${pageContext.request.contextPath}/view/user/sign-in.jsp">đăng nhập</a> để đánh giá.</p>
                        <% } %>
                    </div>

                    <!-- ===== REVIEW LIST ===== -->
                    <div class="review-list">
                        <h3>
                            Đánh giá từ khách hàng
                            (<span><%= reviews.size() %></span>)
                        </h3>

                        <% for (Reviews r : reviews) { %>
                        <div class="review-item">
                            <div class="review-header">
                                <div class="reviewer-info">
                                    <div class="reviewer-avatar">
                                        <%= r.getUserName().substring(0, 2).toUpperCase() %>
                                    </div>
                                    <div class="reviewer-details">
                                        <span class="reviewer-name"><%= r.getUserName() %></span>
                                        <%
                                            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
                                        %>
                                        <span class="review-date">
                                            <%= sdf.format(r.getCreateDate()) %>
                                        </span>

                                    </div>
                                </div>

                                <%
                                    int ratingInt = (int) Math.round(r.getRating());
                                %>

                                <div class="review-rating">
                                    <% for (int i = 1; i <= 5; i++) { %>
                                    <span class="star">
                                        <i class="<%= i <= ratingInt ? "fa-solid" : "fa-regular" %> fa-star"></i>
                                    </span>
                                    <% } %>
                                </div>
                            </div>

                            <p class="review-text"><%= r.getComment() %></p>
                        </div>
                        <% } %>

                        <% if (reviews.size() > 5) { %>
                        <button class="btn btn-outline btn-load-more">
                            Xem thêm đánh giá
                        </button>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- FOOTER -->
<jsp:include page="/WEB-INF/components/footer.jsp"/>
<%--hàm đổi ản khi click vào thumbnail--%>
<script>
    const mainImage = document.querySelector('.main-image');
    const thumbnails = document.querySelectorAll('.thumbnail-images img');

    thumbnails.forEach(img => {
        img.addEventListener('click', () => {
            mainImage.src = img.src;
        });
    });
</script>

<script>
    const stars = document.querySelectorAll('.star-input');
    const ratingInput = document.getElementById('ratingValue');

    stars.forEach(star => {
        star.addEventListener('click', () => {
            const value = star.dataset.value;
            ratingInput.value = value;

            stars.forEach(s => {
                s.classList.toggle('active', s.dataset.value <= value);
            });
        });

        star.addEventListener('mouseover', () => {
            const value = star.dataset.value;
            stars.forEach(s => {
                s.classList.toggle('hover-fill', s.dataset.value <= value);
            });
        });

        star.addEventListener('mouseout', () => {
            stars.forEach(s => s.classList.remove('hover-fill'));
        });
    });
</script>
</body>
</html>