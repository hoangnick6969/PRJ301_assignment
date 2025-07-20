<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${coupon != null}">Cập nhật mã giảm giá</c:when>
            <c:otherwise>Thêm mã giảm giá mới</c:otherwise>
        </c:choose>
        - Fashion Shop Admin
    </title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="<c:url value='/css/style.css'/>" rel="stylesheet">
</head>
<body class="bg-light">
    <!-- Include header -->
    <jsp:include page="../common/header.jsp"/>

    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar could go here if needed -->
            <div class="col-12">
                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="mt-3">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a href="<c:url value='/admin/dashboard'/>">
                                <i class="fas fa-home"></i> Dashboard
                            </a>
                        </li>
                        <li class="breadcrumb-item">
                            <a href="<c:url value='/admin/coupons'/>">
                                <i class="fas fa-ticket-alt"></i> Mã giảm giá
                            </a>
                        </li>
                        <li class="breadcrumb-item active" aria-current="page">
                            <c:choose>
                                <c:when test="${coupon != null}">Cập nhật</c:when>
                                <c:otherwise>Thêm mới</c:otherwise>
                            </c:choose>
                        </li>
                    </ol>
                </nav>

                <!-- Page Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h1 class="h3 mb-0">
                        <i class="fas fa-ticket-alt text-primary"></i>
                        <c:choose>
                            <c:when test="${coupon != null}">Cập nhật mã giảm giá</c:when>
                            <c:otherwise>Thêm mã giảm giá mới</c:otherwise>
                        </c:choose>
                    </h1>
                </div>

                <!-- Main Content -->
                <div class="row">
                    <div class="col-lg-8">
                        <!-- Form Card -->
                        <div class="card shadow-sm">
                            <div class="card-header bg-primary text-white">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-edit"></i> Thông tin mã giảm giá
                                </h5>
                            </div>
                            <div class="card-body">
                                <form method="post" action="${pageContext.request.contextPath}/admin/coupons" class="needs-validation" novalidate>
                                    <input type="hidden" name="id" value="${coupon.id}" />

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="code" class="form-label">
                                                <i class="fas fa-code text-primary"></i>
                                                Mã giảm giá <span class="text-danger">*</span>
                                            </label>
                                            <input type="text" 
                                                   id="code"
                                                   name="code" 
                                                   value="${coupon.code}" 
                                                   class="form-control" 
                                                   placeholder="VD: SUMMER2024"
                                                   required 
                                                   maxlength="20"
                                                   pattern="[A-Z0-9]+"
                                                   style="text-transform: uppercase;">
                                            <div class="form-text">
                                                <i class="fas fa-info-circle"></i> 
                                                Chỉ chữ cái viết hoa và số, tối đa 20 ký tự
                                            </div>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập mã giảm giá hợp lệ.
                                            </div>
                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label for="discountPercent" class="form-label">
                                                <i class="fas fa-percentage text-success"></i>
                                                Phần trăm giảm giá <span class="text-danger">*</span>
                                            </label>
                                            <div class="input-group">
                                                <input type="number" 
                                                       id="discountPercent"
                                                       name="discountPercent" 
                                                       value="${coupon.discountPercent}" 
                                                       class="form-control" 
                                                       placeholder="0"
                                                       min="1" 
                                                       max="100" 
                                                       required>
                                                <span class="input-group-text bg-success text-white">%</span>
                                            </div>
                                            <div class="form-text">
                                                <i class="fas fa-info-circle"></i> 
                                                Mức giảm từ 1% đến 100%
                                            </div>
                                            <div class="invalid-feedback">
                                                Vui lòng nhập phần trăm giảm giá từ 1-100.
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="expiryDate" class="form-label">
                                                <i class="fas fa-calendar-alt text-warning"></i>
                                                Ngày hết hạn <span class="text-danger">*</span>
                                            </label>
                                            <input type="date" 
                                                   id="expiryDate"
                                                   name="expiryDate" 
                                                   value="<fmt:formatDate value='${coupon.expiryDate}' pattern='yyyy-MM-dd'/>" 
                                                   class="form-control" 
                                                   required 
                                                   min="<fmt:formatDate value='${currentDate}' pattern='yyyy-MM-dd'/>">
                                            <div class="form-text">
                                                <i class="fas fa-info-circle"></i> 
                                                Ngày hết hạn phải sau ngày hiện tại
                                            </div>
                                            <div class="invalid-feedback">
                                                Vui lòng chọn ngày hết hạn hợp lệ.
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Form Actions -->
                                    <div class="d-flex gap-2 flex-wrap">
                                        <button type="submit" class="btn btn-primary">
                                            <i class="fas fa-save"></i>
                                            <c:choose>
                                                <c:when test="${coupon != null}">Cập nhật</c:when>
                                                <c:otherwise>Tạo mới</c:otherwise>
                                            </c:choose>
                                        </button>

                                        <a href="${pageContext.request.contextPath}/admin/coupons" class="btn btn-secondary">
                                            <i class="fas fa-times"></i> Hủy bỏ
                                        </a>

                                        <button type="button" class="btn btn-outline-warning" onclick="resetForm()">
                                            <i class="fas fa-undo"></i> Đặt lại
                                        </button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <!-- Preview Card -->
                        <div class="card shadow-sm">
                            <div class="card-header bg-info text-white">
                                <h5 class="card-title mb-0">
                                    <i class="fas fa-eye"></i> Xem trước
                                </h5>
                            </div>
                            <div class="card-body">
                                <div class="coupon-preview p-3 bg-gradient text-white rounded-3" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                    <div class="text-center">
                                        <div class="mb-2">
                                            <i class="fas fa-gift fa-2x"></i>
                                        </div>
                                        <h6 class="fw-bold">MÃ GIẢM GIÁ</h6>
                                        <div class="border border-white rounded p-2 mb-2">
                                            <h4 class="mb-0 fw-bold" id="previewCode">
                                                ${coupon.code != null ? coupon.code : 'PREVIEW'}
                                            </h4>
                                        </div>
                                        <div class="mb-2">
                                            <h5 class="mb-0">
                                                Giảm <span id="previewDiscount">${coupon.discountPercent != null ? coupon.discountPercent : '0'}</span>%
                                            </h5>
                                        </div>
                                        <small>
                                            Hết hạn: <span id="previewExpiry">
                                                <c:choose>
                                                    <c:when test="${coupon.expiryDate != null}">
                                                        <fmt:formatDate value="${coupon.expiryDate}" pattern="dd/MM/yyyy"/>
                                                    </c:when>
                                                    <c:otherwise>--/--/----</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Tips Card -->
                        <div class="card shadow-sm mt-3">
                            <div class="card-header bg-light">
                                <h6 class="card-title mb-0">
                                    <i class="fas fa-lightbulb text-warning"></i> Gợi ý
                                </h6>
                            </div>
                            <div class="card-body">
                                <ul class="list-unstyled mb-0">
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success"></i>
                                        Sử dụng mã ngắn gọn, dễ nhớ
                                    </li>
                                    <li class="mb-2">
                                        <i class="fas fa-check text-success"></i>
                                        Đặt thời hạn phù hợp với chiến dịch
                                    </li>
                                    <li class="mb-0">
                                        <i class="fas fa-check text-success"></i>
                                        Kiểm tra mã không trùng lặp
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Include footer -->
    <jsp:include page="../common/footer.jsp"/>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Bootstrap form validation
        (() => {
            'use strict';
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();

        // Real-time preview updates
        document.addEventListener('DOMContentLoaded', function() {
            const codeInput = document.getElementById('code');
            const discountInput = document.getElementById('discountPercent');
            const expiryInput = document.getElementById('expiryDate');

            const previewCode = document.getElementById('previewCode');
            const previewDiscount = document.getElementById('previewDiscount');
            const previewExpiry = document.getElementById('previewExpiry');

            // Update code preview
            codeInput?.addEventListener('input', function() {
                previewCode.textContent = this.value || 'PREVIEW';
            });

            // Update discount preview
            discountInput?.addEventListener('input', function() {
                previewDiscount.textContent = this.value || '0';
            });

            // Update expiry preview
            expiryInput?.addEventListener('input', function() {
                if (this.value) {
                    const date = new Date(this.value);
                    previewExpiry.textContent = date.toLocaleDateString('vi-VN');
                } else {
                    previewExpiry.textContent = '--/--/----';
                }
            });

            // Auto-uppercase code input
            codeInput?.addEventListener('input', function() {
                this.value = this.value.toUpperCase();
            });
        });

        // Reset form function
        function resetForm() {
            if (confirm('Bạn có chắc chắn muốn đặt lại form? Tất cả dữ liệu đã nhập sẽ bị mất.')) {
                const form = document.querySelector('.needs-validation');
                form.reset();
                form.classList.remove('was-validated');
                document.getElementById('previewCode').textContent = 'PREVIEW';
                document.getElementById('previewDiscount').textContent = '0';
                document.getElementById('previewExpiry').textContent = '--/--/----';
            }
        }
    </script>
</body>
</html>