<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>FashionShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background-color: #f8f8f8;
        }
        .logo a {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: #000;
        }
        nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            gap: 15px;
        }
        nav ul li a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
        }
        .user-menu {
            font-size: 14px;
        }
        .search-box {
            text-align: center;
            margin: 10px auto;
        }
        .search-box input[type="text"] {
            padding: 6px;
            width: 250px;
            border: 1px solid #ccc;
        }
        .search-box button {
            padding: 6px 10px;
            background-color: #333;
            color: white;
            border: none;
            cursor: pointer;
        }
        .search-box button:hover {
            background-color: #555;
        }
    </style>
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
        | <a href="${pageContext.request.contextPath}/order-history">🧾 Đơn hàng</a>
        | <a href="${pageContext.request.contextPath}/wishlist">❤ Yêu thích</a>
    </div>
</header>

    <!-- Thanh tìm kiếm -->
    <div class="search-box">
        <form action="${pageContext.request.contextPath}/search" method="get">
            <input type="text" name="q" placeholder="Tìm sản phẩm thông minh..." required
                   style="padding: 5px; width: 250px;" />
            <button type="submit" style="padding: 5px;">🔍 Tìm</button>
        </form>
    </div>


<hr/>
    