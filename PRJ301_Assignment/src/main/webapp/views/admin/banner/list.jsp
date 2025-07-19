<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Banner Management - Fashion Shop Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />

    <div class="container">
        <div class="card">
            <div class="card-header">
                <div style="display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 1rem;">
                    <div>
                        <h2 class="card-title gradient-text">
                            <i class="fas fa-images"></i> Banner Management
                        </h2>
                        <p style="margin: 0; color: #6c757d; font-size: 0.95rem;">
                            <i class="fas fa-info-circle"></i> 
                            Manage promotional banners across your website
                        </p>
                    </div>
                    <a href="${pageContext.request.contextPath}/admin/banners?action=add" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Add New Banner
                    </a>
                </div>
            </div>

            <!-- Search and Filter Section -->
            <div style="padding: 1.5rem; background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%); border-bottom: 1px solid #dee2e6;">
                <div class="row">
                    <div class="col">
                        <div class="form-group" style="margin-bottom: 0;">
                            <div style="display: flex; gap: 1rem; align-items: center; flex-wrap: wrap;">
                                <div style="flex: 1; min-width: 250px;">
                                    <input type="text" class="form-control" id="searchInput" placeholder="Search banners by title...">
                                </div>
                                <div style="min-width: 180px;">
                                    <select class="form-control form-select" id="positionFilter">
                                        <option value="">All Positions</option>
                                        <option value="homepage-top">Homepage - Top</option>
                                        <option value="homepage-middle">Homepage - Middle</option>
                                        <option value="homepage-bottom">Homepage - Bottom</option>
                                        <option value="category-top">Category - Top</option>
                                        <option value="product-sidebar">Product - Sidebar</option>
                                    </select>
                                </div>
                                <button type="button" class="btn btn-secondary" onclick="clearFilters()">
                                    <i class="fas fa-refresh"></i> Clear
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <c:choose>
                <c:when test="${not empty banners}">
                    <div style="overflow-x: auto;">
                        <table class="table" id="bannersTable">
                            <thead>
                                <tr>
                                    <th style="width: 80px;">
                                        <i class="fas fa-hashtag"></i> ID
                                    </th>
                                    <th style="width: 120px;">
                                        <i class="fas fa-image"></i> Preview
                                    </th>
                                    <th>
                                        <i class="fas fa-heading"></i> Title
                                    </th>
                                    <th style="width: 180px;">
                                        <i class="fas fa-map-marker-alt"></i> Position
                                    </th>
                                    <th style="width: 150px;">
                                        <i class="fas fa-link"></i> Image URL
                                    </th>
                                    <th style="width: 200px; text-align: center;">
                                        <i class="fas fa-cogs"></i> Actions
                                    </th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="banner" items="${banners}">
                                    <tr data-title="${banner.title}" data-position="${banner.position}">
                                        <td style="font-weight: 600; color: #495057;">
                                            #${banner.id}
                                        </td>
                                        <td>
                                            <div style="width: 80px; height: 50px; border-radius: 8px; overflow: hidden; border: 2px solid #e9ecef;">
                                                <img src="${banner.image}" 
                                                     alt="${banner.title}" 
                                                     style="width: 100%; height: 100%; object-fit: cover;"
                                                     onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iMyIgeT0iMyIgd2lkdGg9IjE4IiBoZWlnaHQ9IjE4IiByeD0iMiIgc3Ryb2tlPSIjOTk5IiBzdHJva2Utd2lkdGg9IjIiLz4KPGNpcmNsZSBjeD0iOC41IiBjeT0iOC41IiByPSIxLjUiIGZpbGw9IiM5OTkiLz4KPHBhdGggZD0ibTIxIDE1LTMuMDg2LTMuMDg2YTIgMiAwIDAgMC0yLjgyOCAwTDYgMjEiIHN0cm9rZT0iIzk5OSIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4KPC9zdmc+'"
                                                     title="Banner preview">
                                            </div>
                                        </td>
                                        <td>
                                            <div style="font-weight: 600; color: #495057; margin-bottom: 0.25rem;">
                                                ${banner.title}
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge badge-position badge-${banner.position}">
                                                <i class="fas fa-map-marker-alt"></i>
                                                <c:choose>
                                                    <c:when test="${banner.position == 'homepage-top'}">Homepage Top</c:when>
                                                    <c:when test="${banner.position == 'homepage-middle'}">Homepage Middle</c:when>
                                                    <c:when test="${banner.position == 'homepage-bottom'}">Homepage Bottom</c:when>
                                                    <c:when test="${banner.position == 'category-top'}">Category Top</c:when>
                                                    <c:when test="${banner.position == 'product-sidebar'}">Product Sidebar</c:when>
                                                    <c:otherwise>${banner.position}</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>
                                            <div style="max-width: 140px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; font-size: 0.875rem; color: #6c757d;">
                                                <a href="${banner.image}" target="_blank" title="${banner.image}" style="color: #667eea; text-decoration: none;">
                                                    <i class="fas fa-external-link-alt"></i> View Image
                                                </a>
                                            </div>
                                        </td>
                                        <td style="text-align: center;">
                                            <div class="btn-group" style="gap: 0.5rem;">
                                                <a href="${pageContext.request.contextPath}/admin/banners?action=edit&id=${banner.id}" 
                                                   class="btn btn-sm btn-success" 
                                                   title="Edit Banner">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <button type="button" 
                                                        class="btn btn-sm btn-danger" 
                                                        onclick="confirmDelete(${banner.id}, '${banner.title}')"
                                                        title="Delete Banner">
                                                    <i class="fas fa-trash"></i>
                                                </button>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 4rem 2rem;">
                        <div style="color: #6c757d;">
                            <i class="fas fa-images fa-4x mb-3" style="opacity: 0.3;"></i>
                            <h3>No Banners Found</h3>
                            <p style="margin-bottom: 2rem;">There are no banners to display at the moment.</p>
                            <a href="${pageContext.request.contextPath}/admin/banners?action=add" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Create Your First Banner
                            </a>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal" style="display: none;">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-exclamation-triangle" style="color: #dc3545;"></i> Confirm Delete</h3>
            </div>
            <div class="modal-body">
                <p>Are you sure you want to delete the banner "<strong id="deleteItemName"></strong>"?</p>
                <p style="color: #dc3545; font-size: 0.9rem;">
                    <i class="fas fa-warning"></i> This action cannot be undone.
                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">
                    <i class="fas fa-times"></i> Cancel
                </button>
                <a id="confirmDeleteBtn" href="#" class="btn btn-danger">
                    <i class="fas fa-trash"></i> Delete Banner
                </a>
            </div>
        </div>
    </div>

    <script>
        // Search functionality
        document.getElementById('searchInput').addEventListener('keyup', function() {
            filterTable();
        });

        // Position filter functionality
        document.getElementById('positionFilter').addEventListener('change', function() {
            filterTable();
        });

        function filterTable() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const positionFilter = document.getElementById('positionFilter').value;
            const rows = document.querySelectorAll('#bannersTable tbody tr');

            rows.forEach(row => {
                const title = row.getAttribute('data-title').toLowerCase();
                const position = row.getAttribute('data-position');

                const matchesSearch = title.includes(searchTerm);
                const matchesPosition = positionFilter === '' || position === positionFilter;

                if (matchesSearch && matchesPosition) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }

        function clearFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('positionFilter').value = '';
            filterTable();
        }

        // Delete confirmation
        function confirmDelete(id, title) {
            document.getElementById('deleteItemName').textContent = title;
            document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/admin/banners?action=delete&id=' + id;
            document.getElementById('deleteModal').style.display = 'flex';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target === modal) {
                closeDeleteModal();
            }
        }
    </script>

    <style>
        .btn-group {
            display: flex;
            align-items: center;
        }

        .btn-sm {
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            border-radius: 6px;
        }

        .badge-position {
            display: inline-block;
            padding: 0.375rem 0.75rem;
            font-size: 0.75rem;
            font-weight: 500;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            border-radius: 6px;
            color: white;
        }

        .badge-homepage-top { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
        .badge-homepage-middle { background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%); }
        .badge-homepage-bottom { background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%); }
        .badge-category-top { background: linear-gradient(135deg, #fa709a 0%, #fee140 100%); }
        .badge-product-sidebar { background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%); color: #495057; }

        .modal {
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .modal-content {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            max-width: 500px;
            width: 90%;
            animation: modalSlideIn 0.3s ease;
        }

        .modal-header {
            padding: 1.5rem;
            border-bottom: 1px solid #e9ecef;
        }

        .modal-header h3 {
            margin: 0;
            color: #495057;
        }

        .modal-body {
            padding: 1.5rem;
        }

        .modal-footer {
            padding: 1rem 1.5rem;
            border-top: 1px solid #e9ecef;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .card-header > div {
                flex-direction: column;
                align-items: stretch;
                text-align: center;
            }

            .table {
                font-size: 0.875rem;
            }

            .btn-group {
                flex-direction: column;
                gap: 0.25rem;
            }
        }
    </style>
</body>
</html>