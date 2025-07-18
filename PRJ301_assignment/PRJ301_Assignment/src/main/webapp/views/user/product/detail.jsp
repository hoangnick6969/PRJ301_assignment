<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="../../common/header.jsp" />

<h2>${product.name}</h2>

<div class="product-detail">

    <!-- Ảnh chính -->
    <c:choose>
        <c:when test="${not empty product.mainImage}">
            <img src="${pageContext.request.contextPath}/${product.mainImage}" width="300" />
        </c:when>
        <c:otherwise>
            <img src="${pageContext.request.contextPath}/images/default.jpg" width="300" />
        </c:otherwise>
    </c:choose>

    <!-- Ảnh phụ -->
    <div class="gallery">
        <c:forEach var="img" items="${images}">
            <c:choose>
                <c:when test="${not empty product.mainImage}">
                    <c:set var="imageUrl" value="${product.mainImage}" />
                </c:when>
                <c:otherwise>
                    <c:set var="imageUrl" value="images/default.jpg" />
                </c:otherwise>
            </c:choose>

            <img src="${pageContext.request.contextPath}/${imageUrl}" width="300" />
        </c:forEach>
    </div>

    <p>💰 Giá: ${product.price} VND</p>
    <p>${product.description}</p>

    <!-- Thêm vào giỏ -->
    <form action="${pageContext.request.contextPath}/add-to-cart" method="post">
        <input type="hidden" name="productId" value="${product.id}" />
        Số lượng: <input type="number" name="quantity" value="1" min="1" />
        <button type="submit">🛒 Thêm vào giỏ</button>
    </form>

    <!-- Thêm vào yêu thích -->
    <form action="${pageContext.request.contextPath}/add-to-wishlist" method="post" style="margin-top: 10px;">
        <input type="hidden" name="productId" value="${product.id}" />
        <button type="submit">❤ Thêm vào yêu thích</button>
    </form>

</div>

<hr/>

<!-- Thông báo đánh giá -->
<c:if test="${param.reviewSuccess == '1'}">
    <p style="color:green">🎉 Đánh giá đã được gửi thành công!</p>
</c:if>
<c:if test="${param.reviewError == '1'}">
    <p style="color:red">❌ Gửi đánh giá thất bại. Vui lòng thử lại.</p>
</c:if>

<!-- Danh sách đánh giá -->
<h3>📢 Đánh giá sản phẩm</h3>
<c:forEach var="r" items="${reviews}">
    <div class="review">
        <strong>${r.customer.name}</strong> – 
        ⭐ ${r.rating} / 5 <br/>
        <p>${r.comment}</p>
    </div>
</c:forEach>

<!-- Nút viết đánh giá -->
<c:if test="${not empty sessionScope.user}">
    <hr/>
    <a href="${pageContext.request.contextPath}/review-form?productId=${product.id}">
        ✍️ Viết đánh giá
    </a>
</c:if>

<jsp:include page="../../common/footer.jsp" />
