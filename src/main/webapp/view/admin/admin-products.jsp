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
        .table-actions { margin-bottom: 20px; }
        .search-form { display: inline-block; }
        .search-input {
            padding: 10px 15px; border: 1px solid #ddd; border-radius: 6px; width: 300px; font-size: 14px;
        }
        .btn-action {
            padding: 6px 12px; border: none; border-radius: 5px; cursor: pointer; color: white;
            font-size: 12px; margin-right: 5px; transition: 0.3s; text-decoration: none; display: inline-block;
        }
        .btn-edit { background: #ffc107; }
        .btn-edit:hover { background: #e0a800; }
        .btn-delete { background: #dc3545; }
        .btn-delete:hover { background: #c82333; }

        .btn-product-detail {
            background: #dc2c9e; border: none; cursor: pointer; padding: 6px 12px;
            border-radius: 5px; color: white; font-size: 12px; margin-right: 5px; transition: 0.3s; text-decoration: none; display: inline-block;
        }
        .btn-product-detail:hover { background: #b92082; color: #fff; }

        .admin-table th:nth-child(5), .admin-table td:nth-child(5) { width: 8%; }
        .admin-info { display: flex; align-items: center; gap: 8px; }
        .admin-avatar { width: 45px; height: 45px; border-radius: 50%; object-fit: cover; }
        .delete-form { display: inline; }

        /* --- CSS CHO MODAL CHI TIẾT SẢN PHẨM --- */
        .product-modal {
            display: none; position: fixed; z-index: 9999; left: 0; top: 0;
            width: 100%; height: 100%; overflow: hidden;
            background-color: rgba(0, 0, 0, 0.5); backdrop-filter: blur(5px);
        }
        .product-modal-content {
            background-color: #fff; margin: 3% auto; padding: 15px;
            border-radius: 12px; width: 85%; max-width: 1200px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3); animation: fadeInDown 0.4s ease; position: relative;
        }
        .product-modal-close {
            color: #aaa; position: absolute; top: 10px; right: 20px;
            font-size: 32px; font-weight: bold; cursor: pointer; transition: 0.3s; z-index: 10000;
        }
        .product-modal-close:hover { color: #dc3545; }
        @keyframes fadeInDown {
            from { transform: translateY(-30px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
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
            <h1>Quản lý Sản Phẩm</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
                <span>Admin</span>
            </div>
        </header>

        <div>
            <div class="table-actions" style="display: flex; justify-content: space-between; align-items: center;">
                <form method="get" class="search-form">
                    <input type="text" name="search" placeholder="Tìm sản phẩm..." class="search-input" >
                </form>

                <div class="action-btn-group" style="display: flex; gap: 10px;">
                    <a href="${pageContext.request.contextPath}/admin/admin-import-history" class="btn-action" style="background: #17a2b8;">
                        <i class="fas fa-history"></i> Lịch sử nhập
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/admin-product-import" class="btn-action" style="background: #28a745; padding: 10px 20px;">
                        <i class="fas fa-truck-loading"></i> Nhập hàng
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/admin-product-add" class="btn-action" style="background: #ff8ab8; padding: 10px 20px;">
                        <i class="fas fa-plus"></i> Thêm sản phẩm mới
                    </a>
                </div>
            </div>
<%--            Thông báo--%>
            <div style="margin-top: 20px;">
                <c:if test="${not empty sessionScope.message}">
                    <div style="padding: 12px 20px; background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 10px;">
                        <i class="fa-solid fa-circle-check"></i> ${sessionScope.message}
                    </div>
                    <c:remove var="message" scope="session" />
                </c:if>

                <c:if test="${not empty sessionScope.error}">
                    <div style="padding: 12px 20px; background: #ffebee; color: #c62828; border: 1px solid #ffcdd2; border-radius: 8px; font-weight: 500; display: flex; align-items: center; gap: 10px;">
                        <i class="fa-solid fa-circle-exclamation"></i> ${sessionScope.error}
                    </div>
                    <c:remove var="error" scope="session" />
                </c:if>
            </div>

            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
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
                        <td><fmt:formatNumber value="${product.price}" pattern="#,###"/> Đ</td>
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

                            <a href="${pageContext.request.contextPath}/admin/admin-product-detail?id=${product.id}" class="btn-product-detail">
                                <i class="fas fa-eye"></i> Chi tiết
                            </a>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty products}">
                    <tr><td colspan="6" style="text-align: center; padding: 20px; color: #999;">Chưa có sản phẩm nào</td></tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </main>
</div>

<div id="productDetailModal" class="product-modal">
    <div class="product-modal-content">
        <span class="product-modal-close" onclick="closeProductDetail()">&times;</span>
        <div class="product-modal-body">
            <iframe id="detailIframe" src="" style="width:100%; height:80vh; border:none; display:block;"></iframe>
        </div>
    </div>
</div>


</body>
</html>