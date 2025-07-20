<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/user/common/header.jsp" />

<h2>🗂️ Danh mục: ${category.name}</h2>

<div class="product-grid">
    <c:forEach var="p" items="${products}">
        <div class="product-card">
            <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                <img src="${pageContext.request.contextPath}/${p.mainImage}" alt="${p.name}" width="200" />
                <h4>${p.name}</h4>
                <p>${p.price} VND</p>
            </a>
        </div>
    </c:forEach>
</div>

<c:if test="${empty products}">
    <p>Không có sản phẩm nào trong danh mục này.</p>
</c:if>

<jsp:include page="/user/common/footer.jsp" />
