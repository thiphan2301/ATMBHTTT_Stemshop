<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Sản Phẩm - Admin</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/product-detail.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        /* Tinh chỉnh lại một chút để hiển thị đẹp bên trong Admin */
        .admin-content-wrap { background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
        .product-detail { margin-top: 0; padding-top: 0; }
        .reviews-section { padding: 30px 0; background: #fff; }
        .back-btn { display: inline-block; margin-bottom: 20px; color: #dc2c9e; text-decoration: none; font-weight: bold; }
        .back-btn:hover { text-decoration: underline; }

        /* CSS cho phần Tồn kho Admin */
        .admin-inventory-box { background: #f8f9fa; padding: 15px; border-radius: 8px; border: 1px solid #dee2e6; margin-top: 20px; }
        .admin-inventory-box ul { list-style: none; padding: 0; margin: 0; line-height: 1.8; }
        .admin-inventory-box li i { width: 25px; color: #6c757d; }
    </style>
</head>

<body>
<div class="admin-container">
    <aside class="admin-sidebar">
        <div class="admin-sidebar__logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="STEM Logo">
        </div>
        <hr class="admin-sidebar__divider">
        <ul class="admin-menu">
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard'">
                <i class="fa-solid fa-chart-line"></i> Dashboard
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-user'">
                <i class="fa-solid fa-users"></i> Quản lý Người Dùng
            </li>
            <li class="admin-menu__item active" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-products'">
                <i class="fa-solid fa-box"></i> Quản lý Sản Phẩm
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-orders'">
                <i class="fa-solid fa-shopping-cart"></i> Quản lý Đơn Hàng
            </li>
            <li class="admin-menu__item" onclick="location.href='${pageContext.request.contextPath}/admin/shipping'">
                <i class="fa-solid fa-truck"></i> Quản lý Vận chuyển
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/'">
                <i class="fa-solid fa-home"></i> Về trang chủ
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                <i class="fa-solid fa-sign-out-alt"></i> Đăng xuất
            </li>
        </ul>
    </aside>
    <main class="admin-main">
        <header class="admin-topbar">
            <h1>Chi tiết sản phẩm #${product.id}</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
                <span>Admin</span>
            </div>
        </header>

        <div class="admin-content-wrap">
            <a href="${pageContext.request.contextPath}/admin/admin-products" class="back-btn">
                <i class="fa-solid fa-arrow-left"></i> Quay lại danh sách sản phẩm
            </a>

            <div class="product-detail">
                <div class="product-images">
                    <img class="main-image" id="main-product-img" src="${pageContext.request.contextPath}/${product.imageUrl}" alt="${product.productName}">
                    <div class="thumbnail-images" style="display: flex; gap: 10px; margin-top: 15px;">
                        <c:if test="${not empty product.subImages}">
                            <c:forEach var="imgUrl" items="${product.subImages}">
                                <img src="${pageContext.request.contextPath}/${imgUrl}" class="thumb-item" onclick="changeImage(this.src)" onerror="this.style.display='none'" style="width: 80px; height: 80px; object-fit: contain; cursor: pointer; border: 1px solid #ddd;">
                            </c:forEach>
                        </c:if>
                    </div>
                </div>

                <div class="product-info">
                    <h1 style="font-size: 24px; margin-bottom: 10px;">${product.productName}</h1>
                    <div class="product-price" style="font-size: 22px; color: #e91e63;">
                        <fmt:formatNumber value="${product.price}" pattern="#,###"/> Đ
                    </div>

                    <div class="product-meta" style="margin-top: 20px;">
                        <p><strong>Thương hiệu:</strong> ${product.brandName}</p>
                        <p><strong>ID sản phẩm:</strong> ${product.id}</p>
                    </div>

                    <div class="admin-inventory-box">
                        <h3 style="margin-top: 0; font-size: 16px; border-bottom: 1px solid #ddd; padding-bottom: 8px;">
                            <i class="fas fa-warehouse" style="color: #17a2b8;"></i> Quản lý lô hàng & Tồn kho
                        </h3>
                        <div style="display: flex; gap: 40px; margin-top: 10px; font-size: 14px;">
                            <div>
                                <p style="font-weight: bold; margin-bottom: 5px;">Tổng quan kho hàng:</p>
                                <ul>
                                    <li><i class="fas fa-cubes"></i> Tổng hàng khả dụng: <strong style="color: #28a745;">${product.quantity}</strong> SP</li>
                                    <li><i class="fas fa-exclamation-triangle"></i> Cảnh báo hư hỏng gần nhất:
                                        <strong style="color: ${product.nearestExpiryMonths < 6 ? '#dc3545' : '#28a745'};">
                                            ${not empty product.nearestExpiry ? product.nearestExpiry : 'Chưa có dữ liệu'}
                                        </strong>
                                        <c:if test="${not empty product.nearestExpiryMonths}">
                                            <span style="font-size: 12px; color: #666;">(Dự kiến hỏng sau ~${product.nearestExpiryMonths} tháng)</span>
                                        </c:if>
                                    </li>
                                </ul>
                            </div>
                            <div>
                                <p style="font-weight: bold; margin-bottom: 5px;">Lô hàng nhập mới nhất:</p>
                                <ul>
                                    <li><i class="fas fa-box"></i> Số lượng khả dụng: <strong>${product.newestBatchQuantity}</strong> SP</li>
                                    <li><i class="fas fa-calendar-times"></i> Ngày hỏng dự kiến: <strong>${not empty product.newestBatchExpiry ? product.newestBatchExpiry : 'Chưa có'}</strong></li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="productDecription" style="margin-top: 30px;">
                <h2 style="font-size: 18px; border-bottom: 2px solid #dc2c9e; display: inline-block; padding-bottom: 5px;">Mô tả sản phẩm</h2>
                <div style="margin-top: 15px; line-height: 1.6;">${product.description}</div>
            </div>

            <section class="reviews-section" style="margin-top: 30px; border-top: 1px solid #eee;">
                <h2 style="font-size: 18px; margin-bottom: 20px;">Đánh giá từ khách hàng (${totalReviews})</h2>

                <div style="display: flex; gap: 30px;">
                    <div style="width: 200px; text-align: center; background: #f9f9f9; padding: 20px; border-radius: 8px;">
                        <span style="font-size: 36px; font-weight: bold; color: #333;">
                            <fmt:formatNumber value="${avgRating}" maxFractionDigits="1"/>
                        </span>
                        <span style="font-size: 18px; color: #666;">/ 5</span>
                        <div style="margin-top: 10px; color: #ffc107; font-size: 18px;">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="${i <= avgRating + 0.5 ? 'fa-solid' : 'fa-regular'} fa-star"></i>
                            </c:forEach>
                        </div>
                    </div>

                    <div style="flex: 1;">
                        <c:if test="${empty reviews}">
                            <p style="color: #999;">Sản phẩm chưa có đánh giá nào.</p>
                        </c:if>
                        <c:forEach var="r" items="${reviews}">
                            <div style="padding: 15px 0; border-bottom: 1px solid #eee;">
                                <div style="display: flex; justify-content: space-between; margin-bottom: 5px;">
                                    <strong>${r.userName}</strong>
                                    <span style="color: #999; font-size: 12px;">
                                        <fmt:formatDate value="${r.createDate}" pattern="dd/MM/yyyy HH:mm" />
                                    </span>
                                </div>
                                <div style="color: #ffc107; font-size: 12px; margin-bottom: 10px;">
                                    <c:forEach begin="1" end="5" var="i">
                                        <i class="${i <= r.rating ? 'fa-solid' : 'fa-regular'} fa-star"></i>
                                    </c:forEach>
                                </div>
                                <p style="margin: 0; color: #555;">${r.comment}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </section>
        </div>
    </main>
</div>

<script>
    function changeImage(newSrc) {
        document.getElementById('main-product-img').src = newSrc;
    }
</script>
</body>
</html>