
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
                        <i class="fas fa-ticket-alt"></i>
                        <c:choose>
                            <c:when test="${coupon != null}">✏️ Cập nhật mã giảm giá</c:when>
                            <c:otherwise>➕ Thêm mã giảm giá mới</c:otherwise>
                        </c:choose>
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <a href="<c:url value='/admin/coupons'/>">
                            <i class="fas fa-ticket-alt"></i> Mã giảm giá
                        </a>
                        <span class="separator">/</span>
                        <span>
                            <c:choose>
                                <c:when test="${coupon != null}">Cập nhật</c:when>
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
                            <i class="fas fa-edit"></i>
                            Thông tin mã giảm giá
                        </h3>
                        <p class="form-description">
                            Vui lòng điền đầy đủ thông tin để ${coupon != null ? 'cập nhật' : 'tạo mới'} mã giảm giá
                        </p>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/admin/coupons" class="coupon-form">
                        <input type="hidden" name="id" value="${coupon.id}" />

                        <div class="form-grid">
                            <div class="form-group">
                                <label class="form-label required">
                                    <i class="fas fa-code"></i>
                                    Mã giảm giá
                                </label>
                                <input type="text" 
                                       name="code" 
                                       value="${coupon.code}" 
                                       class="form-control" 
                                       placeholder="Nhập mã giảm giá (ví dụ: SUMMER2024)"
                                       required 
                                       maxlength="20"
                                       pattern="[A-Z0-9]+"
                                       title="Mã chỉ được chứa chữ cái viết hoa và số">
                                <div class="form-help">
                                    <small><i class="fas fa-info-circle"></i> Mã chỉ được chứa chữ cái viết hoa và số, tối đa 20 ký tự</small>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label required">
                                    <i class="fas fa-percentage"></i>
                                    Phần trăm giảm giá
                                </label>
                                <div class="input-group">
                                    <input type="number" 
                                           name="discountPercent" 
                                           value="${coupon.discountPercent}" 
                                           class="form-control" 
                                           placeholder="0"
                                           min="1" 
                                           max="100" 
                                           required>
                                    <span class="input-group-text">%</span>
                                </div>
                                <div class="form-help">
                                    <small><i class="fas fa-info-circle"></i> Mức giảm từ 1% đến 100%</small>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label required">
                                    <i class="fas fa-calendar-alt"></i>
                                    Ngày hết hạn
                                </label>
                                <input type="date" 
                                       name="expiryDate" 
                                       value="<fmt:formatDate value='${coupon.expiryDate}' pattern='yyyy-MM-dd'/>" 
                                       class="form-control" 
                                       required 
                                       min="<fmt:formatDate value='${currentDate}' pattern='yyyy-MM-dd'/>">
                                <div class="form-help">
                                    <small><i class="fas fa-info-circle"></i> Ngày hết hạn phải sau ngày hiện tại</small>
                                </div>
                            </div>
                        </div>

                        <!-- Preview Card -->
                        <div class="coupon-preview">
                            <h4><i class="fas fa-eye"></i> Xem trước mã giảm giá</h4>
                            <div class="coupon-card">
                                <div class="coupon-header">
                                    <i class="fas fa-gift"></i>
                                    <span class="coupon-title">Mã giảm giá</span>
                                </div>
                                <div class="coupon-body">
                                    <div class="coupon-code" id="previewCode">${coupon.code != null ? coupon.code : 'PREVIEW'}</div>
                                    <div class="coupon-discount">
                                        Giảm <span id="previewDiscount">${coupon.discountPercent != null ? coupon.discountPercent : '0'}</span>%
                                    </div>
                                    <div class="coupon-expiry">
                                        Hết hạn: <span id="previewExpiry">
                                            <c:choose>
                                                <c:when test="${coupon.expiryDate != null}">
                                                    <fmt:formatDate value="${coupon.expiryDate}" pattern="dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>--/--/----</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Form Actions -->
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i>
                                <c:choose>
                                    <c:when test="${coupon != null}">Cập nhật mã giảm giá</c:when>
                                    <c:otherwise>Tạo mã giảm giá</c:otherwise>
                                </c:choose>
                            </button>
                            
                            <a href="${pageContext.request.contextPath}/admin/coupons" class="btn btn-secondary">
                                <i class="fas fa-times"></i>
                                Hủy bỏ
                            </a>
                            
                            <button type="button" class="btn btn-outline" onclick="resetForm()">
                                <i class="fas fa-undo"></i>
                                Đặt lại
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        // Real-time preview updates
        document.addEventListener('DOMContentLoaded', function() {
            const codeInput = document.querySelector('input[name="code"]');
            const discountInput = document.querySelector('input[name="discountPercent"]');
            const expiryInput = document.querySelector('input[name="expiryDate"]');
            
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
                document.querySelector('.coupon-form').reset();
                document.getElementById('previewCode').textContent = 'PREVIEW';
                document.getElementById('previewDiscount').textContent = '0';
                document.getElementById('previewExpiry').textContent = '--/--/----';
            }
        }

        // Form validation
        document.querySelector('.coupon-form').addEventListener('submit', function(e) {
            const code = document.querySelector('input[name="code"]').value;
            const discount = parseInt(document.querySelector('input[name="discountPercent"]').value);
            const expiry = new Date(document.querySelector('input[name="expiryDate"]').value);
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            if (!/^[A-Z0-9]+$/.test(code)) {
                e.preventDefault();
                alert('Mã giảm giá chỉ được chứa chữ cái viết hoa và số!');
                return;
            }

            if (discount < 1 || discount > 100) {
                e.preventDefault();
                alert('Phần trăm giảm giá phải từ 1% đến 100%!');
                return;
            }

            if (expiry <= today) {
                e.preventDefault();
                alert('Ngày hết hạn phải sau ngày hôm nay!');
                return;
            }
        });
    </script>

    <style>
        .coupon-preview {
            margin: 2rem 0;
            padding: 1.5rem;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            border-radius: 12px;
            border: 1px solid #e9ecef;
        }

        .coupon-preview h4 {
            margin-bottom: 1rem;
            color: #495057;
            font-weight: 600;
        }

        .coupon-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            color: white;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
            max-width: 300px;
            margin: 0 auto;
        }

        .coupon-header {
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            text-align: center;
            font-weight: 600;
        }

        .coupon-header i {
            margin-right: 0.5rem;
            font-size: 1.2em;
        }

        .coupon-body {
            padding: 1.5rem;
            text-align: center;
        }

        .coupon-code {
            font-size: 1.5em;
            font-weight: bold;
            margin-bottom: 0.5rem;
            padding: 0.5rem;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            letter-spacing: 2px;
        }

        .coupon-discount {
            font-size: 1.2em;
            margin-bottom: 0.5rem;
            font-weight: 600;
        }

        .coupon-expiry {
            font-size: 0.9em;
            opacity: 0.9;
        }

        .input-group {
            display: flex;
            align-items: stretch;
        }

        .input-group .form-control {
            border-top-right-radius: 0;
            border-bottom-right-radius: 0;
            border-right: none;
        }

        .input-group-text {
            display: flex;
            align-items: center;
            padding: 0.75rem 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: 2px solid #667eea;
            border-left: none;
            border-top-right-radius: 8px;
            border-bottom-right-radius: 8px;
            font-weight: 600;
        }

        .form-help {
            margin-top: 0.5rem;
        }

        .form-help small {
            color: #6c757d;
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .form-label.required::after {
            content: ' *';
            color: #e74c3c;
            font-weight: bold;
        }
    </style>
</body>
</html>
