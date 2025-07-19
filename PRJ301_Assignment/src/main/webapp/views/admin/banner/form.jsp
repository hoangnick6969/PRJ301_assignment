
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${banner != null ? 'Edit' : 'Add'} Banner - Fashion Shop Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <jsp:include page="../common/header.jsp" />
    
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-header">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <h2 class="card-title gradient-text">
                                <i class="fas fa-image"></i>
                                ${banner != null ? 'Edit Banner' : 'Add New Banner'}
                            </h2>
                            <a href="${pageContext.request.contextPath}/admin/banners" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Back to List
                            </a>
                        </div>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/admin/banners" class="needs-validation" novalidate>
                        <c:if test="${banner != null}">
                            <input type="hidden" name="id" value="${banner.id}">
                        </c:if>
                        
                        <div class="row">
                            <div class="col" style="flex: 2;">
                                <div class="form-group">
                                    <label for="title" class="form-label">
                                        <i class="fas fa-heading"></i> Banner Title *
                                    </label>
                                    <input type="text" 
                                           class="form-control" 
                                           id="title" 
                                           name="title" 
                                           value="${banner != null ? banner.title : ''}" 
                                           required 
                                           placeholder="Enter banner title">
                                    <div class="invalid-feedback">
                                        Please provide a valid banner title.
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="image" class="form-label">
                                        <i class="fas fa-image"></i> Image URL *
                                    </label>
                                    <input type="url" 
                                           class="form-control" 
                                           id="image" 
                                           name="image" 
                                           value="${banner != null ? banner.image : ''}" 
                                           required 
                                           placeholder="https://example.com/banner-image.jpg">
                                    <div class="invalid-feedback">
                                        Please provide a valid image URL.
                                    </div>
                                    <small class="form-text text-muted">
                                        <i class="fas fa-info-circle"></i> 
                                        Recommended size: 1200x400px for best results
                                    </small>
                                </div>

                                <div class="form-group">
                                    <label for="position" class="form-label">
                                        <i class="fas fa-map-marker-alt"></i> Position *
                                    </label>
                                    <select class="form-control form-select" id="position" name="position" required>
                                        <option value="">Choose banner position...</option>
                                        <option value="homepage-top" ${banner != null && banner.position == 'homepage-top' ? 'selected' : ''}>
                                            Homepage - Top
                                        </option>
                                        <option value="homepage-middle" ${banner != null && banner.position == 'homepage-middle' ? 'selected' : ''}>
                                            Homepage - Middle
                                        </option>
                                        <option value="homepage-bottom" ${banner != null && banner.position == 'homepage-bottom' ? 'selected' : ''}>
                                            Homepage - Bottom
                                        </option>
                                        <option value="category-top" ${banner != null && banner.position == 'category-top' ? 'selected' : ''}>
                                            Category - Top
                                        </option>
                                        <option value="product-sidebar" ${banner != null && banner.position == 'product-sidebar' ? 'selected' : ''}>
                                            Product - Sidebar
                                        </option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Please select a banner position.
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col" style="flex: 1;">
                                <div class="card" style="background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);">
                                    <div class="card-header">
                                        <h5 class="card-title">
                                            <i class="fas fa-eye"></i> Preview
                                        </h5>
                                    </div>
                                    <div style="padding: 1rem;">
                                        <div id="imagePreview" style="text-align: center; min-height: 200px; display: flex; align-items: center; justify-content: center; background: #f8f9fa; border: 2px dashed #dee2e6; border-radius: 8px;">
                                            <c:choose>
                                                <c:when test="${banner != null && banner.image != null && banner.image != ''}">
                                                    <img src="${banner.image}" alt="Banner Preview" style="max-width: 100%; max-height: 200px; border-radius: 6px;">
                                                </c:when>
                                                <c:otherwise>
                                                    <div style="color: #6c757d;">
                                                        <i class="fas fa-image fa-3x mb-2"></i>
                                                        <p>Image preview will appear here</p>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="mt-3">
                                            <strong>Position:</strong> 
                                            <span id="positionPreview" class="badge badge-info">
                                                ${banner != null ? banner.position : 'Not selected'}
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group" style="border-top: 2px solid #e9ecef; padding-top: 2rem; margin-top: 2rem;">
                            <div style="display: flex; gap: 1rem; justify-content: flex-end;">
                                <a href="${pageContext.request.contextPath}/admin/banners" class="btn btn-secondary">
                                    <i class="fas fa-times"></i> Cancel
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    ${banner != null ? 'Update Banner' : 'Create Banner'}
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="../common/footer.jsp" />

    <script>
        // Form validation
        (function() {
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false);
        })();

        // Image preview functionality
        document.getElementById('image').addEventListener('input', function() {
            const imageUrl = this.value;
            const preview = document.getElementById('imagePreview');
            
            if (imageUrl && isValidUrl(imageUrl)) {
                preview.innerHTML = '<img src="' + imageUrl + '" alt="Banner Preview" style="max-width: 100%; max-height: 200px; border-radius: 6px;" onerror="showImageError()">';
            } else {
                preview.innerHTML = '<div style="color: #6c757d;"><i class="fas fa-image fa-3x mb-2"></i><p>Image preview will appear here</p></div>';
            }
        });

        // Position preview functionality
        document.getElementById('position').addEventListener('change', function() {
            const position = this.value;
            const preview = document.getElementById('positionPreview');
            preview.textContent = position || 'Not selected';
        });

        function isValidUrl(string) {
            try {
                new URL(string);
                return true;
            } catch (_) {
                return false;
            }
        }

        function showImageError() {
            document.getElementById('imagePreview').innerHTML = '<div style="color: #dc3545;"><i class="fas fa-exclamation-triangle fa-2x mb-2"></i><p>Failed to load image</p></div>';
        }
    </script>

    <style>
        .badge {
            display: inline-block;
            padding: 0.375rem 0.75rem;
            font-size: 0.875rem;
            font-weight: 500;
            line-height: 1;
            text-align: center;
            white-space: nowrap;
            vertical-align: baseline;
            border-radius: 0.375rem;
        }

        .badge-info {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .form-text {
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }

        .text-muted {
            color: #6c757d;
        }

        .invalid-feedback {
            display: none;
            width: 100%;
            margin-top: 0.25rem;
            font-size: 0.875rem;
            color: #dc3545;
        }

        .was-validated .form-control:invalid ~ .invalid-feedback {
            display: block;
        }

        .was-validated .form-control:valid {
            border-color: #28a745;
        }

        .was-validated .form-control:invalid {
            border-color: #dc3545;
        }
    </style>
</body>
</html>
