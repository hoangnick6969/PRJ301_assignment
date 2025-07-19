<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📨 Danh sách liên hệ từ người dùng</h2>

<table border="1" cellspacing="0" cellpadding="8" width="100%">
    <tr>
        <th>ID</th>
        <th>Họ tên</th>
        <th>Email</th>
        <th>Nội dung</th>
        <th>Thời gian</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="m" items="${contactList}">
        <tr>
            <td>${m.id}</td>
            <td>${m.name}</td>
            <td>${m.email}</td>
            <td>${m.message}</td>
            <td>${m.createdAt}</td>
            <td>
                <a href="contacts?action=delete&id=${m.id}" onclick="return confirm('Xoá tin nhắn này?')">🗑 Xoá</a>
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
    <title>Quản lý tin nhắn liên hệ - Fashion Shop Admin</title>
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
                        <i class="fas fa-envelope"></i>
                        📨 Quản lý tin nhắn liên hệ
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <span>Tin nhắn liên hệ</span>
                    </div>
                </div>
                
                <div class="header-actions">
                    <div class="search-box">
                        <input type="text" id="searchInput" placeholder="Tìm kiếm tin nhắn..." class="search-input">
                        <i class="fas fa-search search-icon"></i>
                    </div>
                    <div class="filter-dropdown">
                        <select id="statusFilter" class="filter-select">
                            <option value="">Tất cả trạng thái</option>
                            <option value="new">Tin nhắn mới</option>
                            <option value="read">Đã đọc</option>
                            <option value="replied">Đã trả lời</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(45deg, #3498db, #2ecc71);">
                        <i class="fas fa-envelope"></i>
                    </div>
                    <div class="stat-content">
                        <h3>${messages.size()}</h3>
                        <p>Tổng tin nhắn</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(45deg, #e74c3c, #f39c12);">
                        <i class="fas fa-exclamation-circle"></i>
                    </div>
                    <div class="stat-content">
                        <h3 id="newMessagesCount">0</h3>
                        <p>Tin nhắn mới</p>
                    </div>
                </div>
                
                <div class="stat-card">
                    <div class="stat-icon" style="background: linear-gradient(45deg, #9b59b6, #8e44ad);">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-content">
                        <h3>Hôm nay</h3>
                        <p>Tin nhắn gần đây</p>
                    </div>
                </div>
            </div>

            <!-- Messages Table -->
            <div class="table-section">
                <div class="table-card">
                    <div class="table-header">
                        <h3>
                            <i class="fas fa-list"></i>
                            Danh sách tin nhắn liên hệ
                        </h3>
                        <div class="table-actions">
                            <button class="btn btn-outline" onclick="markAllAsRead()">
                                <i class="fas fa-check-double"></i>
                                Đánh dấu đã đọc tất cả
                            </button>
                            <button class="btn btn-danger" onclick="deleteSelected()">
                                <i class="fas fa-trash"></i>
                                Xóa đã chọn
                            </button>
                        </div>
                    </div>
                    
                    <div class="table-responsive">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th width="40">
                                        <input type="checkbox" id="selectAll" onchange="toggleSelectAll()">
                                    </th>
                                    <th width="60">Trạng thái</th>
                                    <th width="200">Thông tin liên hệ</th>
                                    <th width="250">Tiêu đề</th>
                                    <th>Nội dung</th>
                                    <th width="120">Thời gian</th>
                                    <th width="120">Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="message" items="${messages}">
                                    <tr class="message-row ${message.isRead ? 'read' : 'unread'}" data-id="${message.id}">
                                        <td>
                                            <input type="checkbox" class="message-checkbox" value="${message.id}">
                                        </td>
                                        <td>
                                            <span class="status-badge ${message.isRead ? 'read' : 'new'}">
                                                <i class="fas ${message.isRead ? 'fa-envelope-open' : 'fa-envelope'}"></i>
                                                ${message.isRead ? 'Đã đọc' : 'Mới'}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="contact-info">
                                                <div class="contact-name">
                                                    <i class="fas fa-user"></i>
                                                    <strong>${message.name}</strong>
                                                </div>
                                                <div class="contact-email">
                                                    <i class="fas fa-envelope"></i>
                                                    <a href="mailto:${message.email}">${message.email}</a>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="message-subject">
                                                <strong>${message.subject}</strong>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="message-preview">
                                                ${message.message.length() > 100 ? message.message.substring(0, 100) + '...' : message.message}
                                            </div>
                                        </td>
                                        <td>
                                            <div class="message-time">
                                                <i class="fas fa-clock"></i>
                                                <fmt:formatDate value="${message.sentAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </div>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <button class="btn-icon btn-primary" 
                                                        onclick="viewMessage('${message.id}')" 
                                                        title="Xem chi tiết">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <button class="btn-icon btn-success" 
                                                        onclick="replyMessage('${message.email}', '${message.subject}')" 
                                                        title="Trả lời">
                                                    <i class="fas fa-reply"></i>
                                                </button>
                                                <button class="btn-icon btn-danger" 
                                                        onclick="deleteMessage('${message.id}')" 
                                                        title="Xóa">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty messages}">
                                    <tr>
                                        <td colspan="7" class="empty-state">
                                            <div class="empty-content">
                                                <i class="fas fa-inbox"></i>
                                                <h3>Chưa có tin nhắn nào</h3>
                                                <p>Hiện tại chưa có tin nhắn liên hệ nào từ khách hàng.</p>
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

        <!-- Message Detail Modal -->
        <div id="messageModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h3><i class="fas fa-envelope-open"></i> Chi tiết tin nhắn</h3>
                    <button class="close-btn" onclick="closeModal()">&times;</button>
                </div>
                <div class="modal-body" id="messageModalBody">
                    <!-- Message details will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button class="btn btn-primary" onclick="replyFromModal()">
                        <i class="fas fa-reply"></i> Trả lời
                    </button>
                    <button class="btn btn-secondary" onclick="closeModal()">
                        <i class="fas fa-times"></i> Đóng
                    </button>
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
            const rows = document.querySelectorAll('.message-row');
            
            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(searchTerm) ? '' : 'none';
            });
        });

        // Status filter
        document.getElementById('statusFilter').addEventListener('change', function() {
            const filterValue = this.value;
            const rows = document.querySelectorAll('.message-row');
            
            rows.forEach(row => {
                if (!filterValue) {
                    row.style.display = '';
                } else if (filterValue === 'new' && row.classList.contains('unread')) {
                    row.style.display = '';
                } else if (filterValue === 'read' && row.classList.contains('read')) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });

        // Select all functionality
        function toggleSelectAll() {
            const selectAll = document.getElementById('selectAll');
            const checkboxes = document.querySelectorAll('.message-checkbox');
            
            checkboxes.forEach(checkbox => {
                checkbox.checked = selectAll.checked;
            });
        }

        // View message details
        function viewMessage(messageId) {
            // In a real application, you would fetch message details via AJAX
            document.getElementById('messageModal').style.display = 'block';
        }

        // Reply to message
        function replyMessage(email, subject) {
            const replySubject = 'Re: ' + subject;
            const mailtoLink = `mailto:${email}?subject=${encodeURIComponent(replySubject)}`;
            window.open(mailtoLink);
        }

        // Delete message
        function deleteMessage(messageId) {
            if (confirm('Bạn có chắc chắn muốn xóa tin nhắn này?')) {
                // In a real application, you would send a delete request
                location.reload();
            }
        }

        // Mark all as read
        function markAllAsRead() {
            if (confirm('Đánh dấu tất cả tin nhắn là đã đọc?')) {
                // In a real application, you would send an update request
                location.reload();
            }
        }

        // Delete selected messages
        function deleteSelected() {
            const selected = document.querySelectorAll('.message-checkbox:checked');
            if (selected.length === 0) {
                alert('Vui lòng chọn ít nhất một tin nhắn để xóa.');
                return;
            }
            
            if (confirm(`Bạn có chắc chắn muốn xóa ${selected.length} tin nhắn đã chọn?`)) {
                // In a real application, you would send delete requests
                location.reload();
            }
        }

        // Modal functions
        function closeModal() {
            document.getElementById('messageModal').style.display = 'none';
        }

        function replyFromModal() {
            // Get current message details and reply
            closeModal();
        }

        // Count new messages
        document.addEventListener('DOMContentLoaded', function() {
            const newMessages = document.querySelectorAll('.message-row.unread');
            document.getElementById('newMessagesCount').textContent = newMessages.length;
        });

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('messageModal');
            if (event.target === modal) {
                modal.style.display = 'none';
            }
        }
    </script>
</body>
</html>
