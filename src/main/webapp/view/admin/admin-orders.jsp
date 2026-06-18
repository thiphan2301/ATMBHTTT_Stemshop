<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý đơn hàng</title>

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
            <h1>Quản Lý Đơn Hàng</h1>
            <div class="admin-info">
                <img src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="admin-avatar" alt="Admin">
            </div>
        </header>

        <section class="admin-page admin-page--active">
            <div class="filter-container">
                <div class="filter-item">
                    <label for="searchInput"><i class="fa-solid fa-magnifying-glass"></i> Tìm kiếm:</label>
                    <input type="text" id="searchInput" placeholder="Nhập ID hoặc tên...">
                </div>
                <div class="filter-item">
                    <label for="statusFilter"><i class="fa-solid fa-filter"></i> Phân loại:</label>
                    <select id="statusFilter">
                        <option value="ALL">Tất cả đơn hàng</option>
                        <option value="PENDING">Đang chờ xử lý</option>
                        <option value="SHIPPING">Đang giao hàng</option>
                        <option value="DELIVERED">Đã nhận hàng</option>
                        <option value="CANCELLED">Đã hủy / Bị trả</option>
                    </select>
                </div>
                <div class="filter-item">
                    <label for="sortFilter"><i class="fa-solid fa-sort"></i> Sắp xếp:</label>
                    <select id="sortFilter">
                        <option value="desc">Mới nhất đến lâu nhất</option>
                        <option value="asc">Lâu nhất đến mới nhất</option>
                    </select>
                </div>
            </div>

            <table class="admin-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Tên ngưòi nhận</th>
                    <th>Phương thức thanh toán</th>
                    <th>Trạng thái đơn hàng</th>
                    <th>Trạng thái thanh toán</th>
                    <th>Thao tác</th>
                </tr>
                </thead>
                <tbody id="orderTableBody">
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>#${o.id}</td>
                        <td>${o.receiverName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${o.paymentMethodId == 1}"><i class="fa-solid fa-money-bill-1-wave"></i> Tiền mặt (COD)</c:when>
                                <c:when test="${o.paymentMethodId == 2}"><i class="fa-solid fa-credit-card"></i> Chuyển khoản (VNPAY)</c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:choose>
                                <c:when test="${o.orderStatus == 'PENDING'}"><i class="fa-solid fa-hourglass-half"></i> Chờ xác nhận</c:when>
                                <c:when test="${o.orderStatus == 'SHIPPING'}"><i class="fa-solid fa-truck-arrow-right"></i> Đang giao</c:when>
                                <c:when test="${o.orderStatus == 'DELIVERED'}"><i class="fa-regular fa-circle-check"></i> Đã giao</c:when>
                                <c:when test="${o.orderStatus == 'CANCELLED'}"><i class="fa-regular fa-circle-xmark"></i> Đã hủy</c:when>
                                <c:otherwise>${o.orderStatus}</c:otherwise>
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
                            <c:if test="${o.orderStatus == 'PENDING'}">
                                <c:set var="canConfirm" value="false" />

                                <c:if test="${o.paymentMethodId == 1}">
                                    <c:set var="canConfirm" value="true" />
                                </c:if>

                                <c:if test="${o.paymentMethodId == 2 && o.paymentStatus == 'paid'}">
                                    <c:set var="canConfirm" value="true" />
                                </c:if>

                                <c:if test="${canConfirm == true}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/admin-orders" style="display:inline">
                                        <input type="hidden" name="orderId" value="${o.id}">
                                        <input type="hidden" name="action" value="confirm">
                                        <button type="submit" class="btn-success">Xác nhận</button>
                                    </form>
                                </c:if>

                                <c:if test="${o.paymentStatus != 'paid'}">
                                    <form method="post" action="${pageContext.request.contextPath}/admin/admin-orders" style="display:inline">
                                        <input type="hidden" name="orderId" value="${o.id}">
                                        <input type="hidden" name="action" value="cancel">
                                        <button type="submit" class="btn-danger">Hủy</button>
                                    </form>
                                </c:if>
                            </c:if>

                            <button type="button" class="btn-detail" onclick="openDetailPopup('${pageContext.request.contextPath}/orderDetails?id=${o.id}')">
                                Chi tiết
                            </button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </section>
    </main>
</div>

<div id="orderDetailModal" class="custom-modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeDetailPopup()">&times;</span>
        <iframe id="detailFrame" src=""></iframe>
    </div>
</div>

<script>
    // Hàm mở Popup
    function openDetailPopup(url) {
        document.getElementById("detailFrame").src = url;
        document.getElementById("orderDetailModal").style.display = "block";
        document.body.style.overflow = 'hidden'; // Ngăn cuộn trang nền
    }

    // Hàm đóng Popup
    function closeDetailPopup() {
        document.getElementById("orderDetailModal").style.display = "none";
        document.getElementById("detailFrame").src = "";
        document.body.style.overflow = 'auto'; // Cho cuộn lại bình thường
    }

    // Bấm ra ngoài vùng xám thì tắt modal
    window.onclick = function(e) {
        if (e.target == document.getElementById("orderDetailModal")) {
            closeDetailPopup();
        }
    }
</script>

<script src="${pageContext.request.contextPath}/assets/js/pages/admin-orders.js"></script>
</body>
</html>