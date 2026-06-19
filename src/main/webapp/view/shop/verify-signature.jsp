<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Ký Xác Thực Đơn Hàng</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>

    <style>
        .verify-container { width: 50%; margin: 50px auto; padding: 20px; border: 1px solid #ccc; border-radius: 10px; font-family: Arial, sans-serif;}
        .form-group { margin-bottom: 20px; }
        textarea { width: 100%; padding: 10px; font-family: monospace; font-size: 14px; margin-bottom: 1rem;}
        .btn-copy, .btn-submit { padding: 10px 20px; background-color: #ff6600; color: white; border: none; cursor: pointer; border-radius: 5px;}
        .error-msg { color: red; font-weight: bold; margin-bottom: 15px;}
        .download-link { display: block; margin-top: 20px; text-align: center; color: blue; text-decoration: underline;}
        .btn-back {
            background: #6c757d;
            color: white;
            border: none;
            padding: 10px 18px;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            transition: 0.3s;
            margin-bottom: 20px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .btn-back:hover {
            background: #5e5e5e;
        }
    </style>
</head>
<body>
<button class="btn-back" onclick="window.location.href='${pageContext.request.contextPath}/my-orders'">
    <i class="fas fa-arrow-left"></i> Quay lại
</button>
<div class="verify-container">
    <h2>Ký Xác Thực Đơn Hàng #${order.id}</h2>

    <c:if test="${not empty error}">
        <div class="error-msg">${error}</div>
    </c:if>

    <div class="form-group">
        <label><b>Chuỗi dữ liệu đơn hàng</b></label>
        <textarea id="rawData" rows="2" readonly>${rawOrderData}</textarea>
        <button type="button" class="btn-copy" onclick="copyRawData()">Copy chuỗi</button>
    </div>

    <form action="${pageContext.request.contextPath}/verify-signature" method="post">
        <input type="hidden" name="orderId" value="${order.id}">

        <div class="form-group">
            <label><b>Chữ ký</b></label>
            <textarea name="signatureData" rows="6" required placeholder="Dán chữ ký vào đây..."></textarea>
        </div>

        <button type="submit" class="btn-submit">Xác nhận chữ ký</button>
    </form>

    <a href="${pageContext.request.contextPath}/assets/tools/SignTool.rar" class="download-link"><i class="fa-solid fa-download"></i> Tải Tool Ký Số</a>
</div>

<script>
    function copyRawData() {
        var copyText = document.getElementById("rawData");
        copyText.select();
        document.execCommand("copy");
        alert("Đã copy chuỗi dữ liệu gốc!");
    }
</script>
</body>
</html>
