<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
    <meta charset="UTF-8">
    <title>FashionShop</title>
    <!-- Link Font Awesome cho icon mạng xã hội -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    <!-- Link CSS giao diện của bạn -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .footer-container {
            display: flex;
            gap: 40px;
            max-width: 1200px;
            margin: 0 auto;
            flex-wrap: nowrap;
            align-items: flex-start;
        }
        .footer-form {
            max-width: 300px;
        }
        .footer-right-group {
            display: flex;
            gap: 40px;
            flex: 1;
        }
        .footer-right-group .footer-col {
            flex: 1;
        }
    </style>
</head>

<hr/>

<footer class="footer-main">
    <div class="footer-container">
        <!-- Cột 1: Logo + Form nhận tin + mô tả ngắn + payment icons -->
        <div class="footer-col footer-form">
            <img src="${pageContext.request.contextPath}/img/logo.png" alt="FashionShop Logo" class="footer-logo"/>
            <p class="footer-signup-title">Đăng ký nhận bản tin FashionShop để nhận ưu đãi mới nhất!</p>
            <p class="newsletter-desc" style="color:#ddd; font-size:14px; margin-bottom:10px;">
                Nhận ưu đãi độc quyền và tin tức mới nhất mỗi tuần.
            </p>
            <form action="${pageContext.request.contextPath}/subscribe-newsletter" method="post" class="newsletter-form">
                <div class="newsletter-row" style="display:flex;">
                    <input type="email" name="email" placeholder="Nhập email của bạn" required style="flex-grow:1; padding:10px; border:none; border-radius: 4px 0 0 4px;" />
                    <button type="submit" style="background-color:#ff4b5c; color:#fff; font-weight:bold; padding:10px 16px; border:none; cursor:pointer; border-radius: 0 4px 4px 0;">
                        Đăng ký
                    </button>
                </div>
                <c:if test="${not empty msg}">
                    <p class="footer-msg">${msg}</p>
                </c:if>
            </form>
            <p class="footer-contact" style="margin-top:15px;">
                Liên hệ: <a href="mailto:support@fashionshop.com" style="color:#ff4b5c;">support@fashionshop.com</a>
            </p>
            <div class="payment-icons" style="margin-top:20px;">
                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/VNPAY_Logo.svg/1200px-VNPAY_Logo.svg.png" alt="VnPay" style="height:40px; margin-right:15px;"/>
                <img src="https://www.gstatic.com/recaptcha/api2/logo_48.png" alt="reCAPTCHA" style="height:40px; vertical-align:middle;"/>
            </div>
        </div>
        
        <!-- Nhóm 4 cột bên phải gom lại thành 1 khối -->
        <div class="footer-right-group">
            <div class="footer-col">
                <h4>Sản phẩm</h4>
                <ul>
                    <li><a href="#">Tất cả sản phẩm</a></li>
                    <li><a href="#">Bộ sưu tập mới</a></li>
                    <li><a href="#">Khuyến mãi</a></li>
                    <li><a href="#">Bán chạy</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>Về FashionShop</h4>
                <ul>
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Tuyển dụng</a></li>
                    <li><a href="#">Tin tức</a></li>
                    <li><a href="#">Liên hệ</a></li>
                </ul>
            </div>
            <div class="footer-col">
                <h4>Thông tin cửa hàng</h4>
                <p>Địa chỉ: 123 Đường ABC, Quận XYZ, TP.HCM</p>
                <p>Hotline: 0123 456 789</p>
                <p>Email hỗ trợ: <a href="mailto:support@fashionshop.com" style="color:#ff4b5c;">support@fashionshop.com</a></p>
            </div>
            <div class="footer-store-info ">
                <div class="footer-col">
                <h4>Hỗ trợ</h4>
                <ul>
                    <li><a href="#">Chính sách bảo mật</a></li>
                    <li><a href="#">Chính sách đổi trả</a></li>
                    <li><a href="#">Câu hỏi thường gặp</a></li>
                    <li><a href="#">Hỗ trợ khách hàng</a></li>
                </ul>
            </div>
        </div>
    </div>
    
    <div class="footer-bottom">
        <div class="footer-social">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-tiktok"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
        </div>
        <p class="footer-copyright">&copy; 2025 FashionShop. All rights reserved.</p>
    </div>
</footer>
