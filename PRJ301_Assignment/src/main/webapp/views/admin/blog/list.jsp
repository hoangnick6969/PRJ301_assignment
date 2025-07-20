
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Bài viết - Fashion Shop Admin</title>
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
                        <i class="fas fa-blog"></i>
                        Quản lý Bài viết
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <span>Quản lý Bài viết</span>
                    </div>
                </div>
                
                <div class="header-actions">
                    <a href="<c:url value='/admin/blogs?action=add'/>" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm bài viết mới
                    </a>
                    <button class="btn btn-outline" onclick="refreshTable()">
                        <i class="fas fa-sync-alt"></i>
                        Làm mới
                    </button>
                    <button class="btn btn-info" onclick="exportData()">
                        <i class="fas fa-download"></i>
                        Xuất dữ liệu
                    </button>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="stats-grid">
                <div class="stat-card primary">
                    <div class="stat-icon">
                        <i class="fas fa-blog"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">${blogs.size()}</div>
                        <div class="stat-label">Tổng bài viết</div>
                    </div>
                </div>
                
                <div class="stat-card success">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">
                            <c:set var="publishedCount" value="0"/>
                            <c:forEach var="blog" items="${blogs}">
                                <c:if test="${blog.status == 'published'}">
                                    <c:set var="publishedCount" value="${publishedCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${publishedCount}
                        </div>
                        <div class="stat-label">Đã xuất bản</div>
                    </div>
                </div>
                
                <div class="stat-card warning">
                    <div class="stat-icon">
                        <i class="fas fa-edit"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">
                            <c:set var="draftCount" value="0"/>
                            <c:forEach var="blog" items="${blogs}">
                                <c:if test="${blog.status == 'draft'}">
                                    <c:set var="draftCount" value="${draftCount + 1}"/>
                                </c:if>
                            </c:forEach>
                            ${draftCount}
                        </div>
                        <div class="stat-label">Bản nháp</div>
                    </div>
                </div>
                
                <div class="stat-card info">
                    <div class="stat-icon">
                        <i class="fas fa-eye"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">
                            <c:set var="totalViews" value="0"/>
                            <c:forEach var="blog" items="${blogs}">
                                <c:set var="totalViews" value="${totalViews + (blog.viewCount != null ? blog.viewCount : 0)}"/>
                            </c:forEach>
                            <fmt:formatNumber value="${totalViews}" type="number"/>
                        </div>
                        <div class="stat-label">Tổng lượt xem</div>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="filter-section">
                <div class="filter-card">
                    <h3>
                        <i class="fas fa-filter"></i>
                        Bộ lọc và Tìm kiếm
                    </h3>
                    <div class="filter-content">
                        <div class="filter-group">
                            <label for="searchTitle">Tìm theo tiêu đề:</label>
                            <input type="text" id="searchTitle" class="form-control" placeholder="Nhập tiêu đề bài viết...">
                        </div>
                        
                        <div class="filter-group">
                            <label for="filterStatus">Trạng thái:</label>
                            <select id="filterStatus" class="form-control">
                                <option value="">Tất cả trạng thái</option>
                                <option value="published">Đã xuất bản</option>
                                <option value="draft">Bản nháp</option>
                                <option value="archived">Lưu trữ</option>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label for="filterDate">Khoảng thời gian:</label>
                            <select id="filterDate" class="form-control">
                                <option value="">Tất cả</option>
                                <option value="today">Hôm nay</option>
                                <option value="week">7 ngày qua</option>
                                <option value="month">30 ngày qua</option>
                                <option value="year">Năm nay</option>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label for="sortBy">Sắp xếp theo:</label>
                            <select id="sortBy" class="form-control">
                                <option value="created-desc">Ngày tạo mới nhất</option>
                                <option value="created-asc">Ngày tạo cũ nhất</option>
                                <option value="title-asc">Tiêu đề A-Z</option>
                                <option value="title-desc">Tiêu đề Z-A</option>
                                <option value="views-desc">Lượt xem nhiều nhất</option>
                            </select>
                        </div>
                        
                        <div class="filter-actions">
                            <button class="btn btn-primary" onclick="applyFilters()">
                                <i class="fas fa-search"></i>
                                Tìm kiếm
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
                            Danh sách Bài viết
                        </h3>
                        <div class="table-view-options">
                            <button class="btn btn-sm btn-outline ${viewMode == 'table' ? 'active' : ''}" onclick="setViewMode('table')">
                                <i class="fas fa-table"></i>
                                Bảng
                            </button>
                            <button class="btn btn-sm btn-outline ${viewMode == 'grid' ? 'active' : ''}" onclick="setViewMode('grid')">
                                <i class="fas fa-th"></i>
                                Lưới
                            </button>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <c:choose>
                            <c:when test="${not empty blogs}">
                                <!-- Table View -->
                                <div id="tableView" class="view-content">
                                    <table class="data-table" id="blogsTable">
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
                                                    <i class="fas fa-user"></i>
                                                    Tác giả
                                                </th>
                                                <th>
                                                    <i class="fas fa-toggle-on"></i>
                                                    Trạng thái
                                                </th>
                                                <th>
                                                    <i class="fas fa-eye"></i>
                                                    Lượt xem
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
                                            <c:forEach var="blog" items="${blogs}" varStatus="status">
                                                <tr data-id="${blog.id}">
                                                    <td>
                                                        <input type="checkbox" class="row-checkbox" value="${blog.id}">
                                                    </td>
                                                    <td class="image-cell">
                                                        <div class="blog-thumbnail">
                                                            <c:choose>
                                                                <c:when test="${not empty blog.thumbnail}">
                                                                    <img src="${blog.thumbnail}" alt="${blog.title}" loading="lazy">
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <div class="no-image">
                                                                        <i class="fas fa-image"></i>
                                                                    </div>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="blog-info">
                                                            <h4 class="blog-title">
                                                                <a href="<c:url value='/admin/blogs?action=edit&id=${blog.id}'/>" 
                                                                   class="blog-title-link">
                                                                    ${blog.title}
                                                                </a>
                                                            </h4>
                                                            <c:if test="${not empty blog.excerpt}">
                                                                <p class="blog-excerpt">
                                                                    ${blog.excerpt.length() > 80 ? 
                                                                      blog.excerpt.substring(0, 80).concat("...") : 
                                                                      blog.excerpt}
                                                                </p>
                                                            </c:if>
                                                            <c:if test="${not empty blog.tags}">
                                                                <div class="blog-tags">
                                                                    <c:forEach var="tag" items="${blog.tags.split(',')}">
                                                                        <span class="tag">${tag.trim()}</span>
                                                                    </c:forEach>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="author-info">
                                                            <div class="author-avatar">
                                                                <i class="fas fa-user"></i>
                                                            </div>
                                                            <div class="author-name">
                                                                ${blog.author != null ? blog.author.name : 'Admin'}
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <span class="status-badge status-${blog.status != null ? blog.status : 'draft'}">
                                                            <i class="fas ${
                                                                blog.status == 'published' ? 'fa-check-circle' : 
                                                                blog.status == 'archived' ? 'fa-archive' : 
                                                                'fa-edit'
                                                            }"></i>
                                                            <c:choose>
                                                                <c:when test="${blog.status == 'published'}">Đã xuất bản</c:when>
                                                                <c:when test="${blog.status == 'archived'}">Lưu trữ</c:when>
                                                                <c:otherwise>Bản nháp</c:otherwise>
                                                            </c:choose>
                                                        </span>
                                                    </td>
                                                    <td class="text-center">
                                                        <span class="view-count">
                                                            <i class="fas fa-eye"></i>
                                                            <fmt:formatNumber value="${blog.viewCount != null ? blog.viewCount : 0}" type="number"/>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <div class="date-info">
                                                            <c:if test="${blog.createdAt != null}">
                                                                <fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy"/>
                                                                <div class="time-small">
                                                                    <fmt:formatDate value="${blog.createdAt}" pattern="HH:mm"/>
                                                                </div>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="<c:url value='/blog/${blog.id}'/>" 
                                                               class="btn btn-sm btn-info"
                                                               title="Xem bài viết"
                                                               target="_blank">
                                                                <i class="fas fa-external-link-alt"></i>
                                                            </a>
                                                            
                                                            <a href="<c:url value='/admin/blogs?action=edit&id=${blog.id}'/>" 
                                                               class="btn btn-sm btn-warning"
                                                               title="Chỉnh sửa">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            
                                                            <button class="btn btn-sm btn-secondary" 
                                                                    onclick="duplicateBlog(${blog.id})"
                                                                    title="Nhân bản">
                                                                <i class="fas fa-copy"></i>
                                                            </button>
                                                            
                                                            <button class="btn btn-sm btn-danger" 
                                                                    onclick="confirmDelete(${blog.id}, '${blog.title}')"
                                                                    title="Xóa">
                                                                <i class="fas fa-trash-alt"></i>
                                                            </button>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>

                                <!-- Grid View -->
                                <div id="gridView" class="view-content" style="display: none;">
                                    <div class="blog-grid">
                                        <c:forEach var="blog" items="${blogs}">
                                            <div class="blog-card" data-id="${blog.id}">
                                                <div class="blog-card-header">
                                                    <div class="blog-card-thumbnail">
                                                        <c:choose>
                                                            <c:when test="${not empty blog.thumbnail}">
                                                                <img src="${blog.thumbnail}" alt="${blog.title}" loading="lazy">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <div class="no-image">
                                                                    <i class="fas fa-image"></i>
                                                                </div>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                    <div class="blog-card-status">
                                                        <span class="status-badge status-${blog.status != null ? blog.status : 'draft'}">
                                                            ${blog.status == 'published' ? 'Xuất bản' : 
                                                              blog.status == 'archived' ? 'Lưu trữ' : 'Nháp'}
                                                        </span>
                                                    </div>
                                                </div>
                                                
                                                <div class="blog-card-content">
                                                    <h4 class="blog-card-title">
                                                        <a href="<c:url value='/admin/blogs?action=edit&id=${blog.id}'/>">${blog.title}</a>
                                                    </h4>
                                                    
                                                    <c:if test="${not empty blog.excerpt}">
                                                        <p class="blog-card-excerpt">
                                                            ${blog.excerpt.length() > 100 ? 
                                                              blog.excerpt.substring(0, 100).concat("...") : 
                                                              blog.excerpt}
                                                        </p>
                                                    </c:if>
                                                    
                                                    <div class="blog-card-meta">
                                                        <div class="blog-card-author">
                                                            <i class="fas fa-user"></i>
                                                            ${blog.author != null ? blog.author.name : 'Admin'}
                                                        </div>
                                                        <div class="blog-card-views">
                                                            <i class="fas fa-eye"></i>
                                                            <fmt:formatNumber value="${blog.viewCount != null ? blog.viewCount : 0}" type="number"/>
                                                        </div>
                                                        <div class="blog-card-date">
                                                            <i class="fas fa-calendar"></i>
                                                            <fmt:formatDate value="${blog.createdAt}" pattern="dd/MM/yyyy"/>
                                                        </div>
                                                    </div>
                                                    
                                                    <c:if test="${not empty blog.tags}">
                                                        <div class="blog-card-tags">
                                                            <c:forEach var="tag" items="${blog.tags.split(',')}" begin="0" end="2">
                                                                <span class="tag">${tag.trim()}</span>
                                                            </c:forEach>
                                                        </div>
                                                    </c:if>
                                                </div>
                                                
                                                <div class="blog-card-actions">
                                                    <a href="<c:url value='/blog/${blog.id}'/>" 
                                                       class="btn btn-sm btn-info"
                                                       target="_blank">
                                                        <i class="fas fa-external-link-alt"></i>
                                                    </a>
                                                    <a href="<c:url value='/admin/blogs?action=edit&id=${blog.id}'/>" 
                                                       class="btn btn-sm btn-warning">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <button class="btn btn-sm btn-danger" 
                                                            onclick="confirmDelete(${blog.id}, '${blog.title}')">
                                                        <i class="fas fa-trash-alt"></i>
                                                    </button>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <i class="fas fa-blog empty-icon"></i>
                                    <h3>Chưa có bài viết nào</h3>
                                    <p>Hãy tạo bài viết đầu tiên để bắt đầu chia sẻ nội dung với khách hàng!</p>
                                    <a href="<c:url value='/admin/blogs?action=add'/>" class="btn btn-primary">
                                        <i class="fas fa-plus"></i>
                                        Tạo bài viết đầu tiên
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <c:if test="${not empty blogs}">
                        <div class="table-footer">
                            <div class="bulk-actions">
                                <select id="bulkAction" class="form-control" disabled>
                                    <option value="">Thao tác hàng loạt</option>
                                    <option value="publish">Xuất bản</option>
                                    <option value="draft">Chuyển về nháp</option>
                                    <option value="archive">Lưu trữ</option>
                                    <option value="delete">Xóa</option>
                                </select>
                                <button class="btn btn-secondary" onclick="executeBulkAction()" disabled id="bulkActionBtn">
                                    Thực hiện
                                </button>
                            </div>
                            
                            <div class="pagination">
                                <span class="pagination-info">
                                    Hiển thị ${blogs.size()} bài viết
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

    <script>
        let currentSort = { column: -1, direction: 'asc' };
        let currentViewMode = 'table';
        
        function refreshTable() {
            window.location.reload();
        }
        
        function setViewMode(mode) {
            currentViewMode = mode;
            const tableView = document.getElementById('tableView');
            const gridView = document.getElementById('gridView');
            const buttons = document.querySelectorAll('.table-view-options .btn');
            
            if (mode === 'grid') {
                tableView.style.display = 'none';
                gridView.style.display = 'block';
            } else {
                tableView.style.display = 'block';
                gridView.style.display = 'none';
            }
            
            buttons.forEach(btn => btn.classList.remove('active'));
            event.target.closest('.btn').classList.add('active');
            
            localStorage.setItem('blogViewMode', mode);
        }
        
        function applyFilters() {
            const title = document.getElementById('searchTitle').value.toLowerCase();
            const status = document.getElementById('filterStatus').value;
            const dateRange = document.getElementById('filterDate').value;
            const sortBy = document.getElementById('sortBy').value;
            
            let items;
            if (currentViewMode === 'table') {
                items = document.querySelectorAll('#blogsTable tbody tr');
            } else {
                items = document.querySelectorAll('.blog-card');
            }
            
            let filteredItems = Array.from(items);
            
            // Apply filters
            filteredItems = filteredItems.filter(item => {
                let show = true;
                
                if (currentViewMode === 'table') {
                    const titleText = item.querySelector('.blog-title-link').textContent.toLowerCase();
                    const statusBadge = item.querySelector('.status-badge');
                    
                    if (title && !titleText.includes(title)) show = false;
                    if (status && !statusBadge.classList.contains('status-' + status)) show = false;
                } else {
                    const titleText = item.querySelector('.blog-card-title a').textContent.toLowerCase();
                    const statusBadge = item.querySelector('.status-badge');
                    
                    if (title && !titleText.includes(title)) show = false;
                    if (status && !statusBadge.classList.contains('status-' + status)) show = false;
                }
                
                return show;
            });
            
            // Hide all items first
            items.forEach(item => item.style.display = 'none');
            
            // Show filtered items
            filteredItems.forEach(item => item.style.display = '');
        }
        
        function clearFilters() {
            document.getElementById('searchTitle').value = '';
            document.getElementById('filterStatus').value = '';
            document.getElementById('filterDate').value = '';
            document.getElementById('sortBy').value = 'created-desc';
            applyFilters();
        }
        
        function sortTable(columnIndex) {
            if (currentViewMode !== 'table') return;
            
            const table = document.getElementById('blogsTable');
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
            if (confirm(`Bạn có chắc chắn muốn xóa bài viết "${title}"?\n\nHành động này không thể hoàn tác!`)) {
                window.location.href = `<c:url value='/admin/blogs?action=delete&id='/>` + id;
            }
        }
        
        function duplicateBlog(id) {
            if (confirm('Bạn có muốn tạo bản sao của bài viết này?')) {
                window.location.href = `<c:url value='/admin/blogs?action=duplicate&id='/>` + id;
            }
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
            
            let confirmMessage = '';
            switch(action) {
                case 'publish':
                    confirmMessage = `xuất bản ${ids.length} bài viết`;
                    break;
                case 'draft':
                    confirmMessage = `chuyển ${ids.length} bài viết về bản nháp`;
                    break;
                case 'archive':
                    confirmMessage = `lưu trữ ${ids.length} bài viết`;
                    break;
                case 'delete':
                    confirmMessage = `xóa ${ids.length} bài viết (không thể hoàn tác)`;
                    break;
            }
            
            if (confirm(`Bạn có chắc chắn muốn ${confirmMessage}?`)) {
                // Implementation for bulk actions
                console.log(`Bulk ${action} for blogs:`, ids);
            }
        }
        
        // Event listeners
        document.addEventListener('DOMContentLoaded', function() {
            // Restore view mode
            const savedViewMode = localStorage.getItem('blogViewMode');
            if (savedViewMode && savedViewMode !== 'table') {
                setViewMode(savedViewMode);
            }
            
            const checkboxes = document.querySelectorAll('.row-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', updateBulkActions);
            });
            
            const searchInput = document.getElementById('searchTitle');
            searchInput.addEventListener('input', applyFilters);
            
            const filterInputs = document.querySelectorAll('#filterStatus, #filterDate, #sortBy');
            filterInputs.forEach(input => {
                input.addEventListener('change', applyFilters);
            });
        });
    </script>
</body>
</html>
