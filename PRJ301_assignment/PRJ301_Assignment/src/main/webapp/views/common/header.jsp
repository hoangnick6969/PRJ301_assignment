<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Header -->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FashionShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/home">👗 FashionShop</a>
    </div>

    <nav>
        <ul>
            <li><a href="${pageContext.request.contextPath}/home">Trang chủ</a></li>
            <c:forEach var="cate" items="${categories}">
                <li><a href="${pageContext.request.contextPath}/products?cid=${cate.id}">${cate.name}</a></li>
            </c:forEach>
            <li><a href="${pageContext.request.contextPath}/blog">Blog</a></li>
            <li><a href="${pageContext.request.contextPath}/contact">Liên hệ</a></li>
        </ul>
    </nav>

    <div class="user-menu">
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
        | <a href="${pageContext.request.contextPath}/cart">🛒 Giỏ hàng</a>
        | <a href="${pageContext.request.contextPath}/wishlist">❤ Yêu thích</a>
    </div>
</header>
<hr/>
