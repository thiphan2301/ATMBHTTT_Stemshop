<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>Sản phẩm yêu thích</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
    <style>
        .back {
            background-color: #f6f5f4;
            font-size: 13px;
            padding: 10px;
        }

        .back a,
        .back span {
            text-decoration: none;
            color: #a1a0a0;
            margin-left: 20px;
        }
        .btn-add-heart:hover{
            background: #d59b0d;
            transition: .3s;
        }
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/components/header.jsp"/>

<div class="back">
    <a href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a>
    <span>/</span>
    <a href="#">Yêu thích</a>
</div>

<h2 style="text-align:center;margin:30px 0">Danh sách sản phẩm yêu thích</h2>

<c:if test="${empty products}">
    <p style="text-align:center">Bạn chưa có sản phẩm yêu thích nào.</p>
</c:if>

<div style="max-width:1000px;margin:auto">
    <c:forEach var="p" items="${products}">
        <div class="wishlist-item"
             id="wishlist-item-${p.id}"
             style="display:flex;gap:20px;padding:15px;border-bottom:1px solid #ddd">

            <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                 width="100" height="100" style="object-fit:cover">

            <div style="flex:1" >
                <h3>${p.productName}</h3>
                <p>${p.price} Đ</p>

                <button onclick="addToCart(${p.id})" style="border: 1px solid #333; border-radius: 20px; padding: 5px; margin: 5px;" class="btn-add-heart">
                    <i class="fa-solid fa-cart-plus"></i> Thêm vào giỏ
                </button>

                <button onclick="removeFromWishlist(${p.id})"
                        style="border: 1px solid #333; border-radius: 20px; padding: 5px; margin: 5px;"
                        class="btn-add-heart">
                    <i class="fa-solid fa-heart" style="color:red"></i> Bỏ yêu thích
                </button>
            </div>
        </div>
    </c:forEach>
</div>

<jsp:include page="/WEB-INF/components/footer.jsp"/>

</body>
</html>