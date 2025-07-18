<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/user/common/header.jsp" />

<h2>✨ Khuyến mãi nổi bật</h2>
<div class="slider">
    <c:forEach var="banner" items="${banners}">
        <div class="slide">
            <a href="${pageContext.request.contextPath}/${banner.link}">
                <img src="${pageContext.request.contextPath}/${banner.image}" alt="${banner.title}" width="100%" />
                <h3>${banner.title}</h3>
            </a>
        </div>
    </c:forEach>
</div>

<hr/>

<h2>🛍️ Sản phẩm mới</h2>
<div class="product-grid">
    <c:forEach var="p" items="${newProducts}">
        <div class="product-card">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                <img src="${pageContext.request.contextPath}/${p.mainImage}" alt="${p.name}" width="200" />
                <h4>${p.name}</h4>
                <p>${p.price} VND</p>
            </a>
        </div>
    </c:forEach>
</div>

<jsp:include page="/user/common/footer.jsp" />
