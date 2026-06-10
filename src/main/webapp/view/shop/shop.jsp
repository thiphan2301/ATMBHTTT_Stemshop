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

<script>
    const contextPath = '${pageContext.request.contextPath}';

    // Submit form khi lọc
    function submitForm() {
        document.getElementById('pageInput').value = 1;
        document.getElementById('filterForm').submit();
    }

    // Chuyển trang
    function goToPage(page) {
        document.getElementById('pageInput').value = page;
        document.getElementById('filterForm').submit();
    }

    // Debounce cho tìm kiếm (gõ xong 0.5s mới submit)
    let searchTimeout;
    const searchInput = document.getElementById('search-product');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            clearTimeout(searchTimeout);
            searchTimeout = setTimeout(() => {
                submitForm();
            }, 500);
        });
    }

</script>

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

    <!-- BỌC TRONG 1 FORM để submit lọc -->
    <form method="get" action="${pageContext.request.contextPath}/shop" id="filterForm">
        <input type="hidden" name="page" id="pageInput" value="1">

        <div class="products">

            <!-- ========== SIDEBAR LEFT ========== -->
            <div class="product">

                <div class="product__category product__categorys">
                    <h2>Danh Mục</h2>
                    <ul>
                        <c:forEach var="c" items="${categories}">
                            <li>
                                <input type="checkbox"
                                       class="checkbox-category"
                                       name="category"
                                       value="${c.id}"
                                       onclick="this.form.submit()"
                                    ${selectedCategoryList.contains(c.id) ? 'checked' : ''}>
                                <span>${c.categoryName}</span>
                            </li>
                        </c:forEach>
                    </ul>
                </div>

                <div class="product__category product__price">
                    <h2>Giá</h2>
                    <ul>
                        <li>
                            <input type="radio"
                                   class="checkbox-price"
                                   name="priceRange"
                                   value="duoi200"
                                   onclick="this.form.submit()"
                            ${selectedPriceRange == 'duoi200' ? 'checked' : ''}>
                            <span>Dưới 200.000 Đ</span>
                        </li>
                        <li>
                            <input type="radio"
                                   class="checkbox-price"
                                   name="priceRange"
                                   value="200-1tr"
                                   onclick="this.form.submit()"
                            ${selectedPriceRange == '200-1tr' ? 'checked' : ''}>
                            <span>200.000 Đ - 1.000.000 Đ</span>
                        </li>
                        <li>
                            <input type="radio"
                                   class="checkbox-price"
                                   name="priceRange"
                                   value="1tr-2tr"
                                   onclick="this.form.submit()"
                            ${selectedPriceRange == '1tr-2tr' ? 'checked' : ''}>
                            <span>1.000.000 Đ - 2.000.000 Đ</span>
                        </li>
                        <li>
                            <input type="radio"
                                   class="checkbox-price"
                                   name="priceRange"
                                   value="2tr-4tr"
                                   onclick="this.form.submit()"
                            ${selectedPriceRange == '2tr-4tr' ? 'checked' : ''}>
                            <span>2.000.000 Đ - 4.000.000 Đ</span>
                        </li>
                        <li>
                            <input type="radio"
                                   class="checkbox-price"
                                   name="priceRange"
                                   value="tren4tr"
                                   onclick="this.form.submit()"
                            ${selectedPriceRange == 'tren4tr' ? 'checked' : ''}>
                            <span>Trên 4.000.000 Đ</span>
                        </li>
                    </ul>
                </div>

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
                        <input type="text"
                               name="keyword"
                               id="search-product"
                               value="${searchKeyword}"
                               placeholder="Nhập tên sản phẩm">
                    </div>

                    <div class="list-product__head__arrange">
                        <span>Sắp xếp theo: </span>
                        <select name="sort" id="sort-select"  onchange="this.form.submit()">
                            <option value="default" ${selectedSort == 'default' ? 'selected' : ''}>Mặc định</option>
                            <option value="az" ${selectedSort == 'az' ? 'selected' : ''}>Sắp xếp theo A-Z</option>
                            <option value="za" ${selectedSort == 'za' ? 'selected' : ''}>Sắp xếp theo Z-A</option>
                            <option value="price-desc" ${selectedSort == 'price-desc' ? 'selected' : ''}>Giá giảm dần</option>
                            <option value="price-asc" ${selectedSort == 'price-asc' ? 'selected' : ''}>Giá tăng dần</option>
                        </select>
                    </div>
                </div>

                <div class="result-info">
                    <i class="fa-solid fa-list"></i> Hiển thị ${fn:length(products)} / ${totalProducts} sản phẩm
                </div>

                <!-- body -->
                <div class="list-product__body">
                    <div class="list-product__body__card">
                        <c:choose>
                            <c:when test="${empty products}">
                                <div class="no-products">
                                    <i class="fa-solid fa-box-open"></i>
                                    <p>Không tìm thấy sản phẩm nào phù hợp!</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="p" items="${products}">
                                    <div class="list-product__body__card__container"
                                         data-category="${p.categoriesID}"
                                         data-brand="${p.brandID}"
                                         data-price="${p.price}"
                                         data-name="${fn:toLowerCase(p.productName)}">

                                        <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}"
                                           class="product-link">

                                            <img src="${pageContext.request.contextPath}/${p.imageUrl}"
                                                 alt="${p.productName}"
                                                 style="width: 80%; height: 200px; object-fit: contain;">

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

                                            <button type="button" class="buyNow" onclick="buyNow(${p.id})">
                                                Mua ngay
                                            </button>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Phân trang -->
                <div class="pagination-container">
                    <div class="list-product__body__pagination">
                        <c:if test="${currentPage > 1}">
                            <i class="fa-solid fa-chevron-left" onclick="goToPage(${currentPage - 1})"></i>
                        </c:if>
                        <ul>
                            <c:forEach begin="1" end="${totalPages}" var="i">
                                <li onclick="goToPage(${i})" class="${i == currentPage ? 'active' : ''}">${i}</li>
                            </c:forEach>
                        </ul>
                        <c:if test="${currentPage < totalPages}">
                            <i class="fa-solid fa-chevron-right" onclick="goToPage(${currentPage + 1})"></i>
                        </c:if>
                    </div>
                </div>

            </div>
        </div>
    </form>

</main>


<!-- FOOTER -->
<jsp:include page="/WEB-INF/components/footer.jsp"/>

<script src="${pageContext.request.contextPath}/assets/js/pages/shop.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/pages/cart.js"></script>

</body>
</html>
