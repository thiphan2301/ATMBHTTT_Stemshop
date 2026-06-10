<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- thêm cài này ae: jstl -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!-- debug -->
<%--<h1>DEBUG: totalUsers = ${totalUsers}</h1>--%>
<%--<h1>DEBUG: totalRevenue = ${totalRevenue}</h1>--%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - 3T STEM Shop</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
</head>
<body>

<div class="admin-container">
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar__logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="STEM Logo">
        </div>

        <hr class="admin-sidebar__divider">

        <ul class="admin-menu">
            <li class="admin-menu__item active" onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard'">
                <i class="fa-solid fa-chart-line"></i> Dashboard
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-user'">
                <i class="fa-solid fa-users"></i> Quản lý Người Dùng
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-products'">
                <i class="fa-solid fa-box"></i> Quản lý Sản Phẩm
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-orders'">
                <i class="fa-solid fa-shopping-cart"></i> Quản lý Đơn Hàng
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/'">
                <i class="fa-solid fa-home"></i> Về trang chủ
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                <i class="fa-solid fa-sign-out-alt"></i> Đăng xuất
            </li>
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        <header class="admin-topbar">
            <h1>Dashboard</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
            </div>
        </header>

        <!-- Statistics Cards -->
        <div class="dashboard-cards">
            <div class="card card-users">
                <div class="card-icon">
                    <i class="fa-solid fa-users"></i>
                </div>
                <div class="card-info">
                    <h3>Tổng Số Người Dùng</h3>
                    <div class="card-value">${totalUsers}</div>
<%--                    <div class="card-trend up">
                        <i class="fa-solid fa-arrow-up"></i> +12% tháng này
                    </div>--%>
                </div>
            </div>

            <div class="card card-products">
                <div class="card-icon">
                    <i class="fa-solid fa-box"></i>
                </div>
                <div class="card-info">
                    <h3>Tổng Số Sản Phẩm</h3>
                    <div class="card-value">${totalProducts}</div>
<%--                    <div class="card-trend up">
                        <i class="fa-solid fa-arrow-up"></i> +8% tháng này
                    </div>--%>
                </div>
            </div>

            <div class="card card-orders">
                <div class="card-icon">
                    <i class="fa-solid fa-shopping-cart"></i>
                </div>
                <div class="card-info">
                    <h3>Tổng Số Đơn Hàng</h3>
                    <div class="card-value">${totalOrders}</div>
<%--                    <div class="card-trend up">
                        <i class="fa-solid fa-arrow-up"></i> +15% tháng này
                    </div>--%>
                </div>
            </div>
        </div>

<%--        <!-- Second Row Cards -->
        <div class="dashboard-cards" style="grid-template-columns: repeat(2, 1fr); margin-top: 20px;">
            <div class="card card-posts">
                <div class="card-icon">
                    <i class="fa-solid fa-newspaper"></i>
                </div>
                <div class="card-info">
                    <h3>Tổng Số Bài Viết</h3>
                    <div class="card-value">${totalBlogs}</div>
                    <div class="card-trend up">
                        <i class="fa-solid fa-arrow-up"></i> +5% tháng này
                    </div>
                </div>
            </div>--%>

            <div class="card card-revenue">
                <div class="card-icon">
                    <i class="fa-solid fa-dollar-sign"></i>
                </div>
                <div class="card-info">
                    <h3>Tổng Doanh Thu</h3>
                    <div class="card-value">
                        <fmt:formatNumber value="${totalRevenue}" type="number" groupingUsed="true"/>đ
                    </div>
<%--                    <div class="card-trend up">
                        <i class="fa-solid fa-arrow-up"></i> +22% so với tháng trước
                    </div>--%>
                </div>
            </div>
        </div>
    </main>
</div>

</body>
</html>
