<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lịch sử Nhập hàng - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
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
            <h1>Lịch sử nhập kho</h1>
        </header>

        <div style="background: #fff; padding: 20px; border-radius: 8px; margin-top: 20px; box-shadow: 0 4px 12px rgba(0,0,0,0.05);">

            <div style="margin-bottom: 20px; padding: 15px; background: #f8f9fa; border-radius: 6px; border: 1px solid #eee;">
                <form method="get" action="${pageContext.request.contextPath}/admin/admin-import-history" style="display: flex; align-items: center; gap: 10px;">
                    <label style="font-weight: bold; margin: 0;">Chọn Sản phẩm:</label>

                    <select name="productId" style="padding: 8px; border: 1px solid #ccc; border-radius: 4px; width: 400px;">
                        <option value="">-- Tất cả sản phẩm --</option>
                        <c:forEach var="p" items="${productList}">
                            <option value="${p.id}" ${param.productId == p.id ? 'selected' : ''}>
                                    ${p.name} (ID: ${p.id}) - Đã nhập: ${p.count} lần
                            </option>
                        </c:forEach>
                    </select>

                    <button type="submit" style="padding: 8px 15px; background: #007bff; color: white; border: none; border-radius: 4px; cursor: pointer;">
                        <i class="fas fa-search"></i> Lọc
                    </button>

                    <c:if test="${not empty param.productId}">
                        <a href="${pageContext.request.contextPath}/admin/admin-import-history" style="color: #dc3545; text-decoration: none; font-size: 14px; margin-left: 10px;">
                            <i class="fas fa-times"></i> Hủy lọc
                        </a>
                    </c:if>
                </form>
            </div>

            <table class="admin-table">
                <thead>
                <tr>
                    <th>Đợt (Batch)</th>
                    <th>ID SP</th>
                    <th>Ngày nhập</th>
                    <th>Tên Sản phẩm</th>
                    <th>Số lượng</th>
                    <th>Giá nhập</th>
                    <th>Ghi chú</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${historyList}">
                    <tr>
                        <td style="color: #6c757d; font-weight: bold;">#${item.batchId}</td>
                        <td style="color: #007bff; font-weight: bold;">${item.productId}</td>
                        <td><fmt:formatDate value="${item.date}" pattern="dd/MM/yyyy HH:mm"/></td>
                        <td style="font-weight: bold;">${item.name}</td>
                        <td><span style="color: #28a745; font-weight: bold;">+ ${item.qty}</span></td>
                        <td><fmt:formatNumber value="${item.price}"/> đ</td>
                        <td>${item.note}</td>
                    </tr>
                </c:forEach>
                <c:if test="${empty historyList}">
                    <tr>
                        <td colspan="7" style="text-align: center; color: #999; padding: 20px;">Chưa có lịch sử nhập kho cho sản phẩm này.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>

            <div style="margin-top: 20px; text-align: right;">
                <a href="${pageContext.request.contextPath}/admin/admin-products" class="btn-action" style="background: #6c757d; padding: 10px 20px; text-decoration: none; display: inline-block; color: #fff; border-radius: 5px;">
                    <i class="fas fa-arrow-left"></i> Quay lại quản lý sản phẩm
                </a>
            </div>
        </div>
    </main>
</div>
</body>
</html>