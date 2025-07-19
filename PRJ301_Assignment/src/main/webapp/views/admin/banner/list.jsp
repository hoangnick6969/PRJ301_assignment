<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<style>
    .banner-management {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border-radius: 20px;
        padding: 30px;
        margin-bottom: 30px;
        color: white;
        box-shadow: 0 15px 35px rgba(0,0,0,0.1);
    }
    
    .banner-title {
        font-size: 2.5rem;
        font-weight: 700;
        margin: 0 0 10px 0;
        display: flex;
        align-items: center;
        gap: 15px;
    }
    
    .banner-subtitle {
        font-size: 1.1rem;
        opacity: 0.9;
        margin: 0;
    }
    
    .action-bar {
        background: white;
        padding: 25px;
        border-radius: 15px;
        margin-bottom: 30px;
        box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-wrap: wrap;
        gap: 15px;
    }
    
    .add-btn {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        padding: 12px 24px;
        border-radius: 50px;
        text-decoration: none;
        font-weight: 600;
        display: inline-flex;
        align-items: center;
        gap: 8px;
        transition: all 0.3s ease;
        border: none;
        font-size: 1rem;
    }
    
    .add-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        color: white;
        text-decoration: none;
    }
    
    .banner-stats {
        display: flex;
        gap: 20px;
        align-items: center;
    }
    
    .stat-item {
        background: #f8f9ff;
        padding: 15px 20px;
        border-radius: 12px;
        text-align: center;
        border-left: 4px solid #667eea;
    }
    
    .stat-number {
        font-size: 1.8rem;
        font-weight: 700;
        color: #333;
        margin: 0;
    }
    
    .stat-label {
        font-size: 0.9rem;
        color: #666;
        margin: 5px 0 0 0;
    }
    
    .banner-grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
        gap: 25px;
        margin-top: 20px;
    }
    
    .banner-card {
        background: white;
        border-radius: 20px;
        overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        transition: all 0.3s ease;
        border: 1px solid #f0f0f0;
    }
    
    .banner-card:hover {
        transform: translateY(-5px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.15);
    }
    
    .banner-image {
        width: 100%;
        height: 200px;
        object-fit: cover;
        border-bottom: 1px solid #f0f0f0;
    }
    
    .banner-content {
        padding: 25px;
    }
    
    .banner-id {
        background: linear-gradient(135deg, #667eea, #764ba2);
        color: white;
        padding: 4px 12px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 600;
        display: inline-block;
        margin-bottom: 15px;
    }
    
    .banner-title-text {
        font-size: 1.3rem;
        font-weight: 600;
        color: #333;
        margin: 0 0 15px 0;
        line-height: 1.4;
    }
    
    .banner-link {
        color: #667eea;
        text-decoration: none;
        font-size: 0.9rem;
        display: block;
        margin-bottom: 20px;
        background: #f8f9ff;
        padding: 10px 15px;
        border-radius: 8px;
        border-left: 3px solid #667eea;
        word-break: break-all;
        transition: all 0.3s ease;
    }
    
    .banner-link:hover {
        background: #e8ecff;
        text-decoration: none;
        color: #5a67d8;
    }
    
    .banner-actions {
        display: flex;
        gap: 10px;
        justify-content: center;
        padding-top: 20px;
        border-top: 1px solid #f0f0f0;
        margin-top: 20px;
    }
    
    .action-btn {
        padding: 10px 18px;
        border-radius: 25px;
        text-decoration: none;
        font-weight: 600;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
        font-size: 0.9rem;
        border: none;
        cursor: pointer;
    }
    
    .edit-btn {
        background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
        color: white;
    }
    
    .edit-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(79, 172, 254, 0.4);
        color: white;
        text-decoration: none;
    }
    
    .delete-btn {
        background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
        color: white;
    }
    
    .delete-btn:hover {
        transform: translateY(-2px);
        box-shadow: 0 6px 20px rgba(255, 107, 107, 0.4);
        color: white;
        text-decoration: none;
    }
    
    .empty-state {
        text-align: center;
        padding: 60px 20px;
        background: white;
        border-radius: 20px;
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    }
    
    .empty-icon {
        font-size: 4rem;
        color: #ddd;
        margin-bottom: 20px;
    }
    
    .empty-title {
        font-size: 1.5rem;
        color: #666;
        margin-bottom: 10px;
    }
    
    .empty-text {
        color: #999;
        margin-bottom: 30px;
    }
    
    @media (max-width: 768px) {
        .banner-grid {
            grid-template-columns: 1fr;
        }
        
        .action-bar {
            flex-direction: column;
            align-items: stretch;
        }
        
        .banner-stats {
            justify-content: center;
            flex-wrap: wrap;
        }
        
        .banner-title {
            font-size: 2rem;
        }
        
        .banner-management {
            padding: 20px;
        }
    }
