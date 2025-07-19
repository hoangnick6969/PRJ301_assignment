<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>👥 Danh sách khách hàng</h2>

<table border="1" cellspacing="0" cellpadding="8" width="100%">
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Email</th>
        <th>SĐT</th>
        <th>Địa chỉ</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="c" items="${customerList}">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>
            <td>${c.email}</td>
            <td>${c.phone}</td>
            <td>${c.address}</td>
            <td>
                <a href="orders?customerId=${c.id}">📦 Xem đơn hàng</a>
                <!-- Hoặc -->
                <a href="customer?action=delete&id=${c.id}" onclick="return confirm('Xoá khách hàng này?')">🗑 Xoá</a>
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
    <title>Quản lý khách hàng - Fashion Shop Admin</title>
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
                        <i class="fas fa-users"></i>
                        👥 Quản lý khách hàng
                    </h1>
                    <div class="header-actions">
                        <button class="btn btn-primary" onclick="exportCustomers()">
                            <i class="fas fa-download"></i>
                            Xuất danh sách
                        </button>
                        <button class="btn btn-success" onclick="refreshData()">
                            <i class="fas fa-sync-alt"></i>
                            Làm mới
                        </button>
                    </div>
                </div>
                
                <div class="breadcrumb">
                    <a href="<c:url value='/admin/dashboard'/>">
                        <i class="fas fa-home"></i> Dashboard
                    </a>
                    <span class="separator">/</span>
                    <span>
                        <i class="fas fa-users"></i> Khách hàng
                    </span>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card primary">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-content">
                        <h3>${customers.size()}</h3>
                        <p>Tổng khách hàng</p>
                    </div>
                </div>
                
                <div class="stat-card success">
                    <div class="stat-icon">
                        <i class="fas fa-user-check"></i>
                    </div>
                    <div class="stat-content">
                        <h3 id="activeCustomers">0</h3>
                        <p>Khách hàng hoạt động</p>
                    </div>
                </div>
                
                <div class="stat-card warning">
                    <div class="stat-icon">
                        <i class="fas fa-user-plus"></i>
                    </div>
                    <div class="stat-content">
                        <h3 id="newCustomers">0</h3>
                        <p>Khách hàng mới</p>
                    </div>
                </div>
                
                <div class="stat-card info">
                    <div class="stat-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="stat-content">
                        <h3 id="customersWithOrders">0</h3>
                        <p>Có đơn hàng</p>
                    </div>
                </div>
            </div>

            <!-- Search and Filter Section -->
            <div class="filter-section">
                <div class="filter-card">
                    <div class="filter-header">
                        <h3>
                            <i class="fas fa-search"></i>
                            Tìm kiếm & Lọc
                        </h3>
                    </div>
                    
                    <div class="filter-content">
                        <div class="search-grid">
                            <div class="search-group">
                                <label class="filter-label">
                                    <i class="fas fa-search"></i>
                                    Tìm kiếm
                                </label>
                                <input type="text" 
                                       id="searchInput" 
                                       class="form-control" 
                                       placeholder="Tìm theo tên, email, số điện thoại..."
                                       onkeyup="filterCustomers()">
                            </div>
                            
                            <div class="search-group">
                                <label class="filter-label">
                                    <i class="fas fa-filter"></i>
                                    Trạng thái
                                </label>
                                <select id="statusFilter" class="form-control" onchange="filterCustomers()">
                                    <option value="">Tất cả trạng thái</option>
                                    <option value="active">Hoạt động</option>
                                    <option value="inactive">Không hoạt động</option>
                                </select>
                            </div>
                            
                            <div class="search-group">
                                <label class="filter-label">
                                    <i class="fas fa-sort"></i>
                                    Sắp xếp
                                </label>
                                <select id="sortFilter" class="form-control" onchange="sortCustomers()">
                                    <option value="name_asc">Tên A-Z</option>
                                    <option value="name_desc">Tên Z-A</option>
                                    <option value="email_asc">Email A-Z</option>
                                    <option value="joined_desc">Mới nhất</option>
                                    <option value="joined_asc">Cũ nhất</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Customer List -->
            <div class="table-section">
                <div class="table-card">
                    <div class="table-header">
                        <h3>
                            <i class="fas fa-list"></i>
                            Danh sách khách hàng
                        </h3>
                        <div class="table-actions">
                            <button class="btn btn-outline" onclick="selectAll()">
                                <i class="fas fa-check-square"></i>
                                Chọn tất cả
                            </button>
                            <button class="btn btn-danger" onclick="deleteSelected()" id="deleteBtn" style="display: none;">
                                <i class="fas fa-trash"></i>
                                Xóa đã chọn
                            </button>
                        </div>
                    </div>

                    <div class="table-responsive">
                        <table class="data-table" id="customerTable">
                            <thead>
                                <tr>
                                    <th>
                                        <input type="checkbox" id="selectAllCheckbox" onchange="toggleSelectAll()">
                                    </th>
                                    <th>
                                        <i class="fas fa-user"></i>
                                        Khách hàng
                                    </th>
                                    <th>
                                        <i class="fas fa-envelope"></i>
                                        Email
                                    </th>
                                    <th>
                                        <i class="fas fa-phone"></i>
                                        Điện thoại
                                    </th>
                                    <th>
                                        <i class="fas fa-map-marker-alt"></i>
                                        Địa chỉ
                                    </th>
                                    <th>
                                        <i class="fas fa-calendar"></i>
                                        Ngày tham gia
                                    </th>
                                    <th>
                                        <i class="fas fa-shopping-bag"></i>
                                        Đơn hàng
                                    </th>
                                    <th>
                                        <i class="fas fa-toggle-on"></i>
                                        Trạng thái
                                    </th>
                                    <th>
                                        <i class="fas fa-cogs"></i>
                                        Thao tác
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="customer" items="${customers}" varStatus="status">
                                    <tr class="customer-row" data-customer-id="${customer.id}">
                                        <td>
                                            <input type="checkbox" class="customer-checkbox" value="${customer.id}">
                                        </td>
                                        <td>
                                            <div class="customer-info">
                                                <div class="customer-avatar">
                                                    <i class="fas fa-user-circle"></i>
                                                </div>
                                                <div class="customer-details">
                                                    <div class="customer-name">${customer.fullName}</div>
                                                    <div class="customer-id">ID: #${customer.id}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="email-container">
                                                <i class="fas fa-envelope text-muted"></i>
                                                <span class="email-text">${customer.email}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="phone-container">
                                                <i class="fas fa-phone text-muted"></i>
                                                <span class="phone-text">${customer.phone}</span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="address-container">
                                                <i class="fas fa-map-marker-alt text-muted"></i>
                                                <span class="address-text" title="${customer.address}">
                                                    ${customer.address.length() > 30 ? customer.address.substring(0, 30) + "..." : customer.address}
                                                </span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="date-container">
                                                <i class="fas fa-calendar text-muted"></i>
                                                <span class="date-text">
                                                    <fmt:formatDate value="${customer.createdAt}" pattern="dd/MM/yyyy"/>
                                                </span>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="order-stats">
                                                <span class="order-count">5</span>
                                                <span class="order-label">đơn hàng</span>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="status-badge status-active">
                                                <i class="fas fa-check-circle"></i>
                                                Hoạt động
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn-action btn-view" 
                                                        onclick="viewCustomer(${customer.id})" 
                                                        title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                
                                                <button class="btn-action btn-edit" 
                                                        onclick="editCustomer(${customer.id})" 
                                                        title="Chỉnh sửa">
                                                    <i class="fas fa-edit"></i>
                                                </button>
                                                
                                                <button class="btn-action btn-message" 
                                                        onclick="sendMessage(${customer.id})" 
                                                        title="Gửi tin nhắn">
                                                    <i class="fas fa-envelope"></i>
                                                </button>
                                                
                                                <button class="btn-action btn-delete" 
                                                        onclick="deleteCustomer(${customer.id})" 
                                                        title="Xóa khách hàng">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty customers}">
                                    <tr class="no-data-row">
                                        <td colspan="9">
                                            <div class="no-data">
                                                <i class="fas fa-users"></i>
                                                <h3>Chưa có khách hàng nào</h3>
                                                <p>Danh sách khách hàng sẽ hiển thị tại đây khi có người đăng ký</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <!-- Pagination -->
                    <div class="table-footer">
                        <div class="pagination-info">
                            Hiển thị <span id="showingFrom">1</span> - <span id="showingTo">${customers.size()}</span> 
                            của <span id="totalRecords">${customers.size()}</span> khách hàng
                        </div>
                        
                        <div class="pagination-controls">
                            <button class="btn-pagination" id="prevBtn" onclick="previousPage()">
                                <i class="fas fa-chevron-left"></i>
                                Trước
                            </button>
                            
                            <div class="page-numbers" id="pageNumbers">
                                <button class="page-number active">1</button>
                            </div>
                            
                            <button class="btn-pagination" id="nextBtn" onclick="nextPage()">
                                Sau
                                <i class="fas fa-chevron-right"></i>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        // Sample data and functions
        let customers = Array.from(document.querySelectorAll('.customer-row'));
        let currentPage = 1;
        let itemsPerPage = 10;
        let filteredCustomers = [...customers];

        // Initialize page
        document.addEventListener('DOMContentLoaded', function() {
            updateStats();
            updatePagination();
        });

        // Update statistics
        function updateStats() {
            document.getElementById('activeCustomers').textContent = customers.length;
            document.getElementById('newCustomers').textContent = Math.floor(customers.length * 0.2);
            document.getElementById('customersWithOrders').textContent = Math.floor(customers.length * 0.7);
        }

        // Filter customers
        function filterCustomers() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value;
            
            filteredCustomers = customers.filter(row => {
                const name = row.querySelector('.customer-name').textContent.toLowerCase();
                const email = row.querySelector('.email-text').textContent.toLowerCase();
                const phone = row.querySelector('.phone-text').textContent.toLowerCase();
                
                const matchesSearch = name.includes(searchTerm) || 
                                    email.includes(searchTerm) || 
                                    phone.includes(searchTerm);
                
                const matchesStatus = !statusFilter || 
                                    row.querySelector('.status-badge').textContent.toLowerCase().includes(statusFilter);
                
                return matchesSearch && matchesStatus;
            });
            
            showFilteredResults();
            updatePagination();
        }

        // Sort customers
        function sortCustomers() {
            const sortBy = document.getElementById('sortFilter').value;
            
            filteredCustomers.sort((a, b) => {
                const aName = a.querySelector('.customer-name').textContent;
                const bName = b.querySelector('.customer-name').textContent;
                const aEmail = a.querySelector('.email-text').textContent;
                const bEmail = b.querySelector('.email-text').textContent;
                
                switch(sortBy) {
                    case 'name_asc':
                        return aName.localeCompare(bName);
                    case 'name_desc':
                        return bName.localeCompare(aName);
                    case 'email_asc':
                        return aEmail.localeCompare(bEmail);
                    default:
                        return 0;
                }
            });
            
            showFilteredResults();
        }

        // Show filtered results
        function showFilteredResults() {
            const tbody = document.querySelector('#customerTable tbody');
            tbody.innerHTML = '';
            
            if (filteredCustomers.length === 0) {
                tbody.innerHTML = `
                    <tr class="no-data-row">
                        <td colspan="9">
                            <div class="no-data">
                                <i class="fas fa-search"></i>
                                <h3>Không tìm thấy kết quả</h3>
                                <p>Thử thay đổi từ khóa tìm kiếm hoặc bộ lọc</p>
                            </div>
                        </td>
                    </tr>
                `;
                return;
            }
            
            const start = (currentPage - 1) * itemsPerPage;
            const end = start + itemsPerPage;
            const pageCustomers = filteredCustomers.slice(start, end);
            
            pageCustomers.forEach(customer => {
                tbody.appendChild(customer.cloneNode(true));
            });
        }

        // Pagination functions
        function updatePagination() {
            const totalPages = Math.ceil(filteredCustomers.length / itemsPerPage);
            const start = (currentPage - 1) * itemsPerPage + 1;
            const end = Math.min(currentPage * itemsPerPage, filteredCustomers.length);
            
            document.getElementById('showingFrom').textContent = start;
            document.getElementById('showingTo').textContent = end;
            document.getElementById('totalRecords').textContent = filteredCustomers.length;
            
            // Update pagination controls
            document.getElementById('prevBtn').disabled = currentPage === 1;
            document.getElementById('nextBtn').disabled = currentPage === totalPages || totalPages === 0;
        }

        function previousPage() {
            if (currentPage > 1) {
                currentPage--;
                showFilteredResults();
                updatePagination();
            }
        }

        function nextPage() {
            const totalPages = Math.ceil(filteredCustomers.length / itemsPerPage);
            if (currentPage < totalPages) {
                currentPage++;
                showFilteredResults();
                updatePagination();
            }
        }

        // Checkbox functions
        function toggleSelectAll() {
            const selectAll = document.getElementById('selectAllCheckbox');
            const checkboxes = document.querySelectorAll('.customer-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
            
            updateDeleteButton();
        }

        function updateDeleteButton() {
            const checkedBoxes = document.querySelectorAll('.customer-checkbox:checked');
            const deleteBtn = document.getElementById('deleteBtn');
            
            if (checkedBoxes.length > 0) {
                deleteBtn.style.display = 'inline-flex';
            } else {
                deleteBtn.style.display = 'none';
            }
        }

        // Action functions
        function viewCustomer(id) {
            window.location.href = `${pageContext.request.contextPath}/admin/customers?action=view&id=` + id;
        }

        function editCustomer(id) {
            window.location.href = `${pageContext.request.contextPath}/admin/customers?action=edit&id=` + id;
        }

        function deleteCustomer(id) {
            if (confirm('Bạn có chắc chắn muốn xóa khách hàng này?')) {
                // Implement delete logic
                console.log('Delete customer:', id);
            }
        }

        function sendMessage(id) {
            // Implement message functionality
            console.log('Send message to customer:', id);
        }

        function exportCustomers() {
            // Implement export functionality
            console.log('Export customers');
        }

        function refreshData() {
            window.location.reload();
        }

        // Add event listeners
        document.addEventListener('change', function(e) {
            if (e.target.classList.contains('customer-checkbox')) {
                updateDeleteButton();
            }
        });
    </script>

    <style>
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform 0.2s ease;
        }

        .stat-card:hover {
            transform: translateY(-2px);
        }

        .stat-card.primary {
            border-left: 4px solid #667eea;
        }

        .stat-card.success {
            border-left: 4px solid #28a745;
        }

        .stat-card.warning {
            border-left: 4px solid #ffc107;
        }

        .stat-card.info {
            border-left: 4px solid #17a2b8;
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            color: white;
        }

        .stat-card.primary .stat-icon {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .stat-card.success .stat-icon {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
        }

        .stat-card.warning .stat-icon {
            background: linear-gradient(135deg, #ffc107 0%, #fd7e14 100%);
        }

        .stat-card.info .stat-icon {
            background: linear-gradient(135deg, #17a2b8 0%, #6f42c1 100%);
        }

        .stat-content h3 {
            margin: 0;
            font-size: 2rem;
            font-weight: bold;
            color: #2c3e50;
        }

        .stat-content p {
            margin: 0;
            color: #6c757d;
            font-size: 0.9rem;
        }

        .customer-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .customer-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .customer-details {
            display: flex;
            flex-direction: column;
        }

        .customer-name {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.25rem;
        }

        .customer-id {
            font-size: 0.8rem;
            color: #6c757d;
        }

        .email-container,
        .phone-container,
        .address-container,
        .date-container {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .text-muted {
            color: #6c757d !important;
        }

        .order-stats {
            text-align: center;
        }

        .order-count {
            display: block;
            font-size: 1.2rem;
            font-weight: bold;
            color: #667eea;
        }

        .order-label {
            font-size: 0.8rem;
            color: #6c757d;
        }

        .status-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-active {
            background: rgba(40, 167, 69, 0.1);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.2);
        }

        .action-buttons {
            display: flex;
            gap: 0.5rem;
        }

        .btn-action {
            width: 32px;
            height: 32px;
            border: none;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s ease;
            font-size: 0.8rem;
        }

        .btn-view {
            background: rgba(23, 162, 184, 0.1);
            color: #17a2b8;
        }

        .btn-view:hover {
            background: #17a2b8;
            color: white;
        }

        .btn-edit {
            background: rgba(255, 193, 7, 0.1);
            color: #ffc107;
        }

        .btn-edit:hover {
            background: #ffc107;
            color: white;
        }

        .btn-message {
            background: rgba(102, 126, 234, 0.1);
            color: #667eea;
        }

        .btn-message:hover {
            background: #667eea;
            color: white;
        }

        .btn-delete {
            background: rgba(220, 53, 69, 0.1);
            color: #dc3545;
        }

        .btn-delete:hover {
            background: #dc3545;
            color: white;
        }

        .search-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 1rem;
        }

        .search-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .filter-label {
            font-weight: 600;
            color: #495057;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .table-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border-top: 1px solid #e9ecef;
            background: #f8f9fa;
        }

        .pagination-info {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .pagination-controls {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-pagination {
            padding: 0.5rem 1rem;
            border: 1px solid #dee2e6;
            background: white;
            color: #495057;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .btn-pagination:hover:not(:disabled) {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .btn-pagination:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .page-numbers {
            display: flex;
            gap: 0.25rem;
        }

        .page-number {
            width: 36px;
            height: 36px;
            border: 1px solid #dee2e6;
            background: white;
            color: #495057;
            border-radius: 6px;
            cursor: pointer;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
        }

        .page-number.active {
            background: #667eea;
            color: white;
            border-color: #667eea;
        }

        .page-number:hover:not(.active) {
            background: #f8f9fa;
        }
    </style>
</body>
</html>
