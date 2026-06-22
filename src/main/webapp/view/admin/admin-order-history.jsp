<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lịch sử thay đổi đơn hàng</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin-orders.css">
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

    <main class="admin-main">
        <header class="admin-topbar">
            <h1>Lịch Sử Thay Đổi Đơn Hàng</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
            </div>
        </header>

        <section class="admin-page admin-page--active">
            <div class="filter-container">
                <div class="filter-item">
                    <label for="historySearch"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm:</label>
                    <input type="text" id="historySearch" placeholder="Nhập ID đơn, trường, người sửa...">
                </div>
                <button type="button" class="btn-history" onclick="location.href='${pageContext.request.contextPath}/admin/admin-orders'">
                    <i class="fa-solid fa-arrow-left"></i> Quay lại đơn hàng
                </button>
            </div>

            <table class="admin-table order-history-table">
                <thead>
                <tr>
                    <th>Thời gian</th>
                    <th>Đơn hàng</th>
                    <th>Trường thay đổi</th>
                    <th>Giá trị cũ</th>
                    <th>Giá trị mới</th>
                    <th>Người thay đổi</th>
                </tr>
                </thead>
                <tbody id="historyTableBody">
                <c:choose>
                    <c:when test="${empty histories}">
                        <tr>
                            <td colspan="6" class="empty-history">Chưa có lịch sử thay đổi đơn hàng.</td>
                        </tr>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="h" items="${histories}">
                            <tr>
                                <td><c:out value="${h.changedAtText}" /></td>
                                <td>#${h.orderId}</td>
                                <td><c:out value="${h.fieldName}" /></td>
                                <td class="history-value"><c:out value="${h.oldValue}" /></td>
                                <td class="history-value"><c:out value="${h.newValue}" /></td>
                                <td>
                                    <c:choose>
                                        <c:when test="${not empty h.changedByName}"><c:out value="${h.changedByName}" /></c:when>
                                        <c:otherwise>Không xác định</c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
                </tbody>
            </table>
        </section>
    </main>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const input = document.getElementById("historySearch");
        const rows = Array.from(document.querySelectorAll("#historyTableBody tr"));

        if (!input) return;

        input.addEventListener("input", function () {
            const keyword = input.value.toLowerCase();
            rows.forEach(function (row) {
                row.style.display = row.textContent.toLowerCase().includes(keyword) ? "" : "none";
            });
        });
    });
</script>
</body>
</html>
