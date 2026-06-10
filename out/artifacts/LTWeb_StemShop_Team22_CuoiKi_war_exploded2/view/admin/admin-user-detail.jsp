<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết User </title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .detail-box {
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            margin-bottom: 20px;
        }
        .detail-box h3 {
            font-size: 18px;
            margin-bottom: 20px;
            color: #333;
            font-weight: 600;
            border-bottom: 2px solid #ff69a8;
            padding-bottom: 10px;
        }
        .detail-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }
        .detail-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }
        .detail-item label {
            font-size: 13px;
            color: #666;
            font-weight: 500;
        }
        .detail-item span {
            font-size: 15px;
            color: #333;
            font-weight: 400;
        }
        .btn-back {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
            margin-bottom: 20px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-back:hover {
            background: #5e5e5e;
        }
        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }
        .badge-admin {
            background: #ff69a8;
            color: white;
        }
        .badge-user {
            background: #d5b0ff;
            color: white;
        }
    </style>
</head>
<body>
<div class="admin-container">
    <!-- Sidebar -->
    <aside class="admin-sidebar">
        <div class="admin-sidebar__logo">
            <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="Logo">
        </div>
        <hr class="admin-sidebar__divider">
        <ul class="admin-menu">
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/dashboard'">
                <i class="fa-solid fa-chart-line"></i> Dashboard
            </li>
            <li class="admin-menu__item">
                <i class="fa-solid fa-users active"></i> Quản lý Người Dùng
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-products'">
                <i class="fa-solid fa-box"></i> Quản lý Sản Phẩm
            </li>
            <li class="admin-menu__item " onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-orders'">
                <i class="fa-solid fa-shopping-cart"></i> Quản lý Đơn Hàng
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/'">
                <i class="fa-solid fa-home"></i> Về trang chủ
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/logout'">
                <i class="fa-solid fa-sign-out-alt"></i> Đăng xuất
        </ul>
    </aside>

    <!-- Main Content -->
    <main class="admin-main">
        <!-- Topbar -->
        <header class="admin-topbar">
            <h1>Thông tin chi tiết</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
            </div>
        </header>

        <!-- Content -->
        <div>
            <button class="btn-back" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-user'">
                <i class="fas fa-arrow-left"></i> Quay lại
            </button>

            <!-- Thông tin User -->
            <div class="detail-box">
                <h3>Thông Tin User</h3>
                <div class="detail-grid">
                    <div class="detail-item">
                        <label>ID:</label>
                        <span>${user.id}</span>
                    </div>
                    <div class="detail-item">
                        <label>Họ tên:</label>
                        <span>${user.fullName}</span>
                    </div>
                    <div class="detail-item">
                        <label>Email:</label>
                        <span>${user.email}</span>
                    </div>
                    <div class="detail-item">
                        <label>Số điện thoại:</label>
                        <span>${user.phoneNumber}</span>
                    </div>
                    <div class="detail-item">
                        <label>Địa chỉ:</label>
                        <span>${user.address}</span>
                    </div>
                    <div class="detail-item">
                        <label>Username:</label>
                        <span>${user.userName}</span>
                    </div>
                    <div class="detail-item">
                        <label>Vai trò:</label>
                        <span class="badge badge-${user.role == 'ADMIN' ? 'admin' : 'user'}">
                            ${user.role}
                        </span>
                    </div>
                    <div class="detail-item">
                        <label>Ngày tạo:</label>
                        <span>
                            <fmt:formatDate value="${user.createDate}" pattern="dd/MM/yyyy"/>
                        </span>
                    </div>
                </div>
            </div>

            <!-- Lịch sử đơn hàng -->
            <div class="detail-box">
                <h3>Lịch Sử Đơn Hàng</h3>
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>Mã ĐH</th>
                        <th>Ngày đặt</th>
                        <th>Tổng tiền</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="order" items="${orders}">
                        <tr>
                            <td>#${order.id}</td>
                            <td>
                                <fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                            </td>
                            <td>
                                <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty orders}">
                        <tr>
                            <td colspan="3" style="text-align: center; color: #999; padding: 20px;">
                                Chưa có đơn hàng nào
                            </td>
                        </tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </main>
</div>
</body>
</html>