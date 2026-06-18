<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Users </title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />

    <style>
        .btn-edit{
            padding: 5px 8px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            background-color: #FFC107;
            font-size: 12px;
            margin-left: 5px;
            text-decoration: none;
        }
        .btn-edit:hover{
            background-color: #FFC107;
            color: white;
        }
        .btn-lock{
            padding: 5px 8px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            background-color: #FF9800;
            font-size: 12px;
            margin-left: 5px;
        }
        .btn-lock:hover{
            background-color: #ff9800;
            color: white;
        }
        .btn-unlock{
            padding: 5px 8px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
            background-color: #4CAF50;
            font-size: 12px;
            margin-left: 5px;
        }
        .btn-unlock:hover{
            background-color: #45a049;
            color: white;
        }
        .btn-detail{
            background-color: #FFC107;
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
            <li class="admin-menu__item active">
                <i class="fa-solid fa-users"></i> Quản lý Người Dùng
            </li>
            <li class="admin-menu__item" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-products'">
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

    <!-- Main content -->
    <main class="admin-main">
        <!-- Topbar -->
        <header class="admin-topbar">
            <h1>Quản lý Người Dùng</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
            </div>
        </header>

        <!-- Thông báo cập nhật thông tin user thành công -->
        <c:if test="${not empty sessionScope.successMessage}">
            <div style="background-color: #d4edda; color: #155724; padding: 12px 20px; border-radius: 6px; margin-bottom: 20px; border: 1px solid #c3e6cb; font-size: 14px; font-weight: 500;">
                <i class="fas fa-check-circle" style="margin-right: 8px"></i> ${sessionScope.successMessage}
            </div>

            <c:remove var="successMessage" scope="session"/>
        </c:if>

        <!-- Users Section -->
        <section class="admin-page admin-page--active">
            <h2>Người dùng</h2>
            <input type="text" id="searchUser" placeholder="Tìm người dùng...">
            <div class="admin-table-wrapper">
                <table class="admin-table">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Tên</th>
                        <th>Email</th>
                        <th>Vai trò</th>
                        <th>Tác vụ</th>
                    </tr>
                    </thead>
                    <tbody id="usersTable">
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${not empty user.fullName ? user.fullName : "[Người dùng chưa cập nhật Họ Tên]"}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/admin-user" method="POST" style="display:inline;">
                                    <input type="hidden" name="action" value="updateUserStatus"/>
                                    <input type="hidden" name="id" value="${user.id}"/>
                                    <input type="hidden" name="status" value="${user.status}"/>

                                <c:choose>
                                    <c:when test="${user.status == 'ACTIVE'}">
                                        <button type="submit" class="btn-action btn-lock"
                                                onclick="return confirm('Xác nhận KHÓA tài khoản của ${user.fullName}?');">
                                                <i class="fas fa-lock"></i> Khóa
                                        </button>
                                    </c:when>
                                    <c:otherwise>
                                        <button type="submit" class="btn-action btn-unlock"
                                                onclick="return confirm('Xác nhận MỞ KHÓA tài khoản của ${user.fullName}?');">
                                                <i class="fas fa-key"></i> Mở khóa
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                                </form>
                                <a href="${pageContext.request.contextPath}/admin/admin-user-edit?id=${user.id}" class="btn-action btn-edit">
                                    <i class="fas fa-edit"></i> Sửa
                                </a>
                                <button class="btn-small lock btn-detail" onclick="window.location.href='${pageContext.request.contextPath}/admin/admin-user-detail?id=${user.id}'">Chi tiết</button>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>



</body>
</html>
