
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - FashionShop</title>
    <link href="<c:url value='/css/style.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .admin-layout {
            min-height: 100vh;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .admin-header {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .admin-logo {
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.5rem;
            font-weight: 700;
            color: #2c3e50;
            text-decoration: none;
        }
        
        .admin-logo i {
            color: #3498db;
            font-size: 2rem;
        }
        
        .admin-user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(45deg, #3498db, #2ecc71);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        
        .user-details {
            display: flex;
            flex-direction: column;
        }
        
        .user-name {
            font-weight: 600;
            color: #2c3e50;
            font-size: 0.9rem;
        }
        
        .user-role {
            font-size: 0.8rem;
            color: #7f8c8d;
        }
        
        .admin-nav {
            background: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 0 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }
        
        .nav-content {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        
        .nav-links {
            display: flex;
            align-items: center;
            gap: 0;
        }
        
        .nav-links a {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 1rem 1.5rem;
            color: #34495e;
            text-decoration: none;
            font-weight: 500;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            border-bottom: 3px solid transparent;
            position: relative;
        }
        
        .nav-links a:hover {
            background: rgba(52, 152, 219, 0.1);
            color: #3498db;
            border-bottom-color: #3498db;
        }
        
        .nav-links a.active {
            background: rgba(52, 152, 219, 0.15);
            color: #3498db;
            border-bottom-color: #3498db;
        }
        
        .nav-links a i {
            font-size: 1rem;
        }
        
        .nav-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .logout-btn {
            display: flex;
            align-items: center;
            gap: 8px;
            padding: 0.6rem 1.2rem;
            background: linear-gradient(45deg, #e74c3c, #c0392b);
            color: white;
            text-decoration: none;
            border-radius: 25px;
            font-weight: 500;
            font-size: 0.85rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(231, 76, 60, 0.3);
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 20px rgba(231, 76, 60, 0.4);
            background: linear-gradient(45deg, #c0392b, #a93226);
        }
        
        .admin-content {
            padding: 2rem;
            min-height: calc(100vh - 140px);
        }
        
        @media (max-width: 768px) {
            .admin-header, .admin-nav {
                padding: 1rem;
            }
            
            .nav-links {
                flex-wrap: wrap;
                gap: 0.5rem;
            }
            
            .nav-links a {
                padding: 0.8rem 1rem;
                font-size: 0.8rem;
            }
            
            .admin-logo {
                font-size: 1.2rem;
            }
            
            .user-details {
                display: none;
            }
        }
    </style>
</head>
<body>
    <div class="admin-layout">
        <header class="admin-header">
            <div class="header-content">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="admin-logo">
                    <i class="fas fa-tools"></i>
                    <span>Admin Panel - FashionShop</span>
                </a>
                
                <div class="admin-user-info">
                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>
                    <div class="user-details">
                        <div class="user-name">Administrator</div>
                        <div class="user-role">System Admin</div>
                    </div>
                </div>
            </div>
        </header>

        <nav class="admin-nav">
            <div class="nav-content">
                <div class="nav-links">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-tachometer-alt"></i>
                        <span>Dashboard</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/products">
                        <i class="fas fa-box"></i>
                        <span>Sản phẩm</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/categories">
                        <i class="fas fa-tags"></i>
                        <span>Danh mục</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/orders">
                        <i class="fas fa-shopping-cart"></i>
                        <span>Đơn hàng</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/customers">
                        <i class="fas fa-users"></i>
                        <span>Khách hàng</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/reviews">
                        <i class="fas fa-star"></i>
                        <span>Đánh giá</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/blogs">
                        <i class="fas fa-blog"></i>
                        <span>Blog</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/banners">
                        <i class="fas fa-image"></i>
                        <span>Banner</span>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/contacts">
                        <i class="fas fa-envelope"></i>
                        <span>Liên hệ</span>
                    </a>
                </div>
                
                <div class="nav-actions">
                    <a href="${pageContext.request.contextPath}/admin/logout" class="logout-btn">
                        <i class="fas fa-sign-out-alt"></i>
                        <span>Đăng xuất</span>
                    </a>
                </div>
            </div>
        </nav>

        <main class="admin-content">
