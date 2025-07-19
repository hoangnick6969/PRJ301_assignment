
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${banner != null ? 'Chỉnh sửa Banner' : 'Thêm Banner mới'} - Fashion Shop Admin</title>
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
                        ${banner != null ? 'Chỉnh sửa Banner' : 'Thêm Banner mới'}
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <a href="<c:url value='/admin/banners'/>">Quản lý Banner</a>
                        <span class="separator">/</span>
                        <span>${banner != null ? 'Chỉnh sửa' : 'Thêm mới'}</span>
                    </div>
                </div>
            </div>

            <div class="form-container">
                <div class="form-card">
                    <div class="form-header">
                        <h2>
                            <i class="fas fa-edit"></i>
                            Thông tin Banner
                        </h2>
                    </div>
                    
                    <form action="<c:url value='/admin/banners'/>" method="post" class="admin-form">
                        <c:if test="${banner != null}">
                            <input type="hidden" name="id" value="${banner.id}">
                        </c:if>
                        
                        <div class="form-group">
                            <label for="title" class="form-label">
                                <i class="fas fa-heading"></i>
                                Tiêu đề Banner <span class="required">*</span>
                            </label>
                            <input type="text" 
                                   id="title" 
                                   name="title" 
                                   class="form-control" 
                                   value="${banner != null ? banner.title : ''}" 
                                   placeholder="Nhập tiêu đề banner"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="description" class="form-label">
                                <i class="fas fa-align-left"></i>
                                Mô tả
                            </label>
                            <textarea id="description" 
                                      name="description" 
                                      class="form-control textarea" 
                                      rows="3" 
                                      placeholder="Nhập mô tả banner">${banner != null ? banner.description : ''}</textarea>
                        </div>

                        <div class="form-group">
                            <label for="imageUrl" class="form-label">
                                <i class="fas fa-image"></i>
                                URL Hình ảnh <span class="required">*</span>
                            </label>
                            <input type="url" 
                                   id="imageUrl" 
                                   name="imageUrl" 
                                   class="form-control" 
                                   value="${banner != null ? banner.imageUrl : ''}" 
                                   placeholder="https://example.com/image.jpg"
                                   required>
                        </div>

                        <div class="form-group">
                            <label for="linkUrl" class="form-label">
                                <i class="fas fa-link"></i>
                                URL Liên kết
                            </label>
                            <input type="url" 
                                   id="linkUrl" 
                                   name="linkUrl" 
                                   class="form-control" 
                                   value="${banner != null ? banner.linkUrl : ''}" 
                                   placeholder="https://example.com">
                        </div>

                        <div class="form-group">
                            <label for="position" class="form-label">
                                <i class="fas fa-map-marker-alt"></i>
                                Vị trí hiển thị <span class="required">*</span>
                            </label>
                            <select id="position" name="position" class="form-control" required>
                                <option value="">-- Chọn vị trí --</option>
                                <option value="homepage-top" ${banner != null && banner.position == 'homepage-top' ? 'selected' : ''}>
                                    Trang chủ - Top
                                </option>
                                <option value="homepage-middle" ${banner != null && banner.position == 'homepage-middle' ? 'selected' : ''}>
                                    Trang chủ - Giữa
                                </option>
                                <option value="homepage-bottom" ${banner != null && banner.position == 'homepage-bottom' ? 'selected' : ''}>
                                    Trang chủ - Cuối
                                </option>
                                <option value="product-page" ${banner != null && banner.position == 'product-page' ? 'selected' : ''}>
                                    Trang sản phẩm
                                </option>
                            </select>
                        </div>

                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="sortOrder" class="form-label">
                                    <i class="fas fa-sort-numeric-up"></i>
                                    Thứ tự hiển thị
                                </label>
                                <input type="number" 
                                       id="sortOrder" 
                                       name="sortOrder" 
                                       class="form-control" 
                                       value="${banner != null ? banner.sortOrder : 0}" 
                                       min="0" 
                                       placeholder="0">
                            </div>
                            
                            <div class="form-group col-md-6">
                                <label for="isActive" class="form-label">
                                    <i class="fas fa-toggle-on"></i>
                                    Trạng thái
                                </label>
                                <select id="isActive" name="isActive" class="form-control">
                                    <option value="true" ${banner == null || banner.active ? 'selected' : ''}>
                                        Hoạt động
                                    </option>
                                    <option value="false" ${banner != null && !banner.active ? 'selected' : ''}>
                                        Tạm dừng
                                    </option>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                ${banner != null ? 'Cập nhật Banner' : 'Thêm Banner'}
                            </button>
                            <a href="<c:url value='/admin/banners'/>" class="btn btn-secondary">
                                <i class="fas fa-times"></i>
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>

                <!-- Preview Card -->
                <c:if test="${banner != null && banner.imageUrl != null}">
                    <div class="preview-card">
                        <div class="form-header">
                            <h2>
                                <i class="fas fa-eye"></i>
                                Xem trước Banner
                            </h2>
                        </div>
                        <div class="banner-preview">
                            <img src="${banner.imageUrl}" 
                                 alt="${banner.title}" 
                                 class="preview-image"
                                 onerror="this.src='<c:url value="/images/placeholder.jpg"/>'">
                            <div class="preview-info">
                                <h4>${banner.title}</h4>
                                <c:if test="${banner.description != null}">
                                    <p>${banner.description}</p>
                                </c:if>
                                <div class="preview-meta">
                                    <span class="badge badge-info">${banner.position}</span>
                                    <span class="badge ${banner.active ? 'badge-success' : 'badge-danger'}">
                                        ${banner.active ? 'Hoạt động' : 'Tạm dừng'}
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        // Real-time preview update
        document.getElementById('imageUrl').addEventListener('input', function() {
            const previewImg = document.querySelector('.preview-image');
            if (previewImg) {
                previewImg.src = this.value || '<c:url value="/images/placeholder.jpg"/>';
            }
        });

        document.getElementById('title').addEventListener('input', function() {
            const previewTitle = document.querySelector('.preview-info h4');
            if (previewTitle) {
                previewTitle.textContent = this.value;
            }
        });

        document.getElementById('description').addEventListener('input', function() {
            const previewDesc = document.querySelector('.preview-info p');
            if (previewDesc) {
                previewDesc.textContent = this.value;
            }
        });

        // Form validation
        document.querySelector('.admin-form').addEventListener('submit', function(e) {
            const title = document.getElementById('title').value.trim();
            const imageUrl = document.getElementById('imageUrl').value.trim();
            const position = document.getElementById('position').value;

            if (!title) {
                e.preventDefault();
                alert('Vui lòng nhập tiêu đề banner!');
                document.getElementById('title').focus();
                return;
            }

            if (!imageUrl) {
                e.preventDefault();
                alert('Vui lòng nhập URL hình ảnh!');
                document.getElementById('imageUrl').focus();
                return;
            }

            if (!position) {
                e.preventDefault();
                alert('Vui lòng chọn vị trí hiển thị!');
                document.getElementById('position').focus();
                return;
            }
        });
    </script>
</body>
</html>
