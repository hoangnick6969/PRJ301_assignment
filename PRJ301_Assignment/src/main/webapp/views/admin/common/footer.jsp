
        </main>

        <footer class="admin-footer">
            <div class="footer-content">
                <div class="footer-grid">
                    <div class="footer-section">
                        <div class="footer-brand">
                            <div class="brand-logo">
                                <i class="fas fa-tools"></i>
                                <span>FashionShop Admin</span>
                            </div>
                            <p class="brand-description">
                                Hệ thống quản trị toàn diện cho cửa hàng thời trang hiện đại. 
                                Quản lý hiệu quả mọi hoạt động kinh doanh từ sản phẩm đến khách hàng.
                            </p>
                        </div>
                    </div>

                    <div class="footer-section">
                        <h4 class="section-title">
                            <i class="fas fa-cogs"></i>
                            Quản lý chính
                        </h4>
                        <ul class="footer-links">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/products">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Sản phẩm</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/categories">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Danh mục</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/orders">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Đơn hàng</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/customers">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Khách hàng</span>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="footer-section">
                        <h4 class="section-title">
                            <i class="fas fa-chart-line"></i>
                            Báo cáo & Thống kê
                        </h4>
                        <ul class="footer-links">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/dashboard">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Dashboard</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/reviews">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Đánh giá</span>
                                </a>
                            </li>
                            <li>
                                <a href="#" onclick="showComingSoon()">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Báo cáo doanh thu</span>
                                </a>
                            </li>
                            <li>
                                <a href="#" onclick="showComingSoon()">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Thống kê truy cập</span>
                                </a>
                            </li>
                        </ul>
                    </div>

                    <div class="footer-section">
                        <h4 class="section-title">
                            <i class="fas fa-tools"></i>
                            Công cụ hỗ trợ
                        </h4>
                        <ul class="footer-links">
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/blogs">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Quản lý Blog</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/banners">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Quản lý Banner</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/admin/contacts">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Tin nhắn liên hệ</span>
                                </a>
                            </li>
                            <li>
                                <a href="#" onclick="showComingSoon()">
                                    <i class="fas fa-angle-right"></i>
                                    <span>Cài đặt hệ thống</span>
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="footer-stats">
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">Thời gian hoạt động</div>
                            <div class="stat-value" id="uptime">24/7</div>
                        </div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">Bảo mật</div>
                            <div class="stat-value">SSL Secured</div>
                        </div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-server"></i>
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">Phiên bản</div>
                            <div class="stat-value">v2.1.0</div>
                        </div>
                    </div>
                    <div class="stat-item">
                        <div class="stat-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <div class="stat-info">
                            <div class="stat-label">Quyền truy cập</div>
                            <div class="stat-value">Administrator</div>
                        </div>
                    </div>
                </div>

                <div class="footer-bottom">
                    <div class="footer-copyright">
                        <p>
                            <i class="fas fa-copyright"></i>
                            2024 FashionShop Admin Panel. Phát triển bởi 
                            <strong>PRJ301 Team</strong>
                        </p>
                        <p class="tech-info">
                            Powered by Java EE • JSP • JPA • MySQL
                        </p>
                    </div>
                    <div class="footer-actions">
                        <button onclick="toggleDarkMode()" class="action-btn" title="Chế độ tối">
                            <i class="fas fa-moon"></i>
                        </button>
                        <button onclick="showSystemInfo()" class="action-btn" title="Thông tin hệ thống">
                            <i class="fas fa-info-circle"></i>
                        </button>
                        <a href="${pageContext.request.contextPath}/" class="action-btn" title="Xem trang chủ">
                            <i class="fas fa-external-link-alt"></i>
                        </a>
                    </div>
                </div>
            </div>
        </footer>
    </div>

    <style>
        .admin-footer {
            background: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            color: #ecf0f1;
            margin-top: auto;
            border-top: 4px solid #3498db;
        }

        .footer-content {
            max-width: 1400px;
            margin: 0 auto;
            padding: 3rem 2rem 1rem;
        }

        .footer-grid {
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .footer-section .section-title {
            color: #3498db;
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .footer-brand .brand-logo {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 1.5rem;
            font-weight: 700;
            color: #3498db;
            margin-bottom: 1rem;
        }

        .footer-brand .brand-logo i {
            font-size: 2rem;
        }

        .brand-description {
            color: #bdc3c7;
            line-height: 1.6;
            font-size: 0.95rem;
        }

        .footer-links {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .footer-links li {
            margin-bottom: 0.75rem;
        }

        .footer-links a {
            color: #bdc3c7;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            padding: 0.25rem 0;
        }

        .footer-links a:hover {
            color: #3498db;
            transform: translateX(5px);
        }

        .footer-links a i {
            font-size: 0.8rem;
            width: 12px;
        }

        .footer-stats {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 1.5rem;
            margin: 2rem 0;
            padding: 2rem;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            backdrop-filter: blur(10px);
        }

        .stat-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            text-align: center;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(45deg, #3498db, #2ecc71);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2rem;
        }

        .stat-info {
            flex: 1;
        }

        .stat-label {
            font-size: 0.8rem;
            color: #95a5a6;
            margin-bottom: 0.25rem;
        }

        .stat-value {
            font-weight: 600;
            color: #ecf0f1;
            font-size: 0.9rem;
        }

        .footer-bottom {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 2rem;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .footer-copyright p {
            margin: 0.25rem 0;
            color: #95a5a6;
            font-size: 0.9rem;
        }

        .tech-info {
            font-size: 0.8rem !important;
            color: #7f8c8d !important;
        }

        .footer-actions {
            display: flex;
            gap: 0.75rem;
        }

        .action-btn {
            width: 40px;
            height: 40px;
            border: none;
            background: rgba(255, 255, 255, 0.1);
            color: #bdc3c7;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
        }

        .action-btn:hover {
            background: #3498db;
            color: white;
            transform: translateY(-2px);
        }

        @media (max-width: 1024px) {
            .footer-grid {
                grid-template-columns: 1fr 1fr;
                gap: 1.5rem;
            }

            .footer-stats {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 768px) {
            .footer-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }

            .footer-stats {
                grid-template-columns: 1fr;
            }

            .footer-bottom {
                flex-direction: column;
                gap: 1rem;
                text-align: center;
            }

            .footer-content {
                padding: 2rem 1rem 1rem;
            }
        }
    </style>

    <script>
        function showComingSoon() {
            alert('Tính năng này sẽ được phát triển trong phiên bản tiếp theo!');
        }

        function toggleDarkMode() {
            // Placeholder for dark mode functionality
            alert('Chế độ tối sẽ được triển khai trong phiên bản tương lai!');
        }

        function showSystemInfo() {
            const info = `
                🖥️ Thông tin hệ thống:
                
                📊 CPU Usage: ${Math.floor(Math.random() * 50 + 20)}%
                💾 Memory Usage: ${Math.floor(Math.random() * 40 + 30)}%
                💿 Disk Space: ${Math.floor(Math.random() * 30 + 60)}% available
                🌐 Active Sessions: ${Math.floor(Math.random() * 20 + 5)}
                ⚡ Uptime: ${Math.floor(Math.random() * 100 + 500)} hours
                
                ✅ System Status: Healthy
            `;
            alert(info);
        }

        // Update uptime display
        function updateUptime() {
            const uptimeElement = document.getElementById('uptime');
            if (uptimeElement) {
                const hours = Math.floor(Math.random() * 1000 + 100);
                uptimeElement.textContent = `${hours}h`;
            }
        }

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            updateUptime();
            setInterval(updateUptime, 60000); // Update every minute
        });
    </script>
</body>
</html>
