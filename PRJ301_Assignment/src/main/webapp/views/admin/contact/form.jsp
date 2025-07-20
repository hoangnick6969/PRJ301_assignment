
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trả lời tin nhắn liên hệ - Fashion Shop Admin</title>
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
                        <i class="fas fa-reply"></i>
                        📝 Trả lời tin nhắn liên hệ
                    </h1>
                    <div class="breadcrumb">
                        <a href="<c:url value='/admin/dashboard'/>">
                            <i class="fas fa-home"></i> Dashboard
                        </a>
                        <span class="separator">/</span>
                        <a href="<c:url value='/admin/contacts'/>">
                            <i class="fas fa-envelope"></i> Tin nhắn liên hệ
                        </a>
                        <span class="separator">/</span>
                        <span>Trả lời</span>
                    </div>
                </div>
                
                <div class="header-actions">
                    <a href="<c:url value='/admin/contacts'/>" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i>
                        Quay lại danh sách
                    </a>
                </div>
            </div>

            <!-- Original Message Section -->
            <c:if test="${message != null}">
                <div class="original-message-section">
                    <div class="message-card">
                        <div class="message-header">
                            <h3>
                                <i class="fas fa-envelope-open"></i>
                                Tin nhắn gốc
                            </h3>
                            <span class="message-date">
                                <i class="fas fa-clock"></i>
                                <fmt:formatDate value="${message.sentAt}" pattern="dd/MM/yyyy HH:mm"/>
                            </span>
                        </div>
                        
                        <div class="message-content">
                            <div class="sender-info">
                                <div class="sender-avatar">
                                    <i class="fas fa-user"></i>
                                </div>
                                <div class="sender-details">
                                    <h4>${message.name}</h4>
                                    <p>
                                        <i class="fas fa-envelope"></i>
                                        <a href="mailto:${message.email}">${message.email}</a>
                                    </p>
                                </div>
                            </div>
                            
                            <div class="message-subject">
                                <strong>Tiêu đề:</strong> ${message.subject}
                            </div>
                            
                            <div class="message-body">
                                <strong>Nội dung:</strong>
                                <div class="message-text">
                                    ${message.message}
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>

            <!-- Reply Form Section -->
            <div class="form-section">
                <div class="form-card">
                    <div class="form-header">
                        <h3>
                            <i class="fas fa-paper-plane"></i>
                            Soạn tin trả lời
                        </h3>
                        <div class="form-description">
                            Điền thông tin bên dưới để gửi email trả lời cho khách hàng.
                        </div>
                    </div>
                    
                    <form method="post" action="${pageContext.request.contextPath}/admin/contacts/reply" class="admin-form">
                        <input type="hidden" name="messageId" value="${message.id}" />
                        
                        <div class="form-grid">
                            <div class="form-group">
                                <label for="fromEmail" class="form-label required">
                                    <i class="fas fa-user"></i>
                                    Từ email
                                </label>
                                <input type="email" 
                                       id="fromEmail"
                                       name="fromEmail" 
                                       value="admin@fashionshop.com" 
                                       class="form-control"
                                       required />
                                <div class="form-help">
                                    Email của bạn sẽ hiển thị là người gửi.
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="toEmail" class="form-label required">
                                    <i class="fas fa-envelope"></i>
                                    Đến email
                                </label>
                                <input type="email" 
                                       id="toEmail"
                                       name="toEmail" 
                                       value="${message.email}" 
                                       class="form-control"
                                       required readonly />
                                <div class="form-help">
                                    Email của khách hàng sẽ nhận được tin trả lời.
                                </div>
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="replySubject" class="form-label required">
                                    <i class="fas fa-tag"></i>
                                    Tiêu đề email
                                </label>
                                <input type="text" 
                                       id="replySubject"
                                       name="subject" 
                                       value="Re: ${message.subject}" 
                                       class="form-control"
                                       required />
                                <div class="form-help">
                                    Tiêu đề email trả lời sẽ được tự động thêm "Re:" phía trước.
                                </div>
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="replyContent" class="form-label required">
                                    <i class="fas fa-edit"></i>
                                    Nội dung trả lời
                                </label>
                                <textarea id="replyContent"
                                          name="content"
                                          class="form-control"
                                          rows="10"
                                          placeholder="Nhập nội dung trả lời cho khách hàng..."
                                          required></textarea>
                                <div class="form-help">
                                    Viết nội dung trả lời một cách chuyên nghiệp và thân thiện.
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label for="priority" class="form-label">
                                    <i class="fas fa-exclamation-triangle"></i>
                                    Độ ưu tiên
                                </label>
                                <select id="priority" name="priority" class="form-control">
                                    <option value="normal">Bình thường</option>
                                    <option value="high">Cao</option>
                                    <option value="urgent">Khẩn cấp</option>
                                </select>
                            </div>
                            
                            <div class="form-group">
                                <label for="copyAdmin" class="form-label">
                                    <i class="fas fa-copy"></i>
                                    Gửi bản sao
                                </label>
                                <div class="checkbox-group">
                                    <label class="checkbox-label">
                                        <input type="checkbox" name="ccAdmin" id="copyAdmin" checked>
                                        <span class="checkbox-custom"></span>
                                        Gửi bản sao cho admin
                                    </label>
                                </div>
                                <div class="form-help">
                                    Gửi bản sao email này cho email admin để lưu trữ.
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-paper-plane"></i>
                                Gửi email trả lời
                            </button>
                            <button type="button" class="btn btn-success" onclick="saveDraft()">
                                <i class="fas fa-save"></i>
                                Lưu nháp
                            </button>
                            <a href="<c:url value='/admin/contacts'/>" class="btn btn-secondary">
                                <i class="fas fa-times"></i>
                                Hủy bỏ
                            </a>
                        </div>
                    </form>
                </div>
            </div>

            <!-- Email Template Section -->
            <div class="template-section">
                <div class="template-card">
                    <div class="template-header">
                        <h3>
                            <i class="fas fa-file-alt"></i>
                            Mẫu email có sẵn
                        </h3>
                    </div>
                    <div class="template-grid">
                        <div class="template-item" onclick="useTemplate('thank-you')">
                            <div class="template-icon">
                                <i class="fas fa-heart"></i>
                            </div>
                            <h4>Cảm ơn khách hàng</h4>
                            <p>Mẫu email cảm ơn khách hàng đã liên hệ</p>
                        </div>
                        
                        <div class="template-item" onclick="useTemplate('support')">
                            <div class="template-icon">
                                <i class="fas fa-headset"></i>
                            </div>
                            <h4>Hỗ trợ kỹ thuật</h4>
                            <p>Mẫu email hỗ trợ giải quyết vấn đề</p>
                        </div>
                        
                        <div class="template-item" onclick="useTemplate('order-info')">
                            <div class="template-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <h4>Thông tin đơn hàng</h4>
                            <p>Mẫu email cung cấp thông tin đơn hàng</p>
                        </div>
                        
                        <div class="template-item" onclick="useTemplate('apology')">
                            <div class="template-icon">
                                <i class="fas fa-exclamation-circle"></i>
                            </div>
                            <h4>Xin lỗi khách hàng</h4>
                            <p>Mẫu email xin lỗi về sự cố</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Include footer -->
        <jsp:include page="../common/footer.jsp"/>
    </div>

    <script>
        // Email templates
        const emailTemplates = {
            'thank-you': `Kính gửi ${message ? message.name : '[Tên khách hàng]'},

Cảm ơn bạn đã liên hệ với FashionShop. Chúng tôi đã nhận được tin nhắn của bạn và sẽ phản hồi trong thời gian sớm nhất.

Thông tin liên hệ của bạn:
- Tên: ${message ? message.name : '[Tên]'}
- Email: ${message ? message.email : '[Email]'}
- Tiêu đề: ${message ? message.subject : '[Tiêu đề]'}

Chúng tôi rất trân trọng sự quan tâm của bạn đối với sản phẩm và dịch vụ của chúng tôi.

Trân trọng,
Đội ngũ FashionShop`,

            'support': `Kính gửi ${message ? message.name : '[Tên khách hàng]'},

Cảm ơn bạn đã liên hệ với bộ phận hỗ trợ của FashionShop.

Chúng tôi hiểu rằng bạn đang gặp phải một số vấn đề và chúng tôi sẵn sàng hỗ trợ bạn giải quyết.

Để có thể hỗ trợ bạn tốt nhất, vui lòng cung cấp thêm thông tin:
- Mô tả chi tiết vấn đề bạn gặp phải
- Thời gian xảy ra vấn đề
- Các bước bạn đã thực hiện

Chúng tôi sẽ phản hồi trong vòng 24 giờ.

Trân trọng,
Đội ngũ hỗ trợ FashionShop`,

            'order-info': `Kính gửi ${message ? message.name : '[Tên khách hàng]'},

Cảm ơn bạn đã liên hệ về thông tin đơn hàng.

Chúng tôi đã kiểm tra và sẽ cung cấp thông tin chi tiết về đơn hàng của bạn:

[Thông tin đơn hàng sẽ được cập nhật tại đây]

Nếu bạn có bất kỳ câu hỏi nào khác về đơn hàng, vui lòng liên hệ với chúng tôi.

Hotline: 1900-1234
Email: support@fashionshop.com

Trân trọng,
Đội ngũ FashionShop`,

            'apology': `Kính gửi ${message ? message.name : '[Tên khách hàng]'},

Chúng tôi rất xin lỗi về sự bất tiện mà bạn đã gặp phải.

FashionShop luôn cam kết mang đến trải nghiệm tốt nhất cho khách hàng và chúng tôi thực sự tiếc nuối về sự cố này.

Chúng tôi đã tiến hành:
- Điều tra nguyên nhân sự cố
- Thực hiện các biện pháp khắc phục
- Cải thiện quy trình để tránh tái diễn

Để bồi thường cho sự bất tiện này, chúng tôi xin gửi tặng bạn [ưu đãi/quà tặng].

Một lần nữa, chúng tôi thành thật xin lỗi và hy vọng được phục vụ bạn tốt hơn trong tương lai.

Trân trọng,
Ban Giám đốc FashionShop`
        };

        // Use email template
        function useTemplate(templateType) {
            const template = emailTemplates[templateType];
            if (template) {
                document.getElementById('replyContent').value = template;
            }
        }

        // Save draft functionality
        function saveDraft() {
            const formData = new FormData(document.querySelector('.admin-form'));
            // In a real application, you would save the draft via AJAX
            alert('Nháp đã được lưu thành công!');
        }

        // Form validation
        document.querySelector('.admin-form').addEventListener('submit', function(e) {
            const fromEmail = document.getElementById('fromEmail').value.trim();
            const toEmail = document.getElementById('toEmail').value.trim();
            const subject = document.getElementById('replySubject').value.trim();
            const content = document.getElementById('replyContent').value.trim();
            
            if (!fromEmail || !toEmail || !subject || !content) {
                e.preventDefault();
                alert('Vui lòng điền đầy đủ thông tin bắt buộc!');
                return false;
            }
            
            if (content.length < 10) {
                e.preventDefault();
                alert('Nội dung email phải có ít nhất 10 ký tự!');
                document.getElementById('replyContent').focus();
                return false;
            }
            
            if (!confirm('Bạn có chắc chắn muốn gửi email trả lời này?')) {
                e.preventDefault();
                return false;
            }
        });

        // Auto-save draft every 2 minutes
        setInterval(function() {
            const content = document.getElementById('replyContent').value.trim();
            if (content.length > 50) {
                // Auto-save logic would go here
                console.log('Auto-saving draft...');
            }
        }, 120000); // 2 minutes

        // Character counter for textarea
        document.getElementById('replyContent').addEventListener('input', function() {
            const maxLength = 5000;
            const currentLength = this.value.length;
            const remaining = maxLength - currentLength;
            
            // You can add a character counter display here
            if (remaining < 100) {
                this.style.borderColor = '#e74c3c';
            } else {
                this.style.borderColor = '#ddd';
            }
        });
    </script>
</body>
</html>
