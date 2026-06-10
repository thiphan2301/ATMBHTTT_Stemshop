<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Thông tin đơn hàng #${order.id}</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

  <style>
    body {
      background-color: #f5f5f5;
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
      margin: 0;
    }
    .app-container {
      max-width: 100%; /* Đã mở rộng tối đa theo kích thước của Iframe/Modal */
      margin: 0 auto;
      background-color: #f5f5f5;
      min-height: 100vh;
      padding-bottom: 20px;
    }
    .header-top {
      background-color: #fff;
      padding: 15px;
      display: flex;
      justify-content: center; /* Căn giữa tiêu đề */
      align-items: center;
      font-size: 1.2rem;
      font-weight: 600;
      position: sticky;
      top: 0;
      z-index: 100;
      border-bottom: 1px solid #eaeaea; /* Thêm viền dưới cho đẹp */
    }
    .status-banner {
      background-color: #26aa99;
      color: white;
      padding: 20px 15px;
      font-size: 1.1rem;
      font-weight: 500;
    }
    .card-box {
      background-color: #fff;
      margin-top: 10px;
      padding: 15px;
    }
    .address-header { font-size: 1rem; font-weight: 500; margin-bottom: 10px; display: flex; align-items: center; }
    .address-content { display: flex; gap: 10px; color: #333; }
    .address-icon { color: #888; font-size: 1.2rem; margin-top: 3px; }
    .address-text { font-size: 0.9rem; color: #777; margin-top: 4px; }
    .shop-name { font-weight: 600; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
    .product-item { display: flex; gap: 10px; margin-bottom: 10px; }
    .product-item img { width: 80px; height: 80px; border: 1px solid #eee; object-fit: cover; border-radius: 4px; }
    .product-info { flex: 1; display: flex; flex-direction: column; justify-content: space-between; }
    .product-name { font-size: 0.95rem; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
    .info-row { display: flex; justify-content: space-between; margin-bottom: 10px; font-size: 0.9rem; }
    .info-label { color: #777; }
    .info-value { color: #333; text-align: right; }
    .info-value.bold { font-weight: 500; }
    .total-row { display: flex; justify-content: space-between; align-items: center; border-top: 1px dashed #eee; padding-top: 12px; margin-top: 5px; }
    .total-label { font-weight: 500; font-size: 1rem; }
    .total-price { color: #ee4d2d; font-size: 1.3rem; font-weight: bold; }
  </style>
</head>
<body>

<div class="app-container">

  <div class="header-top">
    <span>Thông tin đơn hàng #${order.id}</span>
  </div>

  <div class="status-banner">
    <c:choose>
      <c:when test="${order.orderStatus == 'PENDING'}">Chờ xác nhận</c:when>
      <c:when test="${order.orderStatus == 'CANCEL_REQUESTED'}">Đang chờ duyệt hủy</c:when>
      <c:when test="${order.orderStatus == 'CONFIRMED'}">Đang giao hàng</c:when>
      <c:when test="${order.orderStatus == 'DELIVERED'}">Đã giao thành công</c:when>
      <c:when test="${order.orderStatus == 'RETURN_PENDING'}">Chờ duyệt trả hàng</c:when>
      <c:when test="${order.orderStatus == 'RETURNED'}">Đã trả hàng/hoàn tiền</c:when>
      <c:when test="${order.orderStatus == 'CANCELLED'}">Đã hủy đơn</c:when>
      <c:otherwise>${order.orderStatus}</c:otherwise>
    </c:choose>
  </div>

  <div class="card-box">
    <div class="address-header">Địa chỉ nhận hàng</div>
    <div class="address-content">
      <i class="fa-solid fa-location-dot address-icon"></i>
      <div>
        <div style="font-weight: 500;">
          ${order.receiverName} <span style="color: #888; font-weight: normal;">(+84) ${order.receiverPhone}</span>
        </div>
        <div class="address-text">${order.shippingAddress}</div>
      </div>
    </div>
  </div>

  <div class="card-box">
    <div class="shop-name"><i class="fa-solid fa-store me-2"></i> StaemShop</div>

    <c:forEach var="item" items="${order.items}">
      <div class="product-item" style="border-bottom: 1px solid #f5f5f5; padding-bottom: 10px; margin-bottom: 10px;">
        <img src="${pageContext.request.contextPath}/${item.imageUrl}" alt="${item.productName}">
        <div class="product-info">
          <div class="product-name">${item.productName}</div>
          <div class="d-flex justify-content-between align-items-end">
            <span class="text-muted" style="font-size: 0.9rem;">x${item.quantity}</span>
            <span style="font-size: 0.95rem; color: #333; font-weight: 500;">
                <fmt:formatNumber value="${item.price}" type="currency" currencySymbol="₫"/>
            </span>
          </div>
        </div>
      </div>
    </c:forEach>
  </div>

  <div class="card-box">
    <div class="info-row">
      <span class="info-label">Mã khuyến mãi áp dụng</span>
      <span class="info-value">
        <c:choose>
          <c:when test="${not empty order.promotionId}">
            <span class="badge bg-success">${order.promotionId}</span>
          </c:when>
          <c:otherwise>Không có</c:otherwise>
        </c:choose>
      </span>
    </div>

    <div class="info-row">
      <span class="info-label">Tổng tiền sản phẩm</span>
      <span class="info-value">
           <fmt:formatNumber value="${order.totalAmount - order.shippingFee}" type="currency" currencySymbol="₫"/>
      </span>
    </div>

    <div class="info-row">
      <span class="info-label">Phí vận chuyển</span>
      <span class="info-value">
          <fmt:formatNumber value="${order.shippingFee}" type="currency" currencySymbol="₫"/>
      </span>
    </div>

    <div class="total-row mt-3">
      <span class="total-label">Thành tiền thanh toán:</span>
      <span class="total-price">
           <fmt:formatNumber value="${order.totalAmount}" type="currency" currencySymbol="₫"/>
      </span>
    </div>
  </div>

  <div class="card-box">
    <div class="info-row">
      <span class="info-label">Mã đơn hàng</span>
      <span class="info-value bold">${order.id}</span>
    </div>

    <div class="info-row">
      <span class="info-label">Phương thức thanh toán</span>
      <span class="info-value">${order.paymentMethodId == 2 ? "VNPay" : "Thanh toán khi nhận hàng (COD)"}</span>
    </div>

    <div class="info-row">
      <span class="info-label">Thời gian đặt hàng</span>
      <span class="info-value">
          <fmt:formatDate value="${order.orderDate}" pattern="dd-MM-yyyy HH:mm" />
      </span>
    </div>

    <div class="info-row">
      <span class="info-label">Ghi chú của khách</span>
      <span class="info-value" style="max-width: 60%; text-align: right;">
          <c:out value="${empty order.note ? 'Không có ghi chú' : order.note}" />
      </span>
    </div>
  </div>

</div>

</body>
</html>