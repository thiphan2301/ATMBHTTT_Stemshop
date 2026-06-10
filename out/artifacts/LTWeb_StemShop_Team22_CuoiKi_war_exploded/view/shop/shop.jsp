<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Cửa hàng</title>

    <!-- CSS dùng file của bạn -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/shop.css">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>

<style>
    .product-actions {
        display: flex;
        gap: 20px;
        margin: 30px 0;
    }

    .product-actions button {
        border-radius: 10px;
        margin:auto;
    }
    .add-to-cart {
        background-color: #FF6C80;
        color: white;
        border: none;
        padding: 10px 30px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    .add-to-cart:hover {
        background-color: #ff3e5a;
    }
    .list-product__body__card__container{
        justify-content: flex-end;
    }
</style>

<body>

<!-- HEADER -->
<jsp:include page="/WEB-INF/components/header.jsp"/>

<main>

    <!-- breadcrumb -->
    <div class="back">
        <a href="${pageContext.request.contextPath}/index.jsp">Trang Chủ</a>
        <span>/</span>
        <a href="#">Cửa Hàng</a>
    </div>

    <div class="products">

        <!-- ========== SIDEBAR LEFT ========== -->
        <div class="product">

            <div class="product__category product__categorys">
                <h2>Danh Mục</h2>
                <ul>
                    <c:forEach var="c" items="${categories}">
                        <li>
                            <input type="checkbox" class="checkbox-category" value="${c.id}">
                            <span>${c.categoryName}</span>
                        </li>
                    </c:forEach>
                </ul>
            </div>

            <div class="product__category product__price">
                <h2>Giá</h2>
                <ul>
                    <li>
                        <input type="checkbox" class="checkbox-price" value="duoi200">
                        <span>Dưới 200.000 Đ</span>
                    </li>
                    <li>
                        <input type="checkbox" class="checkbox-price" value="200-1tr">
                        <span>200.000 Đ - 1.000.000 Đ</span>
                    </li>
                    <li>
                        <input type="checkbox" class="checkbox-price" value="1tr-2tr">
                        <span>1.000.000 Đ - 2.000.000 Đ</span>
                    </li>
                    <li>
                        <input type="checkbox" class="checkbox-price" value="2tr-4tr">
                        <span>2.000.000 Đ - 4.000.000 Đ</span>
                    </li>
                    <li>
                        <input type="checkbox" class="checkbox-price" value="tren4tr">
                        <span>Trên 4.000.000 Đ</span>
                    </li>
                </ul>
            </div>

<%--            <div class="product__category product__age">
                <h2>Độ tuổi</h2>
                <ul>
                    <li>
                        <input type="checkbox" class="checkbox-age" value="1-3">
                        <span>1-3 tuổi</span>
                    </li>
                    <li>
                        <input type="checkbox" class="checkbox-age" value="3-6">
                        <span>3-6 tuổi</span>
                    </li>
                    <li>
                        <input type="checkbox" class="checkbox-age" value="6-12">
                        <span>6-12 tuổi</span>
                    </li>
                    <li>
                        <input type="checkbox" class="checkbox-age" value="tren12">
                        <span>12 tuổi trở lên</span>
                    </li>

                </ul>
            </div>

            <!--       Giới tính         -->
            <div class="product__category product__sex">
                <h2>Giớ tính</h2>
                <ul>
                    <li>
                        <input type="checkbox" value="nam" class="checkbox-sex">
                        <span>Nam</span>
                    </li>
                    <li>
                        <input type="checkbox" value="nu" class="checkbox-sex">
                        <span>Nữ</span>
                    </li>
                </ul>
            </div>--%>

        </div>

        <!-- ========== PRODUCT LIST RIGHT ========== -->
        <div class="list-product">

            <div class="list-product__head">
                <div class="list-product__head__type">
                    <span>Kiểu xem: </span>
                    <ul>
                        <li id="head__type1"><i class="fa-solid fa-bars"></i></li>
                        <li id="head__type2"><i class="fa-solid fa-grip-lines-vertical"></i></li>
                        <li id="head__type3"><i class="fa-solid fa-bars fa-rotate-90"></i></li>
                    </ul>


                </div>

                <div class="list-product__head__search">
                    <span>Tìm kiếm: </span>
                    <input type="text" placeholder="Nhập tên sản phẩm" id="search-product">
                </div>

                <div class="list-product__head__arrange">
                    <span>Sắp xếp theo: </span>
                    <select id="sort-select">
                        <option value="default">Mặc định</option>
                        <option value="az">Sắp xếp theo A-Z</option>
                        <option value="za">Sắp xếp theo Z-A</option>
                        <option value="price-desc">Giá giảm dần</option>
                        <option value="price-asc">Giá tăng dần</option>
                    </select>
                </div>
            </div>

            <!-- body -->
            <div class="list-product__body">
                <div class="list-product__body__card">
                    <c:forEach var="p" items="${products}">
                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}"
                           class="product-link">
                            <div class="list-product__body__card__container"
                                 data-category="${p.categoriesID}"
                                 data-brand="${p.brandID}"
                                 data-price="${p.price}"
                                 data-name="${fn:toLowerCase(p.productName)}">

                                <!-- CLICK VÀO ĐÂY MỚI ĐI CHI TIẾT -->
                                <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}"
                                   class="product-link">

                                    <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                                         alt="${p.productName}" style="display: flex">

                                    <div class="list-product__body__card__content">
                                        <h5>${p.productName}</h5>
                                        <h4>${p.price} Đ</h4>
                                    </div>
                                </a>

                                <!-- NÚT THÊM GIỎ -->
                                <div class="product-actions">
                                    <button type="button"
                                            class="add-to-cart"
                                            onclick="addToCart(${p.id})">
                                        Thêm vào giỏ hàng
                                        <i class="fa-solid fa-cart-plus"></i>
                                    </button>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
                <div class="pagination" style="text-align:center;margin:40px 0">

                    <c:if test="${currentPage > 1}">
                        <a href="${pageContext.request.contextPath}/shop?page=${currentPage - 1}">
                            &laquo;
                        </a>
                    </c:if>

                    <c:forEach begin="1" end="${totalPages}" var="i">
                        <a href="${pageContext.request.contextPath}/shop?page=${i}"
                           class="${i == currentPage ? 'active' : ''}">
                                ${i}
                        </a>
                    </c:forEach>

                    <c:if test="${currentPage < totalPages}">
                        <a href="${pageContext.request.contextPath}/shop?page=${currentPage + 1}">
                            &raquo;
                        </a>
                    </c:if>

                </div>
            </div>

        </div>
    </div>

</main>

<!-- FOOTER -->
<jsp:include page="/WEB-INF/components/footer.jsp"/>

<!-- JS dùng file của bạn -->
<script src="${pageContext.request.contextPath}/assets/js/pages/shop.js"></script>
<script>
    const contextPath = '${pageContext.request.contextPath}';
</script>
<script src="${pageContext.request.contextPath}/assets/js/pages/cart.js"></script>

</body>
</html>
