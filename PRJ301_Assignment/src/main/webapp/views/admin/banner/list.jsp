
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Banner - Fashion Shop Admin</title>
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
                        <i class="fas fa-image"></i>
                        Quản lý Banner
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <span>Quản lý Banner</span>
                    </div>
                </div>
                
                <div class="header-actions">
                    <a href="<c:url value='/admin/banners?action=add'/>" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm Banner mới
                    </a>
                    <button class="btn btn-outline" onclick="refreshTable()">
                        <i class="fas fa-sync-alt"></i>
                        Làm mới
                    </button>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card primary">
                    <div class="stat-icon">
                        <i class="fas fa-image"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">${banners.size()}</div>
                        <div class="stat-label">Tổng Banner</div>
                    </div>
                </div>
                
                <div class="stat-card success">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">
                            <c:set var="activeCount" value="0"/>
                            <c:forEach var="banner" items="${banners}">
                                <c:if test="${banner.active}">
                                    <c:set var="activeCount" value="${activeCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${activeCount}
                        </div>
                        <div class="stat-label">Đang hoạt động</div>
                    </div>
                </div>
                
                <div class="stat-card warning">
                    <div class="stat-icon">
                        <i class="fas fa-pause-circle"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">${banners.size() - activeCount}</div>
                        <div class="stat-label">Tạm dừng</div>
                    </div>
                </div>
                
                <div class="stat-card info">
                    <div class="stat-icon">
                        <i class="fas fa-home"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">
                            <c:set var="homepageCount" value="0"/>
                            <c:forEach var="banner" items="${banners}">
                                <c:if test="${banner.position.startsWith('homepage')}">
                                    <c:set var="homepageCount" value="${homepageCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${homepageCount}
                        </div>
                        <div class="stat-label">Trang chủ</div>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="filter-section">
                <div class="filter-card">
                    <h3>
                        <i class="fas fa-filter"></i>
                        Bộ lọc
                    </h3>
                    <div class="filter-content">
                        <div class="filter-group">
                            <label for="searchTitle">Tìm theo tiêu đề:</label>
                            <input type="text" id="searchTitle" class="form-control" placeholder="Nhập tiêu đề banner...">
                        </div>
                        
                        <div class="filter-group">
                            <label for="filterPosition">Vị trí:</label>
                            <select id="filterPosition" class="form-control">
                                <option value="">Tất cả vị trí</option>
                                <option value="homepage-top">Trang chủ - Top</option>
                                <option value="homepage-middle">Trang chủ - Giữa</option>
                                <option value="homepage-bottom">Trang chủ - Cuối</option>
                                <option value="product-page">Trang sản phẩm</option>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label for="filterStatus">Trạng thái:</label>
                            <select id="filterStatus" class="form-control">
                                <option value="">Tất cả</option>
                                <option value="active">Hoạt động</option>
                                <option value="inactive">Tạm dừng</option>
                            </select>
                        </div>
                        
                        <div class="filter-actions">
                            <button class="btn btn-primary" onclick="applyFilters()">
                                <i class="fas fa-search"></i>
                                Áp dụng
                            </button>
                            <button class="btn btn-secondary" onclick="clearFilters()">
                                <i class="fas fa-eraser"></i>
                                Xóa bộ lọc
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Table Section -->
            <div class="table-section">
                <div class="table-card">
                    <div class="table-header">
                        <h3>
                            <i class="fas fa-list"></i>
                            Danh sách Banner
                        </h3>
                        <div class="table-actions">
                            <button class="btn btn-outline btn-sm" onclick="exportData()">
                                <i class="fas fa-download"></i>
                                Xuất dữ liệu
                            </button>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${not empty banners}">
                                <table class="data-table" id="bannersTable">
                                    <thead>
                                        <tr>
                                            <th>
                                                <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
                                            </th>
                                            <th>
                                                <i class="fas fa-image"></i>
                                                Hình ảnh
                                            </th>
                                            <th>
                                                <i class="fas fa-heading"></i>
                                                Tiêu đề
                                                <button class="sort-btn" onclick="sortTable(2)">
                                                    <i class="fas fa-sort"></i>
                                                </button>
                                            </th>
                                            <th>
                                                <i class="fas fa-map-marker-alt"></i>
                                                Vị trí
                                            </th>
                                            <th>
                                                <i class="fas fa-sort-numeric-up"></i>
                                                Thứ tự
                                            </th>
                                            <th>
                                                <i class="fas fa-toggle-on"></i>
                                                Trạng thái
                                            </th>
                                            <th>
                                                <i class="fas fa-calendar"></i>
                                                Ngày tạo
                                            </th>
                                            <th>
                                                <i class="fas fa-cogs"></i>
                                                Thao tác
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="banner" items="${banners}" varStatus="status">
                                            <tr data-id="${banner.id}">
                                                <td>
                                                    <input type="checkbox" class="row-checkbox" value="${banner.id}">
                                                </td>
                                                <td class="image-cell">
                                                    <div class="banner-thumbnail">
                                                        <img src="${banner.imageUrl}" 
                                                             alt="${banner.title}"
                                                             onerror="this.src='<c:url value="/images/placeholder.jpg"/>'"
                                                             onclick="showImageModal('${banner.imageUrl}', '${banner.title}')">
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="banner-info">
                                                        <strong class="banner-title">${banner.title}</strong>
                                                        <c:if test="${not empty banner.description}">
                                                            <div class="banner-description">${banner.description}</div>
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td>
                                                    <span class="badge badge-info position-badge">
                                                        <c:choose>
                                                            <c:when test="${banner.position == 'homepage-top'}">
                                                                <i class="fas fa-arrow-up"></i> Trang chủ - Top
                                                            </c:when>
                                                            <c:when test="${banner.position == 'homepage-middle'}">
                                                                <i class="fas fa-arrows-alt-v"></i> Trang chủ - Giữa
                                                            </c:when>
                                                            <c:when test="${banner.position == 'homepage-bottom'}">
                                                                <i class="fas fa-arrow-down"></i> Trang chủ - Cuối
                                                            </c:when>
                                                            <c:when test="${banner.position == 'product-page'}">
                                                                <i class="fas fa-shopping-bag"></i> Trang sản phẩm
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${banner.position}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <span class="sort-order">${banner.sortOrder}</span>
                                                </td>
                                                <td>
                                                    <span class="status-badge ${banner.active ? 'status-active' : 'status-inactive'}">
                                                        <i class="fas ${banner.active ? 'fa-check-circle' : 'fa-pause-circle'}"></i>
                                                        ${banner.active ? 'Hoạt động' : 'Tạm dừng'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="date-info">
                                                        <c:if test="${banner.createdAt != null}">
                                                            <fmt:formatDate value="${banner.createdAt}" pattern="dd/MM/yyyy"/>
                                                            <div class="time-small">
                                                                <fmt:formatDate value="${banner.createdAt}" pattern="HH:mm"/>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <c:if test="${not empty banner.linkUrl}">
                                                            <a href="${banner.linkUrl}" 
                                                               target="_blank" 
                                                               class="btn btn-sm btn-info"
                                                               title="Xem liên kết">
                                                                <i class="fas fa-external-link-alt"></i>
                                                            </a>
                                                        </c:if>
                                                        
                                                        <a href="<c:url value='/admin/banners?action=edit&id=${banner.id}'/>" 
                                                           class="btn btn-sm btn-warning"
                                                           title="Chỉnh sửa">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        
                                                        <button class="btn btn-sm btn-danger" 
                                                                onclick="confirmDelete(${banner.id}, '${banner.title}')"
                                                                title="Xóa">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </button>
                                                        
                                                        <button class="btn btn-sm ${banner.active ? 'btn-secondary' : 'btn-success'}" 
                                                                onclick="toggleStatus(${banner.id}, ${banner.active})"
                                                                title="${banner.active ? 'Tạm dừng' : 'Kích hoạt'}">
                                                            <i class="fas ${banner.active ? 'fa-pause' : 'fa-play'}"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-image empty-icon"></i>
                                    <h3>Chưa có banner nào</h3>
                                    <p>Hãy thêm banner đầu tiên để bắt đầu quảng bá sản phẩm của bạn!</p>
                                    <a href="<c:url value='/admin/banners?action=add'/>" class="btn btn-primary">
                                        <i class="fas fa-plus"></i>
                                        Thêm Banner đầu tiên
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <c:if test="${not empty banners}">
                        <div class="table-footer">
                            <div class="bulk-actions">
                                <select id="bulkAction" class="form-control" disabled>
                                    <option value="">Thao tác hàng loạt</option>
                                    <option value="activate">Kích hoạt</option>
                                    <option value="deactivate">Tạm dừng</option>
                                    <option value="delete">Xóa</option>
                                </select>
                                <button class="btn btn-secondary" onclick="executeBulkAction()" disabled id="bulkActionBtn">
                                    Thực hiện
                                </button>
                            </div>
                            
                            <div class="pagination">
                                <span class="pagination-info">
                                    Hiển thị ${banners.size()} banner
                                </span>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <!-- Image Modal -->
    <div id="imageModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h4 id="modalTitle">Banner Preview</h4>
                <span class="close" onclick="closeImageModal()">&times;</span>
            </div>
            <div class="modal-body">
                <img id="modalImage" src="" alt="">
            </div>
        </div>
    </div>

    <script>
        let currentSort = { column: -1, direction: 'asc' };
        
        function refreshTable() {
            window.location.reload();
        }
        
        function applyFilters() {
            const title = document.getElementById('searchTitle').value.toLowerCase();
            const position = document.getElementById('filterPosition').value;
            const status = document.getElementById('filterStatus').value;
            
            const rows = document.querySelectorAll('#bannersTable tbody tr');
            
            rows.forEach(row => {
                const titleText = row.querySelector('.banner-title').textContent.toLowerCase();
                const positionBadge = row.querySelector('.position-badge').textContent;
                const statusBadge = row.querySelector('.status-badge');
                const isActive = statusBadge.classList.contains('status-active');
                
                let show = true;
                
                if (title && !titleText.includes(title)) show = false;
                if (position && !positionBadge.includes(position)) show = false;
                if (status === 'active' && !isActive) show = false;
                if (status === 'inactive' && isActive) show = false;
                
                row.style.display = show ? '' : 'none';
            });
        }
        
        function clearFilters() {
            document.getElementById('searchTitle').value = '';
            document.getElementById('filterPosition').value = '';
            document.getElementById('filterStatus').value = '';
            applyFilters();
        }
        
        function sortTable(columnIndex) {
            const table = document.getElementById('bannersTable');
            const tbody = table.querySelector('tbody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            if (currentSort.column === columnIndex) {
                currentSort.direction = currentSort.direction === 'asc' ? 'desc' : 'asc';
            } else {
                currentSort.column = columnIndex;
                currentSort.direction = 'asc';
            }
            
            rows.sort((a, b) => {
                const aText = a.cells[columnIndex].textContent.trim();
                const bText = b.cells[columnIndex].textContent.trim();
                
                let comparison = 0;
                if (aText > bText) comparison = 1;
                else if (aText < bText) comparison = -1;
                
                return currentSort.direction === 'asc' ? comparison : -comparison;
            });
            
            rows.forEach(row => tbody.appendChild(row));
        }
        
        function toggleSelectAll() {
            const selectAll = document.getElementById('selectAll');
            const checkboxes = document.querySelectorAll('.row-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
            
            updateBulkActions();
        }
        
        function updateBulkActions() {
            const checkboxes = document.querySelectorAll('.row-checkbox:checked');
            const bulkAction = document.getElementById('bulkAction');
            const bulkActionBtn = document.getElementById('bulkActionBtn');
            
            if (checkboxes.length > 0) {
                bulkAction.disabled = false;
                bulkActionBtn.disabled = false;
            } else {
                bulkAction.disabled = true;
                bulkActionBtn.disabled = true;
            }
        }
        
        function confirmDelete(id, title) {
            if (confirm(`Bạn có chắc chắn muốn xóa banner "${title}"?`)) {
                window.location.href = `<c:url value='/admin/banners?action=delete&id='/>` + id;
            }
        }
        
        function toggleStatus(id, currentStatus) {
            const action = currentStatus ? 'deactivate' : 'activate';
            const message = currentStatus ? 'tạm dừng' : 'kích hoạt';
            
            if (confirm(`Bạn có muốn ${message} banner này?`)) {
                // Implementation for status toggle
                console.log(`Toggle status for banner ${id} to ${!currentStatus}`);
            }
        }
        
        function showImageModal(imageUrl, title) {
            document.getElementById('modalImage').src = imageUrl;
            document.getElementById('modalTitle').textContent = title;
            document.getElementById('imageModal').style.display = 'block';
        }
        
        function closeImageModal() {
            document.getElementById('imageModal').style.display = 'none';
        }
        
        function exportData() {
            // Implementation for data export
            alert('Chức năng xuất dữ liệu sẽ được triển khai.');
        }
        
        function executeBulkAction() {
            const action = document.getElementById('bulkAction').value;
            const checkboxes = document.querySelectorAll('.row-checkbox:checked');
            
            if (!action || checkboxes.length === 0) return;
            
            const ids = Array.from(checkboxes).map(cb => cb.value);
            
            if (confirm(`Bạn có chắc chắn muốn thực hiện thao tác này cho ${ids.length} banner?`)) {
                // Implementation for bulk actions
                console.log(`Bulk ${action} for banners:`, ids);
            }
        }
        
        // Event listeners
        document.addEventListener('DOMContentLoaded', function() {
            const checkboxes = document.querySelectorAll('.row-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', updateBulkActions);
            });
            
            const searchInput = document.getElementById('searchTitle');
            searchInput.addEventListener('input', applyFilters);
        });
        
        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('imageModal');
            if (event.target === modal) {
                closeImageModal();
            }
        }
    </script>
</body>
</html>
