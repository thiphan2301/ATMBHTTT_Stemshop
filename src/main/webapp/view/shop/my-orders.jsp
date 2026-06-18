<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Đơn hàng của tôi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body>

<jsp:include page="/WEB-INF/components/header.jsp"/>

<div class="container">
    <h2 style="text-align:center; margin: 30px 0;">Đơn hàng của tôi</h2>

    <div class="order-tabs">
        <button class="tab-btn active" onclick="filterOrders('ALL', this)">Tất cả</button>
        <button class="tab-btn" onclick="filterOrders('PENDING', this)">Chờ xác nhận</button>
        <button class="tab-btn" onclick="filterOrders('SHIPPING', this)">Đang giao hàng</button>
        <button class="tab-btn" onclick="filterOrders('DELIVERED', this)">Đã giao</button>
        <button class="tab-btn" onclick="filterOrders('RETURNED', this)">Trả hàng</button>
        <button class="tab-btn" onclick="filterOrders('CANCELLED', this)">Đã hủy</button>
    </div>

    <c:forEach var="order" items="${orders}">
        <c:set var="tabCategory" value="${order.orderStatus}" />
        <c:if test="${order.orderStatus == 'RETURN_PENDING' || order.orderStatus == 'RETURNED'}">
            <c:set var="tabCategory" value="RETURNED" />
        </c:if>
        <c:if test="${order.orderStatus == 'CANCEL_REQUESTED'}">
            <c:set var="tabCategory" value="PENDING" />
        </c:if>

        <div class="order-box" data-status="${tabCategory}">
            <div class="order-header">
                <span><strong>Đơn hàng #${order.id}</strong></span>
                <span class="order-status">
                    <c:choose>
                        <c:when test="${order.signatureStatus == 'CHO_KY_SO'}">
                            <span style="color: #ff9800; font-weight: bold;"><i class="fas fa-file-signature"></i> Đang chờ ký xác thực</span>
                        </c:when>
                        <c:when test="${order.orderStatus == 'PENDING'}">Chờ xác nhận</c:when>
                        <c:when test="${order.orderStatus == 'CANCEL_REQUESTED'}">Đang chờ duyệt hủy</c:when>
                        <c:when test="${order.orderStatus == 'SHIPPING'}">Đang giao hàng</c:when>
                        <c:when test="${order.orderStatus == 'DELIVERED'}">Đã giao</c:when>
                        <c:when test="${order.orderStatus == 'RETURN_PENDING'}">Chờ duyệt trả hàng</c:when>
                        <c:when test="${order.orderStatus == 'RETURNED'}">Đã trả hàng/hoàn tiền</c:when>
                        <c:when test="${order.orderStatus == 'CANCELLED'}">Đã hủy</c:when>
                        <c:otherwise>${order.orderStatus}</c:otherwise>
                    </c:choose>
                </span>
            </div>

            <c:forEach var="item" items="${order.items}">
                <div class="product-item" style="border-bottom: 1px solid #f9f9f9; padding: 10px 0;">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${item.productId}"><img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.productName}" ></a>
                    <div class="product-info">
                        <p><strong>
                            <a href="${pageContext.request.contextPath}/product-detail?id=${item.productId}">${item.productName}</a>
                        </strong></p>
                        <p class="text-muted">Số lượng: ${item.quantity}</p>
                        <p>Giá sản phẩm: <strong style="color: var(--accent-color);">
                            <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"/>
                        </strong></p>
                    </div>
                </div>
            </c:forEach>

            <div style="text-align: right; padding: 15px 0; border-top: 1px dashed #eee;">
                <span>Thành tiền đơn hàng: </span>
                <strong style="color: #ee4d2d; font-size: 1.25rem;">
                    <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
                </strong>
            </div>

            <div class="order-actions">
                <c:choose>
                    <c:when test="${order.signatureStatus == 'CHO_KY_SO'}">
                        <span class="sign-countdown" data-id="${order.id}" data-time="${order.orderDate.time}" style="color: red; font-weight: bold; margin-right: 15px; font-size: 16px;"></span>

                        <button id="btn-sign-${order.id}" class="action-btn btn-orange" style="background-color: #ff9800; color: white; border-color: #ff9800;" onclick="window.location.href='${pageContext.request.contextPath}/verify-signature?orderId=${order.id}'">
                            <i class="fas fa-pen-nib"></i> Ký xác nhận ngay
                        </button>

                        <button class="action-btn btn-red" onclick="cancelOrder('${order.id}')">Hủy đơn</button>
                    </c:when>

                    <c:otherwise>
                        <button class="action-btn btn-blue" onclick="openDetailPopup('${pageContext.request.contextPath}/orderDetails?id=${order.id}')">Xem chi tiết</button>

                        <c:if test="${order.orderStatus == 'PENDING' && order.paymentStatus != 'paid' && order.paymentMethodId == 2}">
                            <button class="action-btn btn-orange" style="background-color: #ff9800; color: white; border-color: #ff9800;" onclick="continuePayment('${order.id}')">Tiếp tục thanh toán</button>
                        </c:if>

                        <c:if test="${order.orderStatus == 'PENDING'}">
                            <button class="action-btn btn-red" onclick="cancelOrder('${order.id}')">Hủy đơn</button>
                        </c:if>

                        <c:if test="${order.orderStatus == 'SHIPPING'}">
                            <button class="action-btn btn-green" onclick="confirmReceived('${order.id}')">Đã nhận được hàng</button>
                        </c:if>

                        <c:if test="${order.orderStatus == 'DELIVERED'}">
                            <button class="action-btn btn-gray" onclick="requestReturn('${order.id}')">Trả hàng / Hoàn tiền</button>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </c:forEach>

    <div id="empty-filter-msg" style="text-align: center; color: #888; display: none; margin-top: 50px;">
        <i class="fa-regular fa-clipboard-list" style="font-size: 50px; margin-bottom: 10px;"></i>
        <p>Không tìm thấy đơn hàng nào phù hợp.</p>
    </div>
