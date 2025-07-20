<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📂 Danh sách danh mục sản phẩm</h2>

<a href="${pageContext.request.contextPath}/admin/categories?action=add">➕ Thêm danh mục</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Tên danh mục</th>
        <th>Mô tả</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="c" items="${categoryList}">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>
            <td>${c.description}</td>
            <td>
                <a href="categories?action=edit&id=${c.id}">✏️ Sửa</a> |
                <a href="categories?action=delete&id=${c.id}" onclick="return confirm('Xoá danh mục này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Danh mục - Fashion Shop Admin</title>
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
                        <i class="fas fa-tags"></i>
                        Quản lý Danh mục
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <span>Quản lý Danh mục</span>
                    </div>
                </div>
                
                <div class="header-actions">
                    <a href="<c:url value='/admin/categories?action=add'/>" class="btn btn-primary">
                        <i class="fas fa-plus"></i>
                        Thêm danh mục mới
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
                        <i class="fas fa-tags"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">${categories.size()}</div>
                        <div class="stat-label">Tổng danh mục</div>
                    </div>
                </div>
                
                <div class="stat-card success">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">
                            <c:set var="activeCount" value="0"/>
                            <c:forEach var="category" items="${categories}">
                                <c:if test="${category.active}">
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
                        <div class="stat-number">${categories.size() - activeCount}</div>
                        <div class="stat-label">Tạm dừng</div>
                    </div>
                </div>
                
                <div class="stat-card info">
                    <div class="stat-icon">
                        <i class="fas fa-box"></i>
                    </div>
                    <div class="stat-content">
                        <div class="stat-number">
                            <c:set var="totalProducts" value="0"/>
                            <c:forEach var="category" items="${categories}">
                                <c:set var="totalProducts" value="${totalProducts + (category.productCount != null ? category.productCount : 0)}"/>
                            </c:forEach>
                            ${totalProducts}
                        </div>
                        <div class="stat-label">Tổng sản phẩm</div>
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
                            <label for="searchName">Tìm theo tên:</label>
                            <input type="text" id="searchName" class="form-control" placeholder="Nhập tên danh mục...">
                        </div>
                        
                        <div class="filter-group">
                            <label for="filterStatus">Trạng thái:</label>
                            <select id="filterStatus" class="form-control">
                                <option value="">Tất cả</option>
                                <option value="active">Hoạt động</option>
                                <option value="inactive">Tạm dừng</option>
                            </select>
                        </div>
                        
                        <div class="filter-group">
                            <label for="sortBy">Sắp xếp theo:</label>
                            <select id="sortBy" class="form-control">
                                <option value="name">Tên A-Z</option>
                                <option value="name-desc">Tên Z-A</option>
                                <option value="created">Ngày tạo mới nhất</option>
                                <option value="created-desc">Ngày tạo cũ nhất</option>
                                <option value="products">Số sản phẩm nhiều nhất</option>
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
                            Danh sách Danh mục
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
                            <c:when test="${not empty categories}">
                                <table class="data-table" id="categoriesTable">
                                    <thead>
                                        <tr>
                                            <th>
                                                <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
                                            </th>
                                            <th>
                                                <i class="fas fa-icons"></i>
                                                Icon
                                            </th>
                                            <th>
                                                <i class="fas fa-tag"></i>
                                                Tên danh mục
                                                <button class="sort-btn" onclick="sortTable(2)">
                                                    <i class="fas fa-sort"></i>
                                                </button>
                                            </th>
                                            <th>
                                                <i class="fas fa-align-left"></i>
                                                Mô tả
                                            </th>
                                            <th>
                                                <i class="fas fa-box"></i>
                                                Sản phẩm
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
                                        <c:forEach var="category" items="${categories}" varStatus="status">
                                            <tr data-id="${category.id}">
                                                <td>
                                                    <input type="checkbox" class="row-checkbox" value="${category.id}">
                                                </td>
                                                <td class="icon-cell">
                                                    <div class="category-icon-display">
                                                        <i class="${not empty category.icon ? category.icon : 'fas fa-folder'}" 
                                                           title="${category.name}"></i>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="category-info">
                                                        <strong class="category-name">${category.name}</strong>
                                                        <c:if test="${not empty category.slug}">
                                                            <div class="category-slug">/${category.slug}</div>
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td class="description-cell">
                                                    <div class="category-description">
                                                        <c:choose>
                                                            <c:when test="${not empty category.description}">
                                                                ${category.description.length() > 100 ? 
                                                                  category.description.substring(0, 100).concat("...") : 
                                                                  category.description}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Chưa có mô tả</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </td>
                                                <td class="text-center">
                                                    <span class="product-count-badge">
                                                        <i class="fas fa-box"></i>
                                                        ${category.productCount != null ? category.productCount : 0}
                                                    </span>
                                                </td>
                                                <td class="text-center">
                                                    <span class="sort-order">${category.sortOrder != null ? category.sortOrder : 0}</span>
                                                </td>
                                                <td>
                                                    <span class="status-badge ${category.active ? 'status-active' : 'status-inactive'}">
                                                        <i class="fas ${category.active ? 'fa-check-circle' : 'fa-pause-circle'}"></i>
                                                        ${category.active ? 'Hoạt động' : 'Tạm dừng'}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="date-info">
                                                        <c:if test="${category.createdAt != null}">
                                                            <fmt:formatDate value="${category.createdAt}" pattern="dd/MM/yyyy"/>
                                                            <div class="time-small">
                                                                <fmt:formatDate value="${category.createdAt}" pattern="HH:mm"/>
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                </td>
                                                <td>
                                                    <div class="action-buttons">
                                                        <a href="<c:url value='/admin/products?category=${category.id}'/>" 
                                                           class="btn btn-sm btn-info"
                                                           title="Xem sản phẩm">
                                                            <i class="fas fa-box"></i>
                                                        </a>
                                                        
                                                        <a href="<c:url value='/admin/categories?action=edit&id=${category.id}'/>" 
                                                           class="btn btn-sm btn-warning"
                                                           title="Chỉnh sửa">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        
                                                        <button class="btn btn-sm btn-danger" 
                                                                onclick="confirmDelete(${category.id}, '${category.name}')"
                                                                title="Xóa">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </button>
                                                        
                                                        <button class="btn btn-sm ${category.active ? 'btn-secondary' : 'btn-success'}" 
                                                                onclick="toggleStatus(${category.id}, ${category.active})"
                                                                title="${category.active ? 'Tạm dừng' : 'Kích hoạt'}">
                                                            <i class="fas ${category.active ? 'fa-pause' : 'fa-play'}"></i>
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
                                    <i class="fas fa-tags empty-icon"></i>
                                    <h3>Chưa có danh mục nào</h3>
                                    <p>Hãy tạo danh mục đầu tiên để bắt đầu phân loại sản phẩm của bạn!</p>
                                    <a href="<c:url value='/admin/categories?action=add'/>" class="btn btn-primary">
                                        <i class="fas fa-plus"></i>
                                        Tạo danh mục đầu tiên
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <c:if test="${not empty categories}">
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
                                    Hiển thị ${categories.size()} danh mục
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
        
        function refreshTable() {
            window.location.reload();
        }
        
        function applyFilters() {
            const name = document.getElementById('searchName').value.toLowerCase();
            const status = document.getElementById('filterStatus').value;
            const sortBy = document.getElementById('sortBy').value;
            
            const rows = document.querySelectorAll('#categoriesTable tbody tr');
            let filteredRows = Array.from(rows);
            
            // Apply filters
            filteredRows = filteredRows.filter(row => {
                const nameText = row.querySelector('.category-name').textContent.toLowerCase();
                const statusBadge = row.querySelector('.status-badge');
                const isActive = statusBadge.classList.contains('status-active');
                
                let show = true;
                
                if (name && !nameText.includes(name)) show = false;
                if (status === 'active' && !isActive) show = false;
                if (status === 'inactive' && isActive) show = false;
                
                return show;
            });
            
            // Hide all rows first
            rows.forEach(row => row.style.display = 'none');
            
            // Apply sorting
            filteredRows.sort((a, b) => {
                let aValue, bValue;
                
                switch(sortBy) {
                    case 'name':
                        aValue = a.querySelector('.category-name').textContent;
                        bValue = b.querySelector('.category-name').textContent;
                        return aValue.localeCompare(bValue);
                    case 'name-desc':
                        aValue = a.querySelector('.category-name').textContent;
                        bValue = b.querySelector('.category-name').textContent;
                        return bValue.localeCompare(aValue);
                    case 'products':
                        aValue = parseInt(a.querySelector('.product-count-badge').textContent.match(/\d+/)[0]);
                        bValue = parseInt(b.querySelector('.product-count-badge').textContent.match(/\d+/)[0]);
                        return bValue - aValue;
                    default:
                        return 0;
                }
            });
            
            // Show filtered and sorted rows
            filteredRows.forEach(row => row.style.display = '');
        }
        
        function clearFilters() {
            document.getElementById('searchName').value = '';
            document.getElementById('filterStatus').value = '';
            document.getElementById('sortBy').value = 'name';
            applyFilters();
        }
        
        function sortTable(columnIndex) {
            const table = document.getElementById('categoriesTable');
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
        
        function confirmDelete(id, name) {
            if (confirm(`Bạn có chắc chắn muốn xóa danh mục "${name}"?\n\nLưu ý: Việc xóa danh mục có thể ảnh hưởng đến các sản phẩm thuộc danh mục này.`)) {
                window.location.href = `<c:url value='/admin/categories?action=delete&id='/>` + id;
            }
        }
        
        function toggleStatus(id, currentStatus) {
            const action = currentStatus ? 'deactivate' : 'activate';
            const message = currentStatus ? 'tạm dừng' : 'kích hoạt';
            
            if (confirm(`Bạn có muốn ${message} danh mục này?`)) {
                // Implementation for status toggle
                console.log(`Toggle status for category ${id} to ${!currentStatus}`);
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
            
            if (confirm(`Bạn có chắc chắn muốn thực hiện thao tác này cho ${ids.length} danh mục?`)) {
                // Implementation for bulk actions
                console.log(`Bulk ${action} for categories:`, ids);
            }
        }
        
        // Event listeners
        document.addEventListener('DOMContentLoaded', function() {
            const checkboxes = document.querySelectorAll('.row-checkbox');
            checkboxes.forEach(checkbox => {
                checkbox.addEventListener('change', updateBulkActions);
            });
            
            const searchInput = document.getElementById('searchName');
            searchInput.addEventListener('input', applyFilters);
            
            const filterInputs = document.querySelectorAll('#filterStatus, #sortBy');
            filterInputs.forEach(input => {
                input.addEventListener('change', applyFilters);
            });
        });
    </script>
</body>
</html>
