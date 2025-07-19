
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
            <c:when test="${customer != null}">Cập nhật khách hàng</c:when>
            <c:otherwise>Thêm khách hàng mới</c:otherwise>
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
                        <i class="fas fa-user-plus"></i>
                        <c:choose>
                            <c:when test="${customer != null}">✏️ Cập nhật thông tin khách hàng</c:when>
                            <c:otherwise>👤 Thêm khách hàng mới</c:otherwise>
                        </c:choose>
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <a href="<c:url value='/admin/customers'/>">
                            <i class="fas fa-users"></i> Khách hàng
                        </a>
                        <span class="separator">/</span>
                        <span>
                            <c:choose>
                                <c:when test="${customer != null}">Cập nhật</c:when>
                                <c:otherwise>Thêm mới</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </div>
            </div>

            <!-- Form Section -->
            <div class="form-section">
                <div class="form-grid-container">
                    <!-- Main Form -->
                    <div class="form-card main-form">
                        <div class="form-header">
                            <h3>
                                <i class="fas fa-user-edit"></i>
                                Thông tin cá nhân
                            </h3>
                            <p class="form-description">
                                Vui lòng điền đầy đủ thông tin để ${customer != null ? 'cập nhật' : 'tạo mới'} tài khoản khách hàng
                            </p>
                        </div>

                        <form method="post" action="${pageContext.request.contextPath}/admin/customers" class="customer-form">
                            <input type="hidden" name="id" value="${customer.id}" />

                            <div class="form-grid">
                                <div class="form-group full-width">
                                    <label class="form-label required">
                                        <i class="fas fa-user"></i>
                                        Họ và tên
                                    </label>
                                    <input type="text" 
                                           name="fullName" 
                                           value="${customer.fullName}" 
                                           class="form-control" 
                                           placeholder="Nhập họ và tên đầy đủ"
                                           required 
                                           maxlength="100">
                                    <div class="form-help">
                                        <small><i class="fas fa-info-circle"></i> Tối đa 100 ký tự</small>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label required">
                                        <i class="fas fa-envelope"></i>
                                        Email
                                    </label>
                                    <input type="email" 
                                           name="email" 
                                           value="${customer.email}" 
                                           class="form-control" 
                                           placeholder="example@email.com"
                                           required 
                                           maxlength="150">
                                    <div class="form-help">
                                        <small><i class="fas fa-info-circle"></i> Email sẽ được sử dụng để đăng nhập</small>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label required">
                                        <i class="fas fa-phone"></i>
                                        Số điện thoại
                                    </label>
                                    <input type="tel" 
                                           name="phone" 
                                           value="${customer.phone}" 
                                           class="form-control" 
                                           placeholder="0987654321"
                                           required 
                                           pattern="[0-9]{10,11}"
                                           maxlength="11">
                                    <div class="form-help">
                                        <small><i class="fas fa-info-circle"></i> Số điện thoại 10-11 chữ số</small>
                                    </div>
                                </div>

                                <div class="form-group full-width">
                                    <label class="form-label">
                                        <i class="fas fa-map-marker-alt"></i>
                                        Địa chỉ
                                    </label>
                                    <textarea name="address" 
                                              class="form-control" 
                                              placeholder="Nhập địa chỉ chi tiết"
                                              rows="3"
                                              maxlength="500">${customer.address}</textarea>
                                    <div class="form-help">
                                        <small><i class="fas fa-info-circle"></i> Tối đa 500 ký tự</small>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-calendar"></i>
                                        Ngày sinh
                                    </label>
                                    <input type="date" 
                                           name="dateOfBirth" 
                                           value="<fmt:formatDate value='${customer.dateOfBirth}' pattern='yyyy-MM-dd'/>" 
                                           class="form-control"
                                           max="<fmt:formatDate value='${currentDate}' pattern='yyyy-MM-dd'/>">
                                    <div class="form-help">
                                        <small><i class="fas fa-info-circle"></i> Không bắt buộc</small>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-venus-mars"></i>
                                        Giới tính
                                    </label>
                                    <select name="gender" class="form-control">
                                        <option value="">Chọn giới tính</option>
                                        <option value="Male" ${customer.gender == 'Male' ? 'selected' : ''}>Nam</option>
                                        <option value="Female" ${customer.gender == 'Female' ? 'selected' : ''}>Nữ</option>
                                        <option value="Other" ${customer.gender == 'Other' ? 'selected' : ''}>Khác</option>
                                    </select>
                                </div>

                                <c:if test="${customer == null}">
                                    <div class="form-group">
                                        <label class="form-label required">
                                            <i class="fas fa-lock"></i>
                                            Mật khẩu
                                        </label>
                                        <div class="password-input">
                                            <input type="password" 
                                                   name="password" 
                                                   class="form-control" 
                                                   placeholder="Nhập mật khẩu"
                                                   required 
                                                   minlength="6"
                                                   id="passwordInput">
                                            <button type="button" class="password-toggle" onclick="togglePassword('passwordInput')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="form-help">
                                            <small><i class="fas fa-info-circle"></i> Tối thiểu 6 ký tự</small>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label class="form-label required">
                                            <i class="fas fa-lock"></i>
                                            Xác nhận mật khẩu
                                        </label>
                                        <div class="password-input">
                                            <input type="password" 
                                                   name="confirmPassword" 
                                                   class="form-control" 
                                                   placeholder="Nhập lại mật khẩu"
                                                   required 
                                                   minlength="6"
                                                   id="confirmPasswordInput">
                                            <button type="button" class="password-toggle" onclick="togglePassword('confirmPasswordInput')">
                                                <i class="fas fa-eye"></i>
                                            </button>
                                        </div>
                                        <div class="form-help">
                                            <small><i class="fas fa-info-circle"></i> Phải trùng với mật khẩu</small>
                                        </div>
                                    </div>
                                </c:if>

                                <div class="form-group">
                                    <label class="form-label">
                                        <i class="fas fa-toggle-on"></i>
                                        Trạng thái
                                    </label>
                                    <div class="switch-container">
                                        <label class="switch">
                                            <input type="checkbox" 
                                                   name="isActive" 
                                                   ${customer == null || customer.isActive ? 'checked' : ''}>
                                            <span class="slider"></span>
                                        </label>
                                        <span class="switch-label">Kích hoạt tài khoản</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Form Actions -->
                            <div class="form-actions">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save"></i>
                                    <c:choose>
                                        <c:when test="${customer != null}">Cập nhật khách hàng</c:when>
                                        <c:otherwise>Tạo khách hàng</c:otherwise>
                                    </c:choose>
                                </button>
                                
                                <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-secondary">
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

                    <!-- Customer Preview Card -->
                    <div class="form-card preview-card">
                        <div class="form-header">
                            <h3>
                                <i class="fas fa-eye"></i>
                                Xem trước thông tin
                            </h3>
                        </div>

                        <div class="customer-preview">
                            <div class="preview-avatar">
                                <i class="fas fa-user-circle"></i>
                            </div>
                            
                            <div class="preview-info">
                                <h4 id="previewName">${customer.fullName != null ? customer.fullName : 'Tên khách hàng'}</h4>
                                <p class="preview-id">ID: #${customer.id != null ? customer.id : 'NEW'}</p>
                                
                                <div class="preview-details">
                                    <div class="preview-item">
                                        <i class="fas fa-envelope"></i>
                                        <span id="previewEmail">${customer.email != null ? customer.email : 'email@example.com'}</span>
                                    </div>
                                    
                                    <div class="preview-item">
                                        <i class="fas fa-phone"></i>
                                        <span id="previewPhone">${customer.phone != null ? customer.phone : '0987654321'}</span>
                                    </div>
                                    
                                    <div class="preview-item">
                                        <i class="fas fa-map-marker-alt"></i>
                                        <span id="previewAddress">${customer.address != null ? customer.address : 'Địa chỉ'}</span>
                                    </div>
                                    
                                    <div class="preview-item">
                                        <i class="fas fa-calendar"></i>
                                        <span id="previewBirth">
                                            <c:choose>
                                                <c:when test="${customer.dateOfBirth != null}">
                                                    <fmt:formatDate value="${customer.dateOfBirth}" pattern="dd/MM/yyyy"/>
                                                </c:when>
                                                <c:otherwise>--/--/----</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                    
                                    <div class="preview-item">
                                        <i class="fas fa-venus-mars"></i>
                                        <span id="previewGender">${customer.gender != null ? customer.gender : 'Chưa xác định'}</span>
                                    </div>
                                </div>
                                
                                <div class="preview-status">
                                    <span class="status-badge" id="previewStatus">
                                        <i class="fas fa-check-circle"></i>
                                        Hoạt động
                                    </span>
                                </div>
                            </div>
                        </div>

                        <!-- Quick Stats -->
                        <div class="quick-stats">
                            <h4><i class="fas fa-chart-bar"></i> Thống kê nhanh</h4>
                            <div class="stats-list">
                                <div class="stat-item">
                                    <span class="stat-label">Đơn hàng:</span>
                                    <span class="stat-value">0</span>
                                </div>
                                <div class="stat-item">
                                    <span class="stat-label">Tổng chi tiêu:</span>
                                    <span class="stat-value">0đ</span>
                                </div>
                                <div class="stat-item">
                                    <span class="stat-label">Ngày tham gia:</span>
                                    <span class="stat-value">Hôm nay</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        // Real-time preview updates
        document.addEventListener('DOMContentLoaded', function() {
            const nameInput = document.querySelector('input[name="fullName"]');
            const emailInput = document.querySelector('input[name="email"]');
            const phoneInput = document.querySelector('input[name="phone"]');
            const addressInput = document.querySelector('textarea[name="address"]');
            const birthInput = document.querySelector('input[name="dateOfBirth"]');
            const genderInput = document.querySelector('select[name="gender"]');
            const statusInput = document.querySelector('input[name="isActive"]');
            
            // Update name preview
            nameInput?.addEventListener('input', function() {
                document.getElementById('previewName').textContent = this.value || 'Tên khách hàng';
            });

            // Update email preview
            emailInput?.addEventListener('input', function() {
                document.getElementById('previewEmail').textContent = this.value || 'email@example.com';
            });

            // Update phone preview
            phoneInput?.addEventListener('input', function() {
                document.getElementById('previewPhone').textContent = this.value || '0987654321';
            });

            // Update address preview
            addressInput?.addEventListener('input', function() {
                document.getElementById('previewAddress').textContent = this.value || 'Địa chỉ';
            });

            // Update birth preview
            birthInput?.addEventListener('input', function() {
                if (this.value) {
                    const date = new Date(this.value);
                    document.getElementById('previewBirth').textContent = date.toLocaleDateString('vi-VN');
                } else {
                    document.getElementById('previewBirth').textContent = '--/--/----';
                }
            });

            // Update gender preview
            genderInput?.addEventListener('change', function() {
                const genderText = this.options[this.selectedIndex].text;
                document.getElementById('previewGender').textContent = genderText || 'Chưa xác định';
            });

            // Update status preview
            statusInput?.addEventListener('change', function() {
                const statusElement = document.getElementById('previewStatus');
                if (this.checked) {
                    statusElement.innerHTML = '<i class="fas fa-check-circle"></i> Hoạt động';
                    statusElement.className = 'status-badge status-active';
                } else {
                    statusElement.innerHTML = '<i class="fas fa-times-circle"></i> Không hoạt động';
                    statusElement.className = 'status-badge status-inactive';
                }
            });
        });

        // Toggle password visibility
        function togglePassword(inputId) {
            const input = document.getElementById(inputId);
            const button = input.nextElementSibling;
            const icon = button.querySelector('i');
            
            if (input.type === 'password') {
                input.type = 'text';
                icon.className = 'fas fa-eye-slash';
            } else {
                input.type = 'password';
                icon.className = 'fas fa-eye';
            }
        }

        // Reset form function
        function resetForm() {
            if (confirm('Bạn có chắc chắn muốn đặt lại form? Tất cả dữ liệu đã nhập sẽ bị mất.')) {
                document.querySelector('.customer-form').reset();
                
                // Reset preview
                document.getElementById('previewName').textContent = 'Tên khách hàng';
                document.getElementById('previewEmail').textContent = 'email@example.com';
                document.getElementById('previewPhone').textContent = '0987654321';
                document.getElementById('previewAddress').textContent = 'Địa chỉ';
                document.getElementById('previewBirth').textContent = '--/--/----';
                document.getElementById('previewGender').textContent = 'Chưa xác định';
                
                const statusElement = document.getElementById('previewStatus');
                statusElement.innerHTML = '<i class="fas fa-check-circle"></i> Hoạt động';
                statusElement.className = 'status-badge status-active';
            }
        }

        // Form validation
        document.querySelector('.customer-form').addEventListener('submit', function(e) {
            const password = document.querySelector('input[name="password"]');
            const confirmPassword = document.querySelector('input[name="confirmPassword"]');
            
            if (password && confirmPassword) {
                if (password.value !== confirmPassword.value) {
                    e.preventDefault();
                    alert('Mật khẩu và xác nhận mật khẩu không khớp!');
                    return;
                }
            }

            const email = document.querySelector('input[name="email"]').value;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                e.preventDefault();
                alert('Email không hợp lệ!');
                return;
            }

            const phone = document.querySelector('input[name="phone"]').value;
            const phoneRegex = /^[0-9]{10,11}$/;
            if (!phoneRegex.test(phone)) {
                e.preventDefault();
                alert('Số điện thoại phải có 10-11 chữ số!');
                return;
            }
        });
    </script>

    <style>
        .form-grid-container {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .main-form {
            grid-column: 1;
        }

        .preview-card {
            grid-column: 2;
            position: sticky;
            top: 2rem;
            height: fit-content;
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .password-input {
            position: relative;
            display: flex;
            align-items: center;
        }

        .password-toggle {
            position: absolute;
            right: 0.75rem;
            background: none;
            border: none;
            color: #6c757d;
            cursor: pointer;
            padding: 0.25rem;
            border-radius: 4px;
            transition: color 0.2s ease;
        }

        .password-toggle:hover {
            color: #495057;
        }

        .switch-container {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .switch {
            position: relative;
            display: inline-block;
            width: 50px;
            height: 24px;
        }

        .switch input {
            opacity: 0;
            width: 0;
            height: 0;
        }

        .slider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: .4s;
            border-radius: 24px;
        }

        .slider:before {
            position: absolute;
            content: "";
            height: 18px;
            width: 18px;
            left: 3px;
            bottom: 3px;
            background-color: white;
            transition: .4s;
            border-radius: 50%;
        }

        input:checked + .slider {
            background-color: #667eea;
        }

        input:checked + .slider:before {
            transform: translateX(26px);
        }

        .switch-label {
            color: #495057;
            font-weight: 500;
        }

        .customer-preview {
            text-align: center;
            padding: 1.5rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 12px;
            color: white;
            margin-bottom: 1.5rem;
        }

        .preview-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: rgba(255, 255, 255, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            font-size: 2.5rem;
        }

        .preview-info h4 {
            margin: 0 0 0.5rem 0;
            font-size: 1.3rem;
            font-weight: bold;
        }

        .preview-id {
            margin: 0 0 1rem 0;
            opacity: 0.8;
            font-size: 0.9rem;
        }

        .preview-details {
            text-align: left;
            margin-bottom: 1rem;
        }

        .preview-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.75rem;
            font-size: 0.9rem;
        }

        .preview-item i {
            width: 16px;
            opacity: 0.8;
        }

        .preview-status {
            text-align: center;
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
            background: rgba(40, 167, 69, 0.2);
            color: #28a745;
            border: 1px solid rgba(40, 167, 69, 0.3);
        }

        .status-inactive {
            background: rgba(220, 53, 69, 0.2);
            color: #dc3545;
            border: 1px solid rgba(220, 53, 69, 0.3);
        }

        .quick-stats {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 1rem;
        }

        .quick-stats h4 {
            margin: 0 0 1rem 0;
            color: #495057;
            font-size: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .stats-list {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .stat-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .stat-label {
            color: #6c757d;
            font-size: 0.9rem;
        }

        .stat-value {
            font-weight: 600;
            color: #495057;
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

        @media (max-width: 1024px) {
            .form-grid-container {
                grid-template-columns: 1fr;
            }
            
            .preview-card {
                position: static;
            }
        }

        @media (max-width: 768px) {
            .form-grid {
                grid-template-columns: 1fr;
            }
            
            .form-group.full-width {
                grid-column: span 1;
            }
        }
    </style>
</body>
</html>
