<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sửa Đơn Hàng - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .form-container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #333;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 14px;
        }
        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary {
            background: #ff69a8;
            color: white;
        }
        .btn-secondary {
            background: #6c757d;
            color: white;
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
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-products'">
                <i class="fa-solid fa-box"></i> Quản lý Sản Phẩm
            </li>
            <li class="admin-menu__item active" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-orders'">
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

    <!-- Main Content -->
    <main class="admin-main">
        <header class="admin-topbar">
            <h1>Sửa Đơn Hàng</h1>
        </header>

        <div style="margin-top: 10px; margin-bottom: 20px;">
            <c:if test="${not empty error}">
                <div style="padding: 12px 20px; background: #ffebee; color: #c62828; border: 1px solid #ffcdd2; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 10px;">
                    <i class="fa-solid fa-circle-exclamation"></i> ${error}
                </div>
            </c:if>
        </div>

        <div class="form-container">
            <form method="post">
                <input type="hidden" name="oldId" value="${order.id}">

                <div class="form-group">
                    <label>ID Đơn hàng (ID):</label>
                    <input type="number" name="id" value="${order.id}" required>
                    <small style="color: #d93838; font-weight: 500; display: block; margin-top: 5px;">
                        <i class="fa-solid fa-triangle-exclamation"></i> Chú ý: Việc đổi ID Đơn hàng sẽ đồng bộ mã đơn ở các bảng chi tiết đơn hàng, khuyến mãi và thanh toán.
                    </small>
                </div>

                <div class="form-group">
                    <label>ID Người mua (UserID):</label>
                    <input type="number" name="userId" value="${order.userId}" required>
                </div>

                <div class="form-group">
                    <label>Ngày đặt (Date):</label>
                    <input type="datetime-local" name="orderDate" value="${formattedDate}" required>
                </div>

                <div class="form-group">
                    <label>Người nhận (Receiver):</label>
                    <input type="text" name="receiverName" value="${order.receiverName}" required>
                </div>

                <div class="form-group">
                    <label>Số điện thoại (Phone):</label>
                    <input type="text" name="receiverPhone" value="${order.receiverPhone}" required>
                </div>

                <div class="form-group">
                    <label>Địa chỉ nhận hàng (Address):</label>
                    <input type="text" name="shippingAddress" value="${order.shippingAddress}" required>
                </div>

                <div class="form-group">
                    <label>Tổng tiền (TotalAmount):</label>
                    <input type="number" step="0.01" name="totalAmount" value="${order.totalAmount}" required>
                </div>

                <div class="form-group">
                    <label>Phí vận chuyển (ShippingFee):</label>
                    <input type="number" step="0.01" name="shippingFee" value="${order.shippingFee}" required>
                </div>

                <div class="form-group">
                    <label>Phương thức thanh toán (PayMethod):</label>
                    <select name="paymentMethodId" required>
                        <option value="1" <c:if test="${order.paymentMethodId == 1}">selected</c:if>>Tiền mặt (COD)</option>
                        <option value="2" <c:if test="${order.paymentMethodId == 2}">selected</c:if>>Chuyển khoản (VNPAY)</option>
                    </select>
                </div>

                <!-- Nút thao tác -->
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Lưu thay đổi</button>
                    <a href="${pageContext.request.contextPath}/admin/admin-orders" class="btn btn-secondary">Hủy</a>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>