</div>

<div id="orderDetailModal" class="custom-modal">
    <div class="modal-content">
        <span class="close-btn" onclick="closeDetailPopup()">&times;</span>
        <iframe id="detailFrame" src=""></iframe>
    </div>
</div>

<script>
    // đếmm ngược 24h
    document.addEventListener("DOMContentLoaded", function() {
        const signTimers = document.querySelectorAll('.sign-countdown');
        signTimers.forEach(timer => {
            const orderId = timer.getAttribute('data-id');
            // Lấy Timestamp lúc tạo đơn (từ DB)
            const orderTimestamp = parseInt(timer.getAttribute('data-time'));

            // Hạn chót = Lúc tạo + 24 giờ (Tính bằng mili-giây)
            const deadline = orderTimestamp + (24 * 60 * 60 * 1000);

            const x = setInterval(function() {
                const now = new Date().getTime();
                const distance = deadline - now;

                if (distance < 0) {
                    clearInterval(x);
                    timer.innerHTML = "Đã quá hạn ký xác thực (Đơn hàng bị hủy)!";
                    // Ẩn nút ký đi vì đã hết hạn
                    document.getElementById('btn-sign-' + orderId).style.display = 'none';

                    // GỌI API NGẦM ĐỂ HỦY ĐƠN TRONG DATABASE (Nếu bạn muốn tự động hóa)
                    // fetch('${pageContext.request.contextPath}/cancelOrder?id=' + orderId + '&type=auto');
                } else {
                    const hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
                    const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
                    const seconds = Math.floor((distance % (1000 * 60)) / 1000);
                    timer.innerHTML = "⏳ Hạn ký còn: " + hours + "h " + minutes + "m " + seconds + "s";
                }
            }, 1000);
        });
    });

    function filterOrders(status, btn) {
        document.querySelectorAll('.tab-btn').forEach(t => t.classList.remove('active'));
        btn.classList.add('active');

        let hasOrder = false;
        document.querySelectorAll('.order-box').forEach(box => {
            if (status === 'ALL' || box.getAttribute('data-status') === status) {
                box.style.display = 'block';
                hasOrder = true;
            } else {
                box.style.display = 'none';
            }
        });

        document.getElementById('empty-filter-msg').style.display = hasOrder ? 'none' : 'block';
    }

    function openDetailPopup(url) {
        document.getElementById("detailFrame").src = url;
        document.getElementById("orderDetailModal").style.display = "block";
        document.body.style.overflow = 'hidden';
    }

    function closeDetailPopup() {
        document.getElementById("orderDetailModal").style.display = "none";
        document.getElementById("detailFrame").src = "";
        document.body.style.overflow = 'auto';
    }

    function confirmReceived(id) {
        if(confirm("Bạn chắc chắn đã nhận được kiện hàng này?")) {
            window.location.href = "${pageContext.request.contextPath}/confirmOrder?id=" + id;
        }
    }

    function cancelOrder(id) {
        if(confirm("Xác nhận hủy đơn hàng này?")) {
            window.location.href = "${pageContext.request.contextPath}/cancelOrder?id=" + id + "&type=direct";
        }
    }

    function requestReturn(id) {
        let reason = prompt("Lý do bạn muốn trả hàng:");
        if(reason && reason.trim() !== "") {
            window.location.href = "${pageContext.request.contextPath}/returnOrder?id=" + id + "&reason=" + encodeURIComponent(reason);
        }
    }

    window.onclick = function(e) {
        if (e.target == document.getElementById("orderDetailModal")) closeDetailPopup();
    }
    function continuePayment(id) {
        window.location.href = "${pageContext.request.contextPath}/vnpay-payment?orderId=" + id;
    }
</script>

<jsp:include page="/WEB-INF/components/footer.jsp"/>
</body>
</html>