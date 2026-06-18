<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Nhập Hàng - Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/admin.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        .form-container { background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); max-width: 700px; margin: 20px auto; }
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: bold; margin-bottom: 8px; color: #333; }
        .form-control { width: 100%; padding: 10px; border-radius: 5px; border: 1px solid #ccc; box-sizing: border-box; }
        .flex-group { display: flex; gap: 20px; }
        .flex-item { flex: 1; }
        .btn-group { display: flex; justify-content: flex-end; gap: 10px; margin-top: 20px; }
        .btn-save { background: #28a745; color: white; padding: 10px 20px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; }
        .btn-back { background: #6c757d; color: white; padding: 10px 20px; border: none; border-radius: 5px; text-decoration: none; text-align: center; }
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
            <h1>Nhập Kho Hàng Hóa Mới</h1>
        </header>

        <div class="form-container">
            <form action="${pageContext.request.contextPath}/admin/admin-product-import" method="POST">

                <div class="form-group">
                    <label>Chọn Sản Phẩm Cần Nhập Kho (*)</label>
                    <select name="productId" class="form-control" required>
                        <option value="">-- Chọn sản phẩm --</option>
                        <c:forEach var="p" items="${products}">

                            <c:choose>
                                <c:when test="${p[2] >= 20}">
                                    <option value="${p[0]}" disabled style="color: #adb5bd; background-color: #f8f9fa;">
                                        [ID: ${p[0]}] - ${p[1]} (Còn ${p[2]} SP - Số lượng còn nhiều, chưa cần nhập)
                                    </option>
                                </c:when>

                                <c:otherwise>
                                    <option value="${p[0]}" style="color: #28a745; font-weight: bold;">
                                        [ID: ${p[0]}] - ${p[1]} (Đang sắp hết - Còn ${p[2]} SP)
                                    </option>
                                </c:otherwise>
                            </c:choose>

                        </c:forEach>
                    </select>
                </div>

                <div class="flex-group">
                    <div class="form-group flex-item">
                        <label>Số lượng (*)</label>
                        <input type="number" name="quantity" min="1" class="form-control" placeholder="Nhập số lượng..." required>
                    </div>
                    <div class="form-group flex-item">
                        <label>Giá nhập trên 1 SP (VNĐ) (*)</label>
                        <input type="number" name="importPrice" min="0" step="1000" class="form-control" placeholder="Ví dụ: 150000" required>
                    </div>
                </div>

                <div class="form-group">
                    <label>Thời hạn sử dụng dự kiến (Tính bằng Tháng)</label>
                    <input type="number" name="lifespanMonths" min="1" class="form-control" placeholder="Ví dụ: 36 (Để trống nếu không giới hạn)">
                </div>

                <div class="form-group">
                    <label>Ghi chú</label>
                    <textarea name="note" rows="4" class="form-control" placeholder="Ghi chú thêm về lô hàng này..."></textarea>
                </div>

                <div class="btn-group">
                    <a href="${pageContext.request.contextPath}/admin/admin-products" class="btn-back">Hủy bỏ</a>
                    <button type="submit" class="btn-save"><i class="fas fa-save"></i> Xác Nhận Nhập Kho</button>
                </div>
            </form>
        </div>
    </main>
</div>
</body>
</html>