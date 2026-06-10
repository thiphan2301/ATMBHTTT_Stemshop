<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý giao hàng </title>

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
        .admin-table .btn-detail{
            padding: 5px;
            border-radius: 5px;
            border: none;
            background-color: #eadf21;
            color: white;
        }
        .admin-table .btn-detail:hover{
            background-color: #eadf21;
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
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-user'">
                <i class="fa-solid fa-users"></i> Quản lý Người Dùng
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-products'">
                <i class="fa-solid fa-box"></i> Quản lý Sản Phẩm
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-orders'">
                <i class="fa-solid fa-shopping-cart"></i> Quản lý Đơn Hàng
            </li>
            <li class="admin-menu__item active" onclick="location.href='${pageContext.request.contextPath}/admin/shipping'">
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

    <!-- Main content -->
    <main class="admin-main">
        <!-- Topbar -->
        <header class="admin-topbar">
            <h1>Quản Lý Giao Hàng</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
            </div>
        </header>

        <!-- Users Section -->
        <section class="admin-page admin-page--active">
            <%-- Bắt đầu vùng hiển thị thông báo --%>
            <c:if test="${not empty sessionScope.success}">
                <div style="background: #d4edda; padding: 10px; margin-bottom: 15px; border-radius: 5px; color: #155724;">
                        ${sessionScope.success}
                </div>
                <c:remove var="success" scope="session" />
            </c:if>

            <c:if test="${not empty sessionScope.error}">
                <div style="background: #f8d7da; padding: 10px; margin-bottom: 15px; border-radius: 5px; color: #721c24;">
                        ${sessionScope.error}
                </div>
                <c:remove var="error" scope="session" />
            </c:if>
            <%-- Kết thúc vùng hiển thị thông báo --%>
            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên ngưòi nhận</th>
                    <th>SDT người nhận</th>
                    <th>Phương thức thanh toán</th>
                    <th>Trạng thái thanh toán</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="o" items="${shippingOrders}">
                    <tr>
                        <td>#${o.id}</td>
                        <td>${o.receiverName}</td>
                        <td>${o.receiverPhone}</td>
                        <td>
                            <c:choose>
                                <c:when test="${o.paymentMethodId == 1}"><i class="fa-solid fa-money-bill-1-wave"></i> Tiền mặt (COD)</c:when>
                                <c:when test="${o.paymentMethodId == 2}"><i class="fa-solid fa-credit-card"></i> Chuyển khoản (VNPAY)</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${o.paymentStatus == 'paid'}">
                                    <span style="color: green;"><i class="fa-regular fa-circle-check"></i> Đã thanh toán</span>
                                </c:when>
                                <c:when test="${o.paymentStatus == 'failed'}">
                                    <span style="color: red;"><i class="fa-regular fa-circle-xmark"></i> Thất bại</span>
                                </c:when>
                                <c:when test="${o.paymentStatus == 'pending'}">
                                    <span style="color: orange;"><i class="fa-solid fa-hourglass-half"></i>  Chờ thanh toán</span>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: gray;">Chưa thanh toán</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <form method="post" action="${pageContext.request.contextPath}/admin/shipping" style="display:inline;">
                                <input type="hidden" name="orderId" value="${o.id}">
                                <input type="hidden" name="action" value="delivered">
                                <button type="submit" class="btn-success" onclick="return confirm('Xác nhận đã giao hàng cho đơn #${o.id}?')">
                                    <i class="fa-regular fa-circle-check"></i> Xác nhận đã giao
                                </button>
                            </form>
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