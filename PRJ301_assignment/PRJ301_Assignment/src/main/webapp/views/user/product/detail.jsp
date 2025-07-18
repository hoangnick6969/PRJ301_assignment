<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../common/header.jsp" />

<h2>${product.name}</h2>

<div class="product-detail">
    <img src="${pageContext.request.contextPath}/${product.mainImage}" width="300" />

    <div class="gallery">
        <c:forEach var="img" items="${images}">
            <img src="${pageContext.request.contextPath}/${img.imageUrl}" width="100" />
        </c:forEach>
    </div>

    <p>💰 Giá: ${product.price} VND</p>
    <p>${product.description}</p>

    <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
        <input type="hidden" name="productId" value="${product.id}" />
        Số lượng: <input type="number" name="quantity" value="1" min="1" />
        <button type="submit">🛒 Thêm vào giỏ</button>
    </form>
</div>

<hr/>

<c:if test="${param.reviewSuccess == '1'}">
    <p style="color:green">🎉 Đánh giá đã được gửi thành công!</p>
</c:if>
<c:if test="${param.reviewError == '1'}">
    <p style="color:red">❌ Gửi đánh giá thất bại. Vui lòng thử lại.</p>
</c:if>

<h3>📢 Đánh giá sản phẩm</h3>
<c:forEach var="r" items="${reviews}">
    <div class="review">
        <strong>${r.customer.name}</strong> – 
        ⭐ ${r.rating} / 5 <br/>
        <p>${r.comment}</p>
    </div>
</c:forEach>

<c:if test="${not empty sessionScope.user}">
    <hr/>
    <a href="${pageContext.request.contextPath}/review-form?productId=${product.id}">
        ✍️ Viết đánh giá
    </a>
</c:if>

<jsp:include page="../../common/footer.jsp" />
