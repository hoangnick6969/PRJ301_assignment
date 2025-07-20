<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>🏷️ Danh sách mã giảm giá</h2>

<a href="${pageContext.request.contextPath}/admin/coupons?action=add">➕ Thêm mã giảm giá</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Mã</th>
        <th>Giảm (%)</th>
        <th>Ngày hết hạn</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="c" items="${couponList}">
        <tr>
            <td>${c.id}</td>
            <td>${c.code}</td>
            <td>${c.discount}</td>
            <td>${c.expiryDate}</td>
            <td>
                <a href="coupons?action=edit&id=${c.id}">✏️ Sửa</a> |
                <a href="coupons?action=delete&id=${c.id}" onclick="return confirm('Xoá mã này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý mã giảm giá - Fashion Shop Admin</title>
    <link href="<c:url value='/css/style.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="admin-layout">
        <!-- Include header -->
        <jsp:include page="../common/header.jsp"/>
        
        <div class="admin-content">
            <div class="content-header">
                <div class="header-top">
                    <h1>
                        <i class="fas fa-ticket-alt"></i>
                        🎫 Quản lý mã giảm giá
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <span>Mã giảm giá</span>
                    </div>
                </div>
                
                <div class="header-actions">
                    <div class="search-box">
                        <input type="text" id="searchInput" placeholder="Tìm kiếm mã giảm giá..." class="search-input">
                        <i class="fas fa-search search-icon"></i>
                    </div>
                    <div class="filter-dropdown">
                        <select id="statusFilter" class="filter-select">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active">Còn hiệu lực</option>
                            <option value="expired">Hết hạn</option>
                            <option value="high-discount">Giảm giá cao</option>
                        </select>
                    </div>
                    <a href="<c:url value='/admin/coupons?action=add'/>" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm mã giảm giá
                    </a>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(45deg, #667eea, #764ba2);">
                        <i class="fas fa-ticket-alt"></i>
                    </div>
                    <div class="stat-content">
                        <h3>${coupons.size()}</h3>
                        <p>Tổng mã giảm giá</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(45deg, #f093fb, #f5576c);">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-content">
                        <h3 id="activeCount">0</h3>
                        <p>Còn hiệu lực</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(45deg, #4facfe, #00f2fe);">
                        <i class="fas fa-percentage"></i>
                    </div>
                    <div class="stat-content">
                        <h3 id="avgDiscount">0%</h3>
                        <p>Giảm giá trung bình</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(45deg, #fa709a, #fee140);">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="stat-content">
                        <h3 id="expiredCount">0</h3>
                        <p>Đã hết hạn</p>
                    </div>
                </div>
            </div>

            <!-- Coupons Table -->
            <div class="table-section">
                <div class="table-card">
                    <div class="table-header">
                        <h3>
                            <i class="fas fa-list"></i>
                            Danh sách mã giảm giá
                        </h3>
                        <div class="table-actions">
                            <button class="btn btn-outline" onclick="exportCoupons()">
                                <i class="fas fa-download"></i>
                                Xuất Excel
                            </button>
                            <button class="btn btn-success" onclick="cleanupExpired()">
                                <i class="fas fa-broom"></i>
                                Dọn dẹp hết hạn
                            </button>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th width="60">ID</th>
                                    <th width="150">Mã giảm giá</th>
                                    <th width="120">Giảm giá</th>
                                    <th width="150">Ngày hết hạn</th>
                                    <th width="120">Trạng thái</th>
                                    <th width="150">Thời gian tạo</th>
                                    <th width="180">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="coupon" items="${coupons}">
                                    <jsp:useBean id="now" class="java.util.Date"/>
                                    <c:set var="isExpired" value="${coupon.expiryDate.before(now)}"/>
                                    
                                    <tr class="coupon-row ${isExpired ? 'expired' : 'active'}" data-id="${coupon.id}">
                                        <td>
                                            <span class="coupon-id">#${coupon.id}</span>
                                        </td>
                                        <td>
                                            <div class="coupon-info">
                                                <div class="coupon-code-display">
                                                    <i class="fas fa-ticket-alt"></i>
                                                    <strong>${coupon.code}</strong>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="discount-display">
                                                <span class="discount-badge ${coupon.discountPercent >= 50 ? 'high-discount' : coupon.discountPercent >= 25 ? 'medium-discount' : 'low-discount'}">
                                                    <i class="fas fa-percentage"></i>
                                                    ${coupon.discountPercent}%
                                                </span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="expiry-info">
                                                <i class="fas fa-calendar-alt"></i>
                                                <fmt:formatDate value="${coupon.expiryDate}" pattern="dd/MM/yyyy"/>
                                                <c:if test="${!isExpired}">
                                                    <div class="days-left">
                                                        <small>
                                                            <c:set var="daysLeft" value="${(coupon.expiryDate.time - now.time) / (1000 * 60 * 60 * 24)}"/>
                                                            <fmt:formatNumber value="${daysLeft}" maxFractionDigits="0" var="daysLeftFormatted"/>
                                                            Còn ${daysLeftFormatted} ngày
                                                        </small>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${isExpired}">
                                                    <span class="status-badge expired">
                                                        <i class="fas fa-times-circle"></i>
                                                        Hết hạn
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge active">
                                                        <i class="fas fa-check-circle"></i>
                                                        Có hiệu lực
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="created-info">
                                                <i class="fas fa-clock"></i>
                                                <fmt:formatDate value="${coupon.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn-icon btn-info" 
                                                        onclick="copyCouponCode('${coupon.code}')" 
                                                        title="Sao chép mã">
                                                    <i class="fas fa-copy"></i>
                                                </button>
                                                <a href="<c:url value='/admin/coupons?action=edit&id=${coupon.id}'/>" 
                                                   class="btn-icon btn-primary" 
                                                   title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button class="btn-icon btn-success" 
                                                        onclick="duplicateCoupon('${coupon.id}')" 
                                                        title="Nhân bản">
                                                    <i class="fas fa-clone"></i>
                                                </button>
                                                <button class="btn-icon btn-danger" 
                                                        onclick="deleteCoupon('${coupon.id}', '${coupon.code}')" 
                                                        title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty coupons}">
                                    <tr>
                                        <td colspan="7" class="empty-state">
                                            <div class="empty-content">
                                                <i class="fas fa-ticket-alt"></i>
                                                <h3>Chưa có mã giảm giá nào</h3>
                                                <p>Bắt đầu tạo mã giảm giá đầu tiên cho cửa hàng của bạn.</p>
                                                <a href="<c:url value='/admin/coupons?action=add'/>" class="btn btn-primary">
                                                    <i class="fas fa-plus"></i>
                                                    Thêm mã giảm giá
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('.coupon-row');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        // Status filter
        document.getElementById('statusFilter').addEventListener('change', function() {
            const filterValue = this.value;
            const rows = document.querySelectorAll('.coupon-row');
            
            rows.forEach(row => {
                if (!filterValue) {
                    row.style.display = '';
                } else if (filterValue === 'active' && row.classList.contains('active')) {
                    row.style.display = '';
                } else if (filterValue === 'expired' && row.classList.contains('expired')) {
                    row.style.display = '';
                } else if (filterValue === 'high-discount') {
                    const discountText = row.querySelector('.discount-badge').textContent;
                    const discount = parseInt(discountText.match(/\d+/)[0]);
                    row.style.display = discount >= 50 ? '' : 'none';
                } else {
                    row.style.display = 'none';
                }
            });
        });

        // Copy coupon code
        function copyCouponCode(code) {
            navigator.clipboard.writeText(code).then(function() {
                // Show success message
                const toast = document.createElement('div');
                toast.className = 'copy-toast';
                toast.textContent = `Đã sao chép mã: ${code}`;
                document.body.appendChild(toast);
                
                setTimeout(() => {
                    toast.remove();
                }, 3000);
            });
        }

        // Delete coupon
        function deleteCoupon(couponId, couponCode) {
            if (confirm(`Bạn có chắc chắn muốn xóa mã giảm giá "${couponCode}"?`)) {
                window.location.href = `<c:url value='/admin/coupons?action=delete&id='/>${couponId}`;
            }
        }

        // Duplicate coupon
        function duplicateCoupon(couponId) {
            if (confirm('Tạo bản sao của mã giảm giá này?')) {
                window.location.href = `<c:url value='/admin/coupons?action=duplicate&id='/>${couponId}`;
            }
        }

        // Export coupons
        function exportCoupons() {
            window.location.href = '<c:url value="/admin/coupons?action=export"/>';
        }

        // Cleanup expired coupons
        function cleanupExpired() {
            if (confirm('Xóa tất cả mã giảm giá đã hết hạn?')) {
                window.location.href = '<c:url value="/admin/coupons?action=cleanup"/>';
            }
        }

        // Calculate and display stats
        document.addEventListener('DOMContentLoaded', function() {
            const rows = document.querySelectorAll('.coupon-row');
            let activeCount = 0;
            let expiredCount = 0;
            let totalDiscount = 0;

            rows.forEach(row => {
                if (row.classList.contains('active')) {
                    activeCount++;
                } else {
                    expiredCount++;
                }

                const discountText = row.querySelector('.discount-badge').textContent;
                const discount = parseInt(discountText.match(/\d+/)[0]);
                totalDiscount += discount;
            });

            document.getElementById('activeCount').textContent = activeCount;
            document.getElementById('expiredCount').textContent = expiredCount;
            document.getElementById('avgDiscount').textContent = 
                rows.length > 0 ? Math.round(totalDiscount / rows.length) + '%' : '0%';
        });
    </script>

    <style>
        .coupon-code-display {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-family: 'Courier New', monospace;
            font-weight: bold;
        }

        .discount-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.25rem;
            padding: 0.5rem 0.75rem;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.875rem;
        }

        .discount-badge.high-discount {
            background: linear-gradient(135deg, #ff6b6b, #ee5a24);
            color: white;
        }

        .discount-badge.medium-discount {
            background: linear-gradient(135deg, #ffa726, #ff9800);
            color: white;
        }

        .discount-badge.low-discount {
            background: linear-gradient(135deg, #66bb6a, #4caf50);
            color: white;
        }

        .expiry-info {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .days-left {
            color: #28a745;
            font-weight: 500;
        }

        .coupon-row.expired {
            opacity: 0.7;
            background-color: #f8f9fa;
        }

        .created-info {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #6c757d;
            font-size: 0.875rem;
        }

        .copy-toast {
            position: fixed;
            top: 20px;
            right: 20px;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 1rem 1.5rem;
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            z-index: 1000;
            animation: slideInRight 0.3s ease;
        }

        @keyframes slideInRight {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        .status-badge.expired {
            background: linear-gradient(135deg, #dc3545, #c82333);
        }

        .status-badge.active {
            background: linear-gradient(135deg, #28a745, #20c997);
        }
    </style>
</body>
</html>
