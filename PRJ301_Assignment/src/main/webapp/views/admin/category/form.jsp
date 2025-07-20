
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${category != null}">Cập nhật danh mục</c:when>
            <c:otherwise>Thêm danh mục mới</c:otherwise>
        </c:choose> - Fashion Shop Admin
    </title>
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
                        <c:choose>
                            <c:when test="${category != null}">✏️ Cập nhật danh mục</c:when>
                            <c:otherwise>➕ Thêm danh mục mới</c:otherwise>
                        </c:choose>
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <a href="<c:url value='/admin/categories'/>">
                            <i class="fas fa-tags"></i> Quản lý danh mục
                        </a>
                        <span class="separator">/</span>
                        <span>
                            <c:choose>
                                <c:when test="${category != null}">Cập nhật</c:when>
                                <c:otherwise>Thêm mới</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
                
                <div class="header-actions">
                    <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại danh sách
                    </a>
                </div>
            </div>

            <!-- Form Section -->
            <div class="form-section">
                <div class="form-card">
                    <div class="form-header">
                        <h3>
                            <i class="fas fa-edit"></i>
                            Thông tin danh mục
                        </h3>
                        <div class="form-description">
                            Điền đầy đủ thông tin bên dưới để 
                            <c:choose>
                                <c:when test="${category != null}">cập nhật</c:when>
                                <c:otherwise>tạo</c:otherwise>
                            </c:choose> 
                            danh mục.
                        </div>
                    </div>
                    
                    <form method="post" action="${pageContext.request.contextPath}/admin/categories" class="admin-form">
                        <input type="hidden" name="id" value="${category.id}" />
                        
                        <div class="form-grid">
                            <div class="form-group full-width">
                                <label for="categoryName" class="form-label required">
                                    <i class="fas fa-tag"></i>
                                    Tên danh mục
                                </label>
                                <input type="text" 
                                       id="categoryName"
                                       name="name" 
                                       value="${category.name}" 
                                       class="form-control"
                                       placeholder="Nhập tên danh mục..."
                                       required />
                                <div class="form-help">
                                    Tên danh mục sẽ hiển thị trên trang web và được sử dụng để phân loại sản phẩm.
                                </div>
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="categoryDescription" class="form-label">
                                    <i class="fas fa-align-left"></i>
                                    Mô tả danh mục
                                </label>
                                <textarea id="categoryDescription"
                                          name="description"
                                          class="form-control"
                                          rows="4"
                                          placeholder="Nhập mô tả chi tiết về danh mục...">${category.description}</textarea>
                                <div class="form-help">
                                    Mô tả ngắn gọn về danh mục này để khách hàng hiểu rõ hơn.
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="categorySlug" class="form-label">
                                    <i class="fas fa-link"></i>
                                    Slug URL
                                </label>
                                <input type="text" 
                                       id="categorySlug"
                                       name="slug" 
                                       value="${category.slug}" 
                                       class="form-control"
                                       placeholder="danh-muc-url-friendly" />
                                <div class="form-help">
                                    URL thân thiện cho danh mục. Để trống để tự động tạo từ tên.
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="categoryStatus" class="form-label">
                                    <i class="fas fa-toggle-on"></i>
                                    Trạng thái
                                </label>
                                <select id="categoryStatus" name="active" class="form-control">
                                    <option value="true" ${category.active ? 'selected' : ''}>
                                        <i class="fas fa-check"></i> Hoạt động
                                    </option>
                                    <option value="false" ${!category.active ? 'selected' : ''}>
                                        <i class="fas fa-pause"></i> Tạm dừng
                                    </option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="categorySortOrder" class="form-label">
                                    <i class="fas fa-sort-numeric-up"></i>
                                    Thứ tự hiển thị
                                </label>
                                <input type="number" 
                                       id="categorySortOrder"
                                       name="sortOrder" 
                                       value="${category.sortOrder != null ? category.sortOrder : 0}" 
                                       class="form-control"
                                       min="0"
                                       placeholder="0" />
                                <div class="form-help">
                                    Số thứ tự hiển thị danh mục (nhỏ hơn sẽ hiển thị trước).
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="categoryIcon" class="form-label">
                                    <i class="fas fa-icons"></i>
                                    Icon danh mục
                                </label>
                                <input type="text" 
                                       id="categoryIcon"
                                       name="icon" 
                                       value="${category.icon}" 
                                       class="form-control"
                                       placeholder="fas fa-tshirt" />
                                <div class="form-help">
                                    Icon FontAwesome cho danh mục (ví dụ: fas fa-tshirt).
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                <c:choose>
                                    <c:when test="${category != null}">Cập nhật danh mục</c:when>
                                    <c:otherwise>Tạo danh mục mới</c:otherwise>
                                </c:choose>
                            </button>
                            <a href="<c:url value='/admin/categories'/>" class="btn btn-secondary">
                                <i class="fas fa-times"></i>
                                Hủy bỏ
                            </a>
                            <button type="reset" class="btn btn-outline">
                                <i class="fas fa-undo"></i>
                                Đặt lại
                            </button>
                        </div>
                    </form>
                </div>
            </div>
            
            <!-- Preview Section -->
            <c:if test="${category != null}">
                <div class="preview-section">
                    <div class="preview-card">
                        <div class="preview-header">
                            <h3>
                                <i class="fas fa-eye"></i>
                                Xem trước danh mục
                            </h3>
                        </div>
                        <div class="preview-content">
                            <div class="category-preview">
                                <div class="category-icon">
                                    <i class="${not empty category.icon ? category.icon : 'fas fa-folder'}"></i>
                                </div>
                                <div class="category-info">
                                    <h4>${not empty category.name ? category.name : 'Tên danh mục'}</h4>
                                    <p>${not empty category.description ? category.description : 'Mô tả danh mục sẽ hiển thị ở đây...'}</p>
                                    <span class="category-status ${category.active ? 'active' : 'inactive'}">
                                        <i class="fas ${category.active ? 'fa-check-circle' : 'fa-pause-circle'}"></i>
                                        ${category.active ? 'Hoạt động' : 'Tạm dừng'}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        // Auto-generate slug from name
        document.getElementById('categoryName').addEventListener('input', function() {
            const name = this.value;
            const slug = name.toLowerCase()
                            .replace(/[^a-z0-9\s-]/g, '')
                            .replace(/\s+/g, '-')
                            .replace(/-+/g, '-')
                            .trim();
            document.getElementById('categorySlug').value = slug;
        });
        
        // Form validation
        document.querySelector('.admin-form').addEventListener('submit', function(e) {
            const name = document.getElementById('categoryName').value.trim();
            
            if (!name) {
                e.preventDefault();
                alert('Vui lòng nhập tên danh mục!');
                document.getElementById('categoryName').focus();
                return false;
            }
            
            if (name.length < 2) {
                e.preventDefault();
                alert('Tên danh mục phải có ít nhất 2 ký tự!');
                document.getElementById('categoryName').focus();
                return false;
            }
        });
        
        // Reset form
        document.querySelector('button[type="reset"]').addEventListener('click', function(e) {
            if (!confirm('Bạn có chắc chắn muốn đặt lại toàn bộ form?')) {
                e.preventDefault();
            }
        });
    </script>
</body>
</html>
