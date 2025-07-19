
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${blog != null}">Chỉnh sửa Bài viết - Fashion Shop Admin</c:when>
            <c:otherwise>Thêm Bài viết mới - Fashion Shop Admin</c:otherwise>
        </c:choose>
    </title>
    <link href="<c:url value='/css/style.css'/>" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.ckeditor.com/ckeditor5/39.0.1/classic/ckeditor.js"></script>
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
                        <c:choose>
                            <c:when test="${blog != null}">Chỉnh sửa Bài viết</c:when>
                            <c:otherwise>Thêm Bài viết mới</c:otherwise>
                        </c:choose>
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <a href="<c:url value='/admin/blogs'/>">
                            <i class="fas fa-blog"></i> Quản lý Bài viết
                        </a>
                        <span class="separator">/</span>
                        <span>
                            <c:choose>
                                <c:when test="${blog != null}">Chỉnh sửa</c:when>
                                <c:otherwise>Thêm mới</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>

            <!-- Form Section -->
            <div class="form-section">
                <div class="form-card">
                    <div class="form-header">
                        <h3>
                            <i class="fas ${blog != null ? 'fa-edit' : 'fa-plus'}"></i>
                            Thông tin Bài viết
                        </h3>
                        <div class="form-actions">
                            <a href="<c:url value='/admin/blogs'/>" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i>
                                Quay lại
                            </a>
                        </div>
                    </div>
                    
                    <form method="post" action="${pageContext.request.contextPath}/admin/blogs" class="blog-form" id="blogForm">
                        <input type="hidden" name="id" value="${blog.id}" />
                        
                        <div class="form-grid">
                            <!-- Left Column -->
                            <div class="form-column">
                                <div class="form-group">
                                    <label for="title" class="form-label required">
                                        <i class="fas fa-heading"></i>
                                        Tiêu đề bài viết
                                    </label>
                                    <input type="text" 
                                           id="title" 
                                           name="title" 
                                           class="form-control" 
                                           value="${blog.title}" 
                                           placeholder="Nhập tiêu đề bài viết..."
                                           required 
                                           maxlength="200">
                                    <div class="form-help">
                                        <span class="char-count">
                                            <span id="titleCount">0</span>/200 ký tự
                                        </span>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="thumbnail" class="form-label">
                                        <i class="fas fa-image"></i>
                                        URL hình ảnh đại diện
                                    </label>
                                    <div class="image-input-group">
                                        <input type="url" 
                                               id="thumbnail" 
                                               name="thumbnail" 
                                               class="form-control" 
                                               value="${blog.thumbnail}" 
                                               placeholder="https://example.com/image.jpg"
                                               onchange="previewImage()">
                                        <button type="button" class="btn btn-outline" onclick="clearImage()">
                                            <i class="fas fa-times"></i>
                                        </button>
                                    </div>
                                    <div class="form-help">
                                        Nhập URL hình ảnh hoặc để trống nếu không có
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-eye"></i>
                                        Xem trước hình ảnh
                                    </label>
                                    <div class="image-preview-container">
                                        <div id="imagePreview" class="image-preview">
                                            <c:choose>
                                                <c:when test="${not empty blog.thumbnail}">
                                                    <img src="${blog.thumbnail}" alt="Preview" id="previewImg">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="no-image">
                                                        <i class="fas fa-image"></i>
                                                        <span>Chưa có hình ảnh</span>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="excerpt" class="form-label">
                                        <i class="fas fa-quote-left"></i>
                                        Tóm tắt bài viết
                                    </label>
                                    <textarea id="excerpt" 
                                              name="excerpt" 
                                              class="form-control" 
                                              rows="4" 
                                              placeholder="Nhập tóm tắt ngắn gọn về bài viết..."
                                              maxlength="300">${blog.excerpt}</textarea>
                                    <div class="form-help">
                                        <span class="char-count">
                                            <span id="excerptCount">0</span>/300 ký tự
                                        </span>
                                    </div>
                                </div>
                            </div>

                            <!-- Right Column -->
                            <div class="form-column">
                                <div class="form-group">
                                    <label for="content" class="form-label required">
                                        <i class="fas fa-file-alt"></i>
                                        Nội dung bài viết
                                    </label>
                                    <textarea id="content" 
                                              name="content" 
                                              class="form-control rich-editor" 
                                              rows="20" 
                                              required>${blog.content}</textarea>
                                    <div class="form-help">
                                        Sử dụng trình soạn thảo để định dạng nội dung
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="tags" class="form-label">
                                        <i class="fas fa-tags"></i>
                                        Thẻ (Tags)
                                    </label>
                                    <input type="text" 
                                           id="tags" 
                                           name="tags" 
                                           class="form-control" 
                                           value="${blog.tags}" 
                                           placeholder="Nhập các thẻ cách nhau bởi dấu phẩy...">
                                    <div class="form-help">
                                        Ví dụ: thời trang, xu hướng, mùa hè
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="status" class="form-label">
                                        <i class="fas fa-toggle-on"></i>
                                        Trạng thái
                                    </label>
                                    <select id="status" name="status" class="form-control">
                                        <option value="draft" ${blog.status == 'draft' ? 'selected' : ''}>
                                            <i class="fas fa-edit"></i> Bản nháp
                                        </option>
                                        <option value="published" ${blog.status == 'published' ? 'selected' : ''}>
                                            <i class="fas fa-check"></i> Đã xuất bản
                                        </option>
                                        <option value="archived" ${blog.status == 'archived' ? 'selected' : ''}>
                                            <i class="fas fa-archive"></i> Lưu trữ
                                        </option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label for="publishDate" class="form-label">
                                        <i class="fas fa-calendar-alt"></i>
                                        Ngày xuất bản
                                    </label>
                                    <input type="datetime-local" 
                                           id="publishDate" 
                                           name="publishDate" 
                                           class="form-control" 
                                           value="<fmt:formatDate value='${blog.publishDate}' pattern='yyyy-MM-dd HH:mm'/>">
                                    <div class="form-help">
                                        Để trống để xuất bản ngay lập tức
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form Footer -->
                        <div class="form-footer">
                            <div class="form-actions-bottom">
                                <button type="button" class="btn btn-secondary" onclick="history.back()">
                                    <i class="fas fa-times"></i>
                                    Hủy bỏ
                                </button>
                                
                                <c:if test="${blog != null}">
                                    <button type="button" class="btn btn-info" onclick="previewBlog()">
                                        <i class="fas fa-eye"></i>
                                        Xem trước
                                    </button>
                                </c:if>
                                
                                <button type="submit" name="action" value="save_draft" class="btn btn-warning">
                                    <i class="fas fa-save"></i>
                                    Lưu nháp
                                </button>
                                
                                <button type="submit" name="action" value="publish" class="btn btn-success">
                                    <i class="fas fa-paper-plane"></i>
                                    <c:choose>
                                        <c:when test="${blog != null}">Cập nhật</c:when>
                                        <c:otherwise>Xuất bản</c:otherwise>
                                    </c:choose>
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        let editor;
        
        // Initialize CKEditor
        ClassicEditor
            .create(document.querySelector('#content'), {
                toolbar: [
                    'heading', '|',
                    'bold', 'italic', 'link', '|',
                    'bulletedList', 'numberedList', '|',
                    'blockQuote', 'insertTable', '|',
                    'undo', 'redo'
                ]
            })
            .then(newEditor => {
                editor = newEditor;
            })
            .catch(error => {
                console.error('Error initializing editor:', error);
            });

        // Character counting
        function updateCharCount(inputId, countId, maxLength) {
            const input = document.getElementById(inputId);
            const counter = document.getElementById(countId);
            
            input.addEventListener('input', function() {
                const currentLength = this.value.length;
                counter.textContent = currentLength;
                
                if (currentLength > maxLength * 0.9) {
                    counter.style.color = '#e74c3c';
                } else if (currentLength > maxLength * 0.7) {
                    counter.style.color = '#f39c12';
                } else {
                    counter.style.color = '#27ae60';
                }
            });
            
            // Initialize count
            counter.textContent = input.value.length;
        }

        // Image preview
        function previewImage() {
            const url = document.getElementById('thumbnail').value;
            const preview = document.getElementById('imagePreview');
            
            if (url && isValidImageUrl(url)) {
                preview.innerHTML = `<img src="${url}" alt="Preview" id="previewImg" onload="imageLoaded()" onerror="imageError()">`;
            } else {
                showNoImage();
            }
        }

        function isValidImageUrl(url) {
            return /\.(jpg|jpeg|png|gif|webp|svg)(\?.*)?$/i.test(url) || url.includes('base64');
        }

        function imageLoaded() {
            document.getElementById('previewImg').style.display = 'block';
        }

        function imageError() {
            showNoImage();
        }

        function showNoImage() {
            document.getElementById('imagePreview').innerHTML = `
                <div class="no-image">
                    <i class="fas fa-exclamation-triangle"></i>
                    <span>Không thể tải hình ảnh</span>
                </div>
            `;
        }

        function clearImage() {
            document.getElementById('thumbnail').value = '';
            showNoImage();
        }

        function previewBlog() {
            // Implementation for blog preview
            alert('Chức năng xem trước sẽ được triển khai.');
        }

        // Form validation
        function validateForm() {
            const title = document.getElementById('title').value.trim();
            const content = editor.getData().trim();
            
            if (!title) {
                alert('Vui lòng nhập tiêu đề bài viết!');
                document.getElementById('title').focus();
                return false;
            }
            
            if (!content || content === '<p>&nbsp;</p>') {
                alert('Vui lòng nhập nội dung bài viết!');
                editor.editing.view.focus();
                return false;
            }
            
            return true;
        }

        // Auto-save functionality
        let autoSaveTimer;
        function enableAutoSave() {
            clearTimeout(autoSaveTimer);
            autoSaveTimer = setTimeout(() => {
                if (validateForm()) {
                    // Auto-save implementation
                    console.log('Auto-saving...');
                }
            }, 30000); // Auto-save every 30 seconds
        }

        // Initialize on document ready
        document.addEventListener('DOMContentLoaded', function() {
            // Initialize character counting
            updateCharCount('title', 'titleCount', 200);
            updateCharCount('excerpt', 'excerptCount', 300);
            
            // Initialize image preview if thumbnail exists
            if (document.getElementById('thumbnail').value) {
                previewImage();
            }
            
            // Add form validation
            document.getElementById('blogForm').addEventListener('submit', function(e) {
                if (!validateForm()) {
                    e.preventDefault();
                    return false;
                }
            });
            
            // Enable auto-save
            document.getElementById('title').addEventListener('input', enableAutoSave);
            if (editor) {
                editor.model.document.on('change:data', enableAutoSave);
            }
        });
    </script>
</body>
</html>
