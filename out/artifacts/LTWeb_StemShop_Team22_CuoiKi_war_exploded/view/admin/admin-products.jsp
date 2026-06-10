<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Sản Phẩm - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .table-actions {
            margin-bottom: 20px;
        }
        .search-form {
            display: inline-block;
        }
        .search-input {
            padding: 10px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            width: 300px;
            font-size: 14px;
        }
        .btn-action {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            font-size: 12px;
            margin-right: 5px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-edit {
            background: #ffc107;
        }
        .btn-edit:hover {
            background: #e0a800;
        }
        .btn-delete {
            background: #dc3545;
            border: none;
            cursor: pointer;
        }
        .btn-delete:hover {
            background: #c82333;
        }
        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }
        .btn-product-detail{
            background: #dc2c9e;
            border: none;
            cursor: pointer;
            padding: 6px 12px;
            border-radius: 5px;
            color: white;
            font-size: 12px;
            margin-right: 5px;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-product-detail:hover {
            background: #e0a800;
            color: #fff;

        }
        .admin-table th:nth-child(5), .admin-table td:nth-child(5) {
            width: 8%;
        }
        .admin-info {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .admin-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
        }
        .delete-form {
            display: inline;
        }
    </style>
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
        <!-- Topbar -->
        <header class="admin-topbar">
            <h1>Quản lý Sản Phẩm</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
                <span>Admin</span>
            </div>
        </header>

        <!-- Content -->
        <div>
            <!-- Tìm kiếm và thêm mới -->
            <div class="table-actions" style="display: flex; justify-content: space-between; align-items: center;">
                <form method="get" class="search-form">
                    <input type="text" name="search" placeholder="Tìm sản phẩm..." class="search-input" >
                </form>

                <a href="${pageContext.request.contextPath}/admin/admin-product-add" class="btn-action" style="background: #ff8ab8;; padding: 10px 20px;">
                    <i class="fas fa-plus"></i> Thêm sản phẩm mới
                </a>
            </div>

            <!-- Bảng sản phẩm -->
            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
<%--                    <th>Hình ảnh</th>--%>
                    <th>Tên sản phẩm</th>
                    <th>Thương hiệu</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Tác vụ</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="product" items="${products}">
                    <tr>
                        <td>${product.id}</td>
                        <td>${product.productName}</td>
                        <td>${product.brandName}</td>
                        <td>
                            <fmt:formatNumber value="${product.price}" pattern="#,###"/> Đ
                        </td>
                        <td>${product.quantity}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/admin/admin-product-edit?id=${product.id}" class="btn-action btn-edit">
                                <i class="fas fa-edit"></i> Sửa
                            </a>

                            <form method="post" class="delete-form" onsubmit="return confirm('Bạn có chắc muốn xóa sản phẩm này?')">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="id" value="${product.id}">
                                <button type="submit" class="btn-action btn-delete">
                                    <i class="fas fa-trash"></i> Xóa
                                </button>
                            </form>
                            <a href="${pageContext.request.contextPath}/admin/admin-product-detail.jsp?id=${product.id}" class="btn-product-detail">Chi tiết</a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr>
                        <td colspan="7" style="text-align: center; padding: 20px; color: #999;">
                            Chưa có sản phẩm nào
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>

</body>
</html>
