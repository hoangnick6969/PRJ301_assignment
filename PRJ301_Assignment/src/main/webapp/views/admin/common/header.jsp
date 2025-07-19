
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Fashion Shop</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
        }

        .admin-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem 2rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .admin-header .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
        }

        .admin-header h1 {
            font-size: 1.8rem;
            font-weight: 300;
        }

        .admin-header .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .admin-nav {
            background: white;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            position: sticky;
            top: 70px;
            z-index: 999;
        }

        .admin-nav .nav-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 0 2rem;
        }

        .admin-nav ul {
            list-style: none;
            display: flex;
            overflow-x: auto;
        }

        .admin-nav li {
            white-space: nowrap;
        }

        .admin-nav a {
            display: block;
            padding: 1rem 1.5rem;
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: all 0.3s ease;
            border-bottom: 3px solid transparent;
        }

        .admin-nav a:hover, .admin-nav a.active {
            color: #667eea;
            border-bottom-color: #667eea;
            background-color: #f8f9ff;
        }

        .admin-container {
            max-width: 1400px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .breadcrumb {
            margin-bottom: 2rem;
            padding: 0.5rem 0;
            color: #666;
        }

        .breadcrumb a {
            color: #667eea;
            text-decoration: none;
        }

        .breadcrumb a:hover {
            text-decoration: underline;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #667eea;
            color: white;
        }

        .btn-primary:hover {
            background: #5a6fd8;
            transform: translateY(-1px);
        }

        .btn-danger {
            background: #e74c3c;
            color: white;
        }

        .btn-danger:hover {
            background: #c0392b;
        }

        .btn-success {
            background: #2ecc71;
            color: white;
        }

        .btn-success:hover {
            background: #27ae60;
        }

        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            margin-bottom: 2rem;
            overflow: hidden;
        }

        .card-header {
            padding: 1.5rem 2rem;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-body {
            padding: 2rem;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        .table th, .table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e9ecef;
        }

        .table th {
            background: #f8f9fa;
            font-weight: 600;
            color: #333;
        }

        .table tbody tr:hover {
            background-color: #f8f9ff;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #333;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .alert {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: 5px;
            border-left: 4px solid;
        }

        .alert-success {
            background-color: #d4edda;
            border-color: #28a745;
            color: #155724;
        }

        .alert-danger {
            background-color: #f8d7da;
            border-color: #dc3545;
            color: #721c24;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        .stat-card .icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: #667eea;
        }

        .stat-card .number {
            font-size: 2.5rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 0.5rem;
        }

        .stat-card .label {
            font-size: 1.1rem;
            color: #666;
        }

        @media (max-width: 768px) {
            .admin-header .header-content {
                flex-direction: column;
                gap: 1rem;
            }

            .admin-container {
                padding: 0 1rem;
            }

            .card-body {
                padding: 1rem;
            }

            .table {
                font-size: 0.9rem;
            }
        }
    </style>
</head>
<body>
    <header class="admin-header">
        <div class="header-content">
            <h1><i class="fas fa-tachometer-alt"></i> Fashion Shop Admin</h1>
            <div class="user-info">
                <span>Xin chào, ${sessionScope.admin.displayName != null ? sessionScope.admin.displayName : 'Admin'}</span>
                <a href="${pageContext.request.contextPath}/admin/logout" class="btn btn-danger">
                    <i class="fas fa-sign-out-alt"></i> Đăng xuất
                </a>
            </div>
        </div>
    </header>

    <nav class="admin-nav">
        <div class="nav-content">
            <ul>
                <li><a href="${pageContext.request.contextPath}/admin/dashboard"
                      class="${pageContext.request.requestURI.contains('dashboard') ? 'active' : ''}">
                    <i class="fas fa-home"></i> Dashboard
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/products"
                      class="${pageContext.request.requestURI.contains('products') ? 'active' : ''}">
                    <i class="fas fa-box"></i> Sản phẩm
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/categories"
                      class="${pageContext.request.requestURI.contains('categories') ? 'active' : ''}">
                    <i class="fas fa-tags"></i> Danh mục
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/orders"
                      class="${pageContext.request.requestURI.contains('orders') ? 'active' : ''}">
                    <i class="fas fa-shopping-cart"></i> Đơn hàng
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/customers"
                      class="${pageContext.request.requestURI.contains('customers') ? 'active' : ''}">
                    <i class="fas fa-users"></i> Khách hàng
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/banners"
                      class="${pageContext.request.requestURI.contains('banners') ? 'active' : ''}">
                    <i class="fas fa-image"></i> Banner
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/blogs"
                      class="${pageContext.request.requestURI.contains('blogs') ? 'active' : ''}">
                    <i class="fas fa-blog"></i> Blog
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/reviews"
                      class="${pageContext.request.requestURI.contains('reviews') ? 'active' : ''}">
                    <i class="fas fa-star"></i> Đánh giá
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/messages"
                      class="${pageContext.request.requestURI.contains('messages') ? 'active' : ''}">
                    <i class="fas fa-envelope"></i> Tin nhắn
                </a></li>
                <li><a href="${pageContext.request.contextPath}/admin/coupons"
                      class="${pageContext.request.requestURI.contains('coupons') ? 'active' : ''}">
                    <i class="fas fa-ticket-alt"></i> Mã giảm giá
                </a></li>
            </ul>
        </div>
    </nav>

    <div class="admin-container">
