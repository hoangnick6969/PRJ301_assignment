<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../common/header.jsp" />

<h2>❤ Danh sách yêu thích</h2>

<c:choose>
    <c:when test="${empty wishlist}">
        <p>Bạn chưa thêm sản phẩm nào vào danh sách yêu thích.</p>
    </c:when>
    <c:otherwise>
        <div class="product-grid">
            <c:forEach var="p" items="${wishlist}">
                <div class="product-card">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                        <img src="${pageContext.request.contextPath}/${p.mainImage}" width="200" />
                        <h4>${p.name}</h4>
                        <p>${p.price} VND</p>
                    </a>
                    <form action="${pageContext.request.contextPath}/remove-from-wishlist" method="post">
                        <input type="hidden" name="productId" value="${p.id}" />
                        <button type="submit">❌ Bỏ thích</button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>

<jsp:include page="../../common/footer.jsp" />