</style>

<div class="banner-management">
    <h1 class="banner-title">
        <span>🖼️</span>
        Quản lý Banner
    </h1>
    <p class="banner-subtitle">Quản lý và tùy chỉnh các banner hiển thị trên trang web</p>
</div>

<div class="action-bar">
    <div class="banner-stats">
        <div class="stat-item">
            <div class="stat-number">${bannerList.size()}</div>
            <div class="stat-label">Tổng Banner</div>
        </div>
        <div class="stat-item">
            <div class="stat-number">
                <c:set var="activeCount" value="0" />
                <c:forEach var="b" items="${bannerList}">
                    <c:if test="${not empty b.link}">
                        <c:set var="activeCount" value="${activeCount + 1}" />
                    </c:if>
                </c:forEach>
                ${activeCount}
            </div>
            <div class="stat-label">Có Liên Kết</div>
        </div>
    </div>
    
    <a href="${pageContext.request.contextPath}/admin/banners?action=add" class="add-btn">
        <span>➕</span>
        Thêm Banner Mới
    </a>
</div>

<c:choose>
    <c:when test="${empty bannerList}">
        <div class="empty-state">
            <div class="empty-icon">🖼️</div>
            <h3 class="empty-title">Chưa có banner nào</h3>
            <p class="empty-text">Hãy thêm banner đầu tiên để bắt đầu quản lý</p>
            <a href="${pageContext.request.contextPath}/admin/banners?action=add" class="add-btn">
                <span>➕</span>
                Tạo Banner Đầu Tiên
            </a>
        </div>
    </c:when>
    <c:otherwise>
        <div class="banner-grid">
            <c:forEach var="b" items="${bannerList}">
                <div class="banner-card">
                    <img src="${pageContext.request.contextPath}/${b.image}" class="banner-image" alt="${b.title}" 
                         onerror="this.src='${pageContext.request.contextPath}/img/placeholder-banner.jpg'"/>
                    
                    <div class="banner-content">
                        <span class="banner-id">ID: ${b.id}</span>
                        
                        <h3 class="banner-title-text">${b.title}</h3>
                        
                        <c:if test="${not empty b.link}">
                            <a href="${b.link}" target="_blank" class="banner-link" title="Mở liên kết trong tab mới">
                                🔗 ${b.link}
                            </a>
                        </c:if>
                        <c:if test="${empty b.link}">
                            <div class="banner-link" style="color: #999; border-left-color: #ddd; background: #f9f9f9;">
                                🔗 Không có liên kết
                            </div>
                        </c:if>
                        
                        <div class="banner-actions">
                            <a href="banners?action=edit&id=${b.id}" class="action-btn edit-btn" title="Chỉnh sửa banner">
                                <span>✏️</span>
                                Sửa
                            </a>
                            <a href="banners?action=delete&id=${b.id}" 
                               class="action-btn delete-btn" 
                               onclick="return confirm('⚠️ Bạn có chắc chắn muốn xóa banner \"${b.title}\"?\n\nHành động này không thể hoàn tác!')"
                               title="Xóa banner">
                                <span>🗑️</span>
                                Xóa
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="/views/admin/common/footer.jsp" />
