<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>⭐ Danh sách đánh giá</h2>

<table border="1" cellspacing="0" cellpadding="8" width="100%">
    <tr>
        <th>ID</th>
        <th>Sản phẩm</th>
        <th>Người đánh giá</th>
        <th>Số sao</th>
        <th>Bình luận</th>
        <th>Thời gian</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="r" items="${reviewList}">
        <tr>
            <td>${r.id}</td>
            <td>${r.product.name}</td>
            <td>${r.customer.name}</td>
            <td>${r.rating}</td>
            <td>${r.comment}</td>
            <td>${r.createdAt}</td>
            <td>
                <a href="review?action=delete&id=${r.id}" onclick="return confirm('Xoá đánh giá này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
