<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head><title>Đánh giá sản phẩm</title></head>
<body>
    <h2>Đánh giá cho sản phẩm: ${product.name}</h2>

    <c:forEach var="review" items="${reviews}">
        <div>
            <strong>${review.customer.name}</strong> - ★ ${review.rating}<br/>
            <p>${review.comment}</p>
        </div>
        <hr/>
    </c:forEach>
</body>
</html>
