<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>The HSQ</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/img/logo.png" />
</head>
<body>
<!-- TOP BLACK BAR -->
<div class="topbar">
   <div class="topbar-left">
    <span class="brand-text">FashionShop</span>
</div>


    <div class="topbar-right user-menu">
        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <span>Xin chào, ${sessionScope.user.name}</span> |
                <a href="${pageContext.request.contextPath}/profile">Tài khoản</a> |
                <a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/login">Đăng nhập</a> |
                <a href="${pageContext.request.contextPath}/register">Đăng ký</a>
            </c:otherwise>
        </c:choose>
        | <a href="${pageContext.request.contextPath}/cart"><i class="fa fa-shopping-cart"></i> Giỏ hàng</a>
        | <a href="${pageContext.request.contextPath}/wishlist"><i class="fa fa-heart"></i> Yêu thích</a>
    </div>
</div>

<!-- HEADER MENU -->
<header class="main-header">
    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <c:forEach var="cate" items="${categories}">
                <li><a href="${pageContext.request.contextPath}/products?cid=${cate.id}">${cate.name}</a></li>
            </c:forEach>
        </ul>
    </nav>
    <div class="logo-center">
    <img src="${pageContext.request.contextPath}/img/logo.png" alt="FashionShop Logo" class="main-logo-img">
</div>

    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
        </ul>
    </nav>
</header>

<!-- HERO SECTION -->
<!--<section class="hero">
    <img src="${pageContext.request.contextPath}/images/hero-fashion.jpg" class="hero-bg" alt="Fashion Banner"/>
    <div class="hero-content">
        <h1>Ready to<br>Inspire Your Style</h1>
        <a href="${pageContext.request.contextPath}/products" class="btn-orange">Xem sản phẩm mới</a>
    </div>
</section>-->
</body>
</html>