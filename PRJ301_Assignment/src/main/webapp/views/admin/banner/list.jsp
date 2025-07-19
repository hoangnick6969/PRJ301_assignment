<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>🖼️ Danh sách banner</h2>

<a href="${pageContext.request.contextPath}/admin/banners?action=add">➕ Thêm banner mới</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Tiêu đề</th>
        <th>Hình ảnh</th>
        <th>Liên kết</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="b" items="${bannerList}">
        <tr>
            <td>${b.id}</td>
            <td>${b.title}</td>
            <td><img src="${pageContext.request.contextPath}/${b.image}" width="150"/></td>
            <td><a href="${b.link}" target="_blank">${b.link}</a></td>
            <td>
                <a href="banners?action=edit&id=${b.id}">✏️ Sửa</a> |
                <a href="banners?action=delete&id=${b.id}" onclick="return confirm('Xoá banner này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banner Management - Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        .banner-management {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        
        .header {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
        }
        
        .header h1 {
            margin: 0;
            font-size: 2.5rem;
            font-weight: 300;
            letter-spacing: 1px;
        }
        
        .header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 20"><defs><radialGradient id="a" cx="50%" cy="0%" r="100%"><stop offset="0%" stop-color="%23fff" stop-opacity=".1"/><stop offset="100%" stop-color="%23fff" stop-opacity="0"/></radialGradient></defs><rect width="100" height="20" fill="url(%23a)"/></svg>');
            opacity: 0.1;
        }
        
        .actions-bar {
            padding: 25px 30px;
            background: #f8f9fa;
            border-bottom: 1px solid #e9ecef;
            display: flex;
            justify-content: between;
            align-items: center;
            flex-wrap: wrap;
            gap: 15px;
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            font-size: 14px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #ffc107 0%, #ffb300 100%);
            color: #212529;
            box-shadow: 0 4px 15px rgba(255, 193, 7, 0.3);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #dc3545 0%, #c82333 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(220, 53, 69, 0.3);
        }
        
        .btn-warning:hover, .btn-danger:hover {
            transform: translateY(-2px);
            filter: brightness(1.1);
        }
        
        .search-box {
            flex: 1;
            max-width: 300px;
            position: relative;
        }
        
        .search-box input {
            width: 100%;
            padding: 12px 45px 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 25px;
            font-size: 14px;
            transition: all 0.3s ease;
        }
        
        .search-box input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .search-box i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .banner-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 25px;
            padding: 30px;
        }
        
        .banner-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.08);
            overflow: hidden;
            transition: all 0.3s ease;
            border: 1px solid #f0f0f0;
        }
        
        .banner-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.12);
        }
        
        .banner-image {
            height: 200px;
            background: linear-gradient(45deg, #f8f9fa, #e9ecef);
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }
        
        .banner-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }
        
        .banner-card:hover .banner-image img {
            transform: scale(1.05);
        }
        
        .placeholder-image {
            color: #6c757d;
            font-size: 3rem;
        }
        
        .banner-content {
            padding: 20px;
        }
        
        .banner-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #2c3e50;
            margin: 0 0 10px 0;
            line-height: 1.4;
        }
        
        .banner-meta {
            display: flex;
            flex-direction: column;
            gap: 8px;
            margin-bottom: 15px;
        }
        
        .meta-item {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        .position-badge {
            display: inline-block;
            padding: 4px 12px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border-radius: 15px;
            font-size: 0.8rem;
            font-weight: 500;
        }
        
        .banner-actions {
            display: flex;
            gap: 8px;
            justify-content: flex-end;
        }
        
        .btn-sm {
            padding: 8px 16px;
            font-size: 0.85rem;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 30px;
            color: #6c757d;
        }
        
        .empty-state i {
            font-size: 4rem;
            margin-bottom: 20px;
            opacity: 0.5;
        }
        
        .empty-state h3 {
            margin: 0 0 10px 0;
            color: #495057;
        }
        
        .stats-bar {
            background: #f8f9fa;
            padding: 15px 30px;
            border-top: 1px solid #e9ecef;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.9rem;
            color: #6c757d;
        }
        
        @media (max-width: 768px) {
            .banner-management {
                padding: 10px;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .search-box {
                max-width: none;
            }
            
            .banner-grid {
                grid-template-columns: 1fr;
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="banner-management">
        <div class="container">
            <div class="header">
                <h1><i class="fas fa-images"></i> Banner Management</h1>
            </div>
            
            <div class="actions-bar">
                <div class="search-box">
                    <input type="text" placeholder="Search banners..." id="searchInput">
                    <i class="fas fa-search"></i>
                </div>
                <a href="${pageContext.request.contextPath}/admin/banners?action=add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add New Banner
                </a>
            </div>
            
            <c:choose>
                <c:when test="${not empty banners}">
                    <div class="banner-grid" id="bannerGrid">
                        <c:forEach var="banner" items="${banners}">
                            <div class="banner-card" data-title="${banner.title}" data-position="${banner.position}">
                                <div class="banner-image">
                                    <c:choose>
                                        <c:when test="${not empty banner.image}">
                                            <img src="${pageContext.request.contextPath}/${banner.image}" 
                                                 alt="${banner.title}" 
                                                 onerror="this.style.display='none'; this.nextElementSibling.style.display='block';">
                                            <div class="placeholder-image" style="display: none;">
                                                <i class="fas fa-image"></i>
                                            </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="placeholder-image">
                                                <i class="fas fa-image"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="banner-content">
                                    <h3 class="banner-title">${banner.title}</h3>
                                    
                                    <div class="banner-meta">
                                        <div class="meta-item">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span class="position-badge">${banner.position}</span>
                                        </div>
                                        <c:if test="${not empty banner.link}">
                                            <div class="meta-item">
                                                <i class="fas fa-link"></i>
                                                <span>${banner.link}</span>
                                            </div>
                                        </c:if>
                                    </div>
                                    
                                    <div class="banner-actions">
                                        <a href="${pageContext.request.contextPath}/admin/banners?action=edit&id=${banner.id}" 
                                           class="btn btn-warning btn-sm">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                        <a href="${pageContext.request.contextPath}/admin/banners?action=delete&id=${banner.id}" 
                                           class="btn btn-danger btn-sm"
                                           onclick="return confirm('Are you sure you want to delete this banner?')">
                                            <i class="fas fa-trash"></i> Delete
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="fas fa-images"></i>
                        <h3>No banners found</h3>
                        <p>Start by creating your first banner to display on your website.</p>
                        <a href="${pageContext.request.contextPath}/admin/banners?action=add" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Create First Banner
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
            
            <c:if test="${not empty banners}">
                <div class="stats-bar">
                    <span>Total banners: <strong>${banners.size()}</strong></span>
                    <span>Last updated: <strong id="currentDate"></strong></span>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const bannerCards = document.querySelectorAll('.banner-card');
            
            bannerCards.forEach(card => {
                const title = card.dataset.title.toLowerCase();
                const position = card.dataset.position.toLowerCase();
                
                if (title.includes(searchTerm) || position.includes(searchTerm)) {
                    card.style.display = 'block';
                } else {
                    card.style.display = 'none';
                }
            });
        });
        
        // Set current date
        document.addEventListener('DOMContentLoaded', function() {
            const currentDateElement = document.getElementById('currentDate');
            if (currentDateElement) {
                const now = new Date();
                currentDateElement.textContent = now.toLocaleDateString();
            }
        });
        
        // Animate cards on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };
        
        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);
        
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.banner-card');
            cards.forEach((card, index) => {
                card.style.opacity = '0';
                card.style.transform = 'translateY(20px)';
                card.style.transition = `opacity 0.6s ease ${index * 0.1}s, transform 0.6s ease ${index * 0.1}s`;
                observer.observe(card);
            });
        });
    </script>
</body>
</html>
