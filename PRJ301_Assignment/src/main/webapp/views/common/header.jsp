<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Header -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FashionShop - Thời trang hiện đại</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
<header>
    <div class="header-container">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/home">
                <i class="fas fa-tshirt"></i>
                <span class="gradient-text">FashionShop</span>
            </a>
        </div>

        <nav>
            <ul>
                <li><a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Trang chủ</a></li>
                <c:forEach var="cate" items="${categories}">
                    <li><a href="${pageContext.request.contextPath}/products?cid=${cate.id}">${cate.name}</a></li>
                </c:forEach>
                <li><a href="${pageContext.request.contextPath}/blog"><i class="fas fa-blog"></i> Blog</a></li>
                <li><a href="${pageContext.request.contextPath}/contact"><i class="fas fa-envelope"></i> Liên hệ</a></li>
            </ul>
        </nav>

        <div class="user-menu">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <span><i class="fas fa-user"></i> Xin chào, ${sessionScope.user.name}</span>
                    <a href="${pageContext.request.contextPath}/profile"><i class="fas fa-user-cog"></i> Tài khoản</a>
                    <a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/login"><i class="fas fa-sign-in-alt"></i> Đăng nhập</a>
                    <a href="${pageContext.request.contextPath}/register"><i class="fas fa-user-plus"></i> Đăng ký</a>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/cart"><i class="fas fa-shopping-cart"></i> Giỏ hàng</a>
            <a href="${pageContext.request.contextPath}/wishlist"><i class="fas fa-heart"></i> Yêu thích</a>
        </div>
    </div>
</header>
