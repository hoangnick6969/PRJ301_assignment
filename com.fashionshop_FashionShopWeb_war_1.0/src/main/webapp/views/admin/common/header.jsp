<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <style>
        body { font-family: Arial; margin: 0; }
        .admin-header {
            background-color: #333;
            color: white;
            padding: 10px 20px;
        }
        .admin-nav {
            background-color: #444;
            overflow: hidden;
        }
        .admin-nav a {
            float: left;
            display: block;
            color: #fff;
            padding: 10px 15px;
            text-decoration: none;
        }
        .admin-nav a:hover {
            background-color: #666;
        }
        .admin-content {
            padding: 20px;
        }
    </style>
</head>
<body>

<div class="admin-header">
    <h2>🛠️ Trang Quản Trị - FashionShop</h2>
</div>

<div class="admin-nav">
    <a href="${pageContext.request.contextPath}/admin/dashboard">🏠 Dashboard</a>
    <a href="${pageContext.request.contextPath}/admin/products">📦 Sản phẩm</a>
    <a href="${pageContext.request.contextPath}/admin/orders">🧾 Đơn hàng</a>
    <a href="${pageContext.request.contextPath}/admin/customers">👥 Khách hàng</a>
    <a href="${pageContext.request.contextPath}/admin/reviews">⭐ Đánh giá</a>
    <a href="${pageContext.request.contextPath}/admin/messages">📨 Liên hệ</a>
    <a href="${pageContext.request.contextPath}/admin/categories">📂 Danh mục</a>
    <a href="${pageContext.request.contextPath}/admin/banners">🖼 Banner</a>
    <a href="${pageContext.request.contextPath}/admin/blogs">📝 Bài viết</a>
    <a href="${pageContext.request.contextPath}/admin/logout" style="float:right;">🚪 Đăng xuất</a>

</div>

<div class="admin-content">
