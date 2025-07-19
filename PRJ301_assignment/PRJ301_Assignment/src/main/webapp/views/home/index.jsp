<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/views/common/header.jsp" />
<head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="ie=edge">
    <title>Fashion Shop</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- Favicon/logo động -->
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/img/logo.png">
    <link rel="stylesheet" href="/css/plugins.css">
    <link rel="stylesheet" href="/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>

<!-- Banner khuyến mãi full width (background động) -->
<section class="promo-banner-section-fullwidth">
    <div class="container"></div>
    <c:choose>
        <c:when test="${not empty banners}">
            <div class="animated-promo-banner-fullwidth"
                 style="background: url('${pageContext.request.contextPath}/${banners[0].image}') center center/cover no-repeat;">
        </c:when>
        <c:otherwise>
            <div class="animated-promo-banner-fullwidth"
                 style="background: url('${pageContext.request.contextPath}/img/banner.jpg') center center/cover no-repeat;">
        </c:otherwise>
    </c:choose>
        <div class="banner-bg-effects">
            <div class="floating-element"></div><div class="floating-element"></div>
            <div class="floating-element"></div><div class="floating-element"></div>
            <div class="floating-element"></div>
        </div>
        <div class="light-sweep"></div>
        <div class="sparkle-effects">
            <div class="sparkle"></div><div class="sparkle"></div>
            <div class="sparkle"></div><div class="sparkle"></div>
        </div>
        <div class="banner-icons">
            <div class="icon-decoration">🌟</div>
            <div class="icon-decoration">💎</div>
            <div class="icon-decoration">✨</div>
        </div>
        <div class="banner-content-wrapper">
            <h1 class="promo-main-title">SALE UP TO 70%</h1>
            <p class="promo-subtitle">Khuyến mãi cực khủng - Chỉ có tại FashionShop</p>
            <a href="${pageContext.request.contextPath}/shop" class="promo-cta-btn">MUA NGAY</a>
        </div>
    </div>
</section>

<!-- Slider Banner (carousel) -->
<c:if test="${not empty banners}">
<section class="slider_area slider_style home_three_slider">
    <div class="banner-carousel owl-carousel">
        <c:forEach var="banner" items="${banners}">
            <div class="single_slider" data-bgimg="${pageContext.request.contextPath}/${banner.image}">
                <div class="container">
                    <div class="row align-items-center">
                        <div class="col-12">
                            <div class="slider_content">
                                <img src="${pageContext.request.contextPath}/${banner.image}" alt="${banner.title}" style="width:100%;max-height:400px;object-fit:cover;border-radius:20px;margin-bottom:10px;">
                                <h3>${banner.title}</h3>
                                <p>${banner.description}</p>
                                <a href="${pageContext.request.contextPath}/${banner.link}" class="button">Xem ngay</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</section>
</c:if>

<!-- Danh mục nổi bật -->
<c:if test="${not empty categories}">
<section class="category_section section-ptb">
    <div class="container">
        <div class="section_title">
            <h2>Danh mục nổi bật</h2>
        </div>
        <div class="row">
            <c:forEach var="cat" items="${categories}">
                <div class="col-lg-3 col-md-4 col-sm-6">
                    <div class="single_category" style="text-align:center;">
                        <img src="${pageContext.request.contextPath}/${cat.image}" alt="${cat.name}" style="width:120px;height:120px;object-fit:cover;border-radius:50%;margin-bottom:10px;">
                        <h4>${cat.name}</h4>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
</c:if>

<!-- Sản phẩm mới -->
<section class="product_section section-ptb">
    <div class="container">
        <div class="section_title">
            <h2>🛍️ Sản phẩm mới</h2>
        </div>
        <div class="row">
            <!-- DEBUG info -->
            <div class="col-12" style="background: #ffeb3b; padding: 10px; margin-bottom: 20px;">
                <strong>🔍 BACKEND DEBUG:</strong><br>
                - Số sản phẩm: ${fn:length(newProducts)}<br>
                - Data empty? ${empty newProducts ? 'YES' : 'NO'}<br>
                - First product: ${not empty newProducts ? newProducts[0].name : 'N/A'}
            </div>
            <c:choose>
                <c:when test="${not empty newProducts}">
                    <c:forEach var="p" items="${newProducts}">
                        <div class="col-lg-3 col-md-4 col-sm-6">
                            <div class="single_product">
                                <div class="product_thumb">
                                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                                        <img src="${pageContext.request.contextPath}/${p.mainImage}" alt="${p.name}" style="width:100%;height:230px;object-fit:cover;border-radius:16px;">
                                    </a>
                                </div>
                                <div class="product_content">
                                    <h3><a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">${p.name}</a></h3>
                                    <span class="current_price">${p.price} VND</span>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12">
                        <div class="alert alert-warning text-center">
                            <h4>⚠️ Không có sản phẩm nào!</h4>
                            <p>Backend cần:</p>
                            <ul style="text-align: left; display: inline-block;">
                                <li>Kiểm tra Controller có truyền "newProducts" vào model không</li>
                                <li>Kiểm tra ProductService.getNewProducts() có trả về data không</li>
                                <li>Kiểm tra database có sản phẩm với status = 1 không</li>
                                <li>Kiểm tra đường dẫn hình ảnh sản phẩm</li>
                            </ul>
                        </div>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</section>

<!-- Blog nổi bật -->
<c:if test="${not empty posts}">
<section class="blog_section section-ptb">
    <div class="container">
        <div class="section_title">
            <h2>Tin tức nổi bật</h2>
        </div>
        <div class="row">
            <c:forEach var="post" items="${posts}">
                <div class="col-lg-4 col-md-6">
                    <div class="single_blog">
                        <a href="${pageContext.request.contextPath}/blog-detail?id=${post.id}">
                            <img src="${pageContext.request.contextPath}/${post.image}" alt="${post.title}" style="width:100%;height:180px;object-fit:cover;border-radius:16px;">
                        </a>
                        <div class="blog_content">
                            <h3><a href="${pageContext.request.contextPath}/blog-detail?id=${post.id}">${post.title}</a></h3>
                            <span class="blog_date">${post.createdDate}</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>
</c:if>

<!-- BACKEND NOTE: Thêm JavaScript libraries -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js"></script>
<script>
$(document).ready(function(){
    if (typeof $.fn.owlCarousel !== 'undefined') {
        $('.banner-carousel').owlCarousel({
            items: 1,
            loop: true,
            autoplay: true,
            autoplayTimeout: 4000,
            nav: true,
            dots: true,
            navText: ['<i class="fa fa-angle-left"></i>', '<i class="fa fa-angle-right"></i>']
        });
    } else {
        console.error('OwlCarousel not loaded!');
    }
});
</script>

<jsp:include page="/views/common/footer.jsp" />
