<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📦 Danh sách sản phẩm</h2>

<a href="${pageContext.request.contextPath}/admin/product?action=add">
    ➕ Thêm sản phẩm mới
</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Giá</th>
        <th>Ảnh</th>
        <th>Danh mục</th>
        <th>Thao tác</th>
    </tr>
    <c:forEach var="p" items="${productList}">
        <tr>
            <td>${p.id}</td>
            <td>${p.name}</td>
            <td>${p.price} VND</td>
            <td><img src="${pageContext.request.contextPath}/${p.mainImage}" width="80"/></td>
            <td>${p.category.name}</td>
            <td>
                <a href="product?action=edit&id=${p.id}">✏️ Sửa</a> |
                <a href="product?action=delete&id=${p.id}" onclick="return confirm('Xoá sản phẩm này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
