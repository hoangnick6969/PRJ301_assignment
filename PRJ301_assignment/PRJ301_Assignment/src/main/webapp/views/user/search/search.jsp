<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../common/header.jsp" />

<h2>🔍 Kết quả tìm kiếm cho từ khóa: <em>${param.keyword}</em></h2>

<c:choose>
    <c:when test="${empty results}">
        <p>Không tìm thấy sản phẩm phù hợp.</p>
    </c:when>
    <c:otherwise>
        <div class="product-grid">
            <c:forEach var="p" items="${results}">
                <div class="product-card">
                    <a href="${pageContext.request.contextPath}/product-detail?id=${p.id}">
                        <img src="${pageContext.request.contextPath}/${p.mainImage}" width="200" />
                        <h4>${p.name}</h4>
                        <p>${p.price} VND</p>
                    </a>
                </div>
            </c:forEach>
        </div>
    </c:otherwise>
</c:choose>
        
<jsp:include page="../../common/footer.jsp" />
