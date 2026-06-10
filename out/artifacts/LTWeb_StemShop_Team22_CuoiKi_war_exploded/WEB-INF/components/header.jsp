<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--thêm taglib này để viết JSTL--%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!--HEADER-->
<header class="header">

    <style>
        .cart-icon {
            position: relative;
            font-size: 20px;
        }

        #cart-count {
            position: absolute;
            top: -6px;
            right: -10px;
            background: red;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 50%;
        }
        #wishlist-count {
            position: absolute;
            top: -6px;
            right: -10px;
            background: #ff4d6d;
            color: white;
            font-size: 12px;
            padding: 2px 6px;
            border-radius: 50%;
        }
    </style>

    <!-- PHẦN TRÊN -->
    <div class="header__first">
        <div class="container">
            <div class="header__top-left">
                <a href="https://maps.app.goo.gl/nj1KfxS8ajpDxTni6" target="_blank">
                    <span><i class="fa-solid fa-location-dot"></i> Trường Đại Học Nông Lâm TPHCM</span>
                </a>
                <a href=""><span><i class="fa-solid fa-envelope"></i> shopstemteam22@gmail.com</span></a>
            </div>
            <div class="header__top-right">
                <div class="header__phone-top">
                    <a href=""><span><i class="fa-solid fa-phone"></i> +84 123456789</span></a>
                </div>
                <div class="header_icon-top">
                    <a href="" class="header__icon-right"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="" class="header__icon-right"><i class="fa-brands fa-instagram"></i></a>
                    <a href="" class="header__icon-right"><i class="fa-brands fa-amazon"></i></a>
                    <a href="" class="header__icon-right"><i class="fa-brands fa-twitter"></i></a>
                </div>
            </div>
        </div>
    </div>

    <!-- PHẦN DƯỚI: NAV -->
    <div class="header__end">
        <div class="container">
            <div class="header__end-left">

                <!-- LOGO -->
                <div class="header__logo">
                    <a href="${pageContext.request.contextPath}/">
                        <img src="${pageContext.request.contextPath}/assets/images/logo.png" alt="logo">
                    </a>
                </div>

                <!-- NAV -->
                <div class="header__nav">
                    <nav class="nav-content">
                        <ul class="nav__list">

                            <li class="nav__item">
                                <a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-house"></i> Trang chủ</a>
                            </li>

                            <!-- Giới thiệu -->
                            <li class="nav__item dropdown">
                                <a href="${pageContext.request.contextPath}/view/main/about.jsp">
                                    Giới thiệu <i class="fa-solid fa-angle-up"></i>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="${pageContext.request.contextPath}/view/about_info/about-stem.jsp">Về STEMSHOP</a></li>
                                    <li><a href="${pageContext.request.contextPath}/view/about_info//mission.jsp">Sứ mệnh & Tầm nhìn</a></li>
                                    <li><a href="${pageContext.request.contextPath}/view/about_info/guide.jsp">Tài liệu hướng dẫn</a></li>
                                </ul>
                            </li>

                            <!-- SHOP -->
                            <li class="nav__item dropdown">
                                <a href="${pageContext.request.contextPath}/shop">
                                    Cửa hàng <i class="fa-solid fa-angle-up"></i>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a href="${pageContext.request.contextPath}/view/shop/cart.jsp"><i class="fa-solid fa-cart-arrow-down"></i> Giỏ hàng</a></li>
                                    <li><a href="${pageContext.request.contextPath}/wishlist"><i class="fa-solid fa-heart"></i> Yêu thích</a></li>
                                    <li><a href="${pageContext.request.contextPath}/view/shop/checkout.jsp"><i class="fa-regular fa-credit-card"></i> Thanh toán</a></li>
                                    <li>
                                        <a href="${pageContext.request.contextPath}/my-orders">
                                            <i class="fa-solid fa-box"></i>  Đơn hàng
                                        </a>
                                    </li>
                                </ul>
                            </li>

                            <li class="nav__item">
                                <a href="${pageContext.request.contextPath}/view/main/contact.jsp"><i class="fa-solid fa-envelope"></i> Liên hệ</a>
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>

            <!-- USER + CART -->
            <div class="header__end-right">
                <div class="header__shop">
                    <a href="${pageContext.request.contextPath}/wishlist" class="cart-icon">
                        <i class="fa-solid fa-heart"></i>
                        <span id="wishlist-count">0</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/view/shop/cart.jsp" class="cart-icon">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span id="cart-count">
                            ${sessionScope.cart != null ? sessionScope.cart.totalQuantity : 0}
                        </span>
                    </a>
                </div>

                <div class="header__user">
                    <c:choose>
                        <%-- CHƯA LOGIN --%>
                        <c:when test="${empty sessionScope.user}">
                            <a href="${pageContext.request.contextPath}/view/user/sign-in.jsp">Đăng nhập</a>
                            <a href="${pageContext.request.contextPath}/view/user/sign-up.jsp">Đăng ký</a>
                        </c:when>
                        <%-- ĐÃ LOGIN --%>
                        <c:otherwise>
                            <div class="header__user header__user-logged">

                                    <%-- AVATAR ICON --%>
                                <i class="fa-solid fa-circle-user user-avatar-icon"></i>

                                    <%-- TÊN --%>
                                <span class="user-short-name">${sessionScope.user.fullName}</span>

                                    <%-- DROPDOWN --%>
                                <div class="user-dropdown">
                                    <ul class="dropdown-menu-user">

                                        <li>
                                            <c:choose>
                                                <c:when test="${sessionScope.user.role == 'admin'}">
                                                    <a href="${pageContext.request.contextPath}/admin/dashboard">
                                                        <i class="fa-solid fa-gauge"></i> Dashboard
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/profile">
                                                        <i class="fa-solid fa-user"></i> Hồ sơ
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </li>

                                        <li>
                                            <a href="${pageContext.request.contextPath}/my-orders">
                                                <i class="fa-solid fa-box"></i> Đơn hàng
                                            </a>
                                        </li>


                                        <c:if test="${sessionScope.user.role == 'ADMIN'}">
                                            <li>
                                                <a href="${pageContext.request.contextPath}/admin/dashboard">
                                                    <i class="fa-solid fa-gear"></i> Quản lý
                                                </a>
                                            </li>
                                        </c:if>

                                        <li class="logout">
                                            <a href="${pageContext.request.contextPath}/logout">
                                                <i class="fa-solid fa-right-from-bracket"></i> Đăng xuất
                                            </a>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                        </c:otherwise>

                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <script>
        const contextPath = '${pageContext.request.contextPath}';
    </script>
    <script src="${pageContext.request.contextPath}/assets/js/pages/cart.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/pages/wishlist.js"></script>
</header>
