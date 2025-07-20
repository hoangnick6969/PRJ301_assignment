<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../common/header.jsp" />

<h2>✍️ Viết đánh giá cho sản phẩm</h2>

<c:if test="${not empty success}">
    <p style="color:green">${success}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/submit-review" method="post">
    <input type="hidden" name="productId" value="${product.id}" />

    <h3>${product.name}</h3>
    <img src="${pageContext.request.contextPath}/${product.mainImage}" width="150"/><br/><br/>

    <label>Đánh giá (1–5 sao):</label><br/>
    <select name="rating" required>
        <c:forEach var="i" begin="1" end="5">
            <option value="${i}">${i} sao</option>
        </c:forEach>
    </select><br/><br/>

    <label>Bình luận:</label><br/>
    <textarea name="comment" rows="4" cols="50" placeholder="Nhận xét của bạn..." required></textarea><br/><br/>

    <button type="submit">Gửi đánh giá</button>
</form>

<jsp:include page="../../common/footer.jsp" />
