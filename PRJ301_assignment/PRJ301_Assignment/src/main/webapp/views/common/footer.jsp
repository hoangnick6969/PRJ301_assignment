<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <title>FashionShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css"/>
    
</head>

<footer class="footer-main">
    <div class="footer-container">
        <!-- Form đăng ký -->
        <div class="footer-form">
            <div class="footer-logo">THE HSQ</div>
            <p class="footer-signup-title">
                Sign up for our weekly e-newsletter, The Roll Up, and get the latest news, offers and more.
            </p>
            
            <form action="${pageContext.request.contextPath}/subscribe-newsletter" method="post" class="newsletter-form">
                <div class="form-row">
                    <div class="form-group">
                        <label for="email">Email*</label>
                        <input type="email" id="email" name="email" required />
                    </div>
                    <div class="form-group">
                        <label for="firstName">First Name*</label>
                        <input type="text" id="firstName" name="firstName" required />
                    </div>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="country">Country*</label>
                        <select id="country" name="country" required>
                            <option value="">Select Country</option>
                            <option value="VN">Vietnam</option>
                            <option value="US">United States</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="language">Preferred Language*</label>
                        <select id="language" name="language" required>
                            <option value="">Select Language</option>
                            <option value="vi">Tiếng Việt</option>
                            <option value="en">English</option>
                        </select>
                    </div>
                </div>
                
                <div class="checkbox-group">
                    <input type="checkbox" id="newsletter" name="newsletter" required />
                    <label for="newsletter">Yes! Send me emails with news from The HSQ. *</label>
                </div>
                
                <p class="privacy-note">
                    We won't spam you, and we won't sell your info. You may unsubscribe at any time.<br><br>
                    Địa chỉ: 169 Huỳnh Tấn Phát, Phường Hòa Cường, Đà Nẵng<br>
                    Hotline: 0236345679 Email: support@thehsq.vn
                </p>
                
                <button type="submit" class="signup-btn">Sign Up</button>
            </form>
        </div>
        
        <!-- Menu links -->
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
                <h4>Fashion Shop</h4>
                <ul>
                    <li><a href="#">Giới thiệu</a></li>
                    <li><a href="#">Tuyển dụng</a></li>
                    <li><a href="#">Tin tức</a></li>
                    <li><a href="#">Liên hệ</a></li>
                </ul>
            </div>
            
            <div class="footer-col">
                <h4>Support</h4>
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
        <div class="footer-brands">            
            <img src="${pageContext.request.contextPath}/img/pay/vnpay.png" alt="VnPay" class="brand-logo">
            <img src="${pageContext.request.contextPath}/img/pay/momo.png" alt="Momo" class="brand-logo">
        </div>
        
        <div class="footer-social">
            <a href="#"><i class="fab fa-facebook-f"></i></a>
            <a href="#"><i class="fab fa-instagram"></i></a>
            <a href="#"><i class="fab fa-tiktok"></i></a>
            <a href="#"><i class="fab fa-youtube"></i></a>
        </div>
        
        <div class="language-selector">
            <img src="https://flagcdn.com/w20/vn.png" alt="VN Flag" class="language-flag">
            <span>VN / Tiếng Việt</span>
        </div>
    </div>
</footer>