<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng </title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        .admin-table .btn-success{
            padding: 5px;
            border-radius: 5px;
            border: none;
            background-color: #4CAF50;
            color: white;
        }
        .admin-table .btn-success:hover{
            background-color: #35bc3a;
            transition: ease .4s;
        }
        .admin-table .btn-danger{
            padding: 5px;
            border-radius: 5px;
            border: none;
            background-color:  #df4848;
            color: white;
        }
        .admin-table .btn-danger:hover{
            background-color: #d9534f;
            transition: ease .4s;
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
            <li class="admin-menu__item">
                <i class="fa-solid fa-users"></i> Quản lý Người Dùng
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-products'">
                <i class="fa-solid fa-box"></i> Quản lý Sản Phẩm
            </li>
            <li class="admin-menu__item active" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-orders'">
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

    <!-- Main content -->
    <main class="admin-main">
        <!-- Topbar -->
        <header class="admin-topbar">
            <h1>Quản Lý Đơn Hàng</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
            </div>
        </header>

        <!-- Users Section -->
        <section class="admin-page admin-page--active">
            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Khách hàng</th>
                    <th>SĐT</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>#${o.id}</td>
                        <td>${o.userFullName}</td>
                        <td>${o.userPhone}</td>
                        <td>
                            <fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy HH:mm"/>
                        </td>
                        <td>
                            <fmt:formatNumber value="${o.totalAmount}" type="currency" currencySymbol="₫"/>
                        </td>
                        <td>${o.orderStatus}</td>
                        <td>
                            <c:if test="${o.orderStatus == 'PENDING'}">
                                <form method="post" style="display:inline">
                                    <input type="hidden" name="orderId" value="${o.id}">
                                    <input type="hidden" name="action" value="confirm">
                                    <button class="btn btn-success">Xác nhận</button>
                                </form>

                                <form method="post" style="display:inline">
                                    <input type="hidden" name="orderId" value="${o.id}">
                                    <input type="hidden" name="action" value="cancel">
                                    <button class="btn btn-danger">Hủy</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </section>
    </main>
</div>



</body>
</html>