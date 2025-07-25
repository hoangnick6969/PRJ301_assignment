<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📂 Danh sách danh mục sản phẩm</h2>

<a href="${pageContext.request.contextPath}/admin/categories?action=add">➕ Thêm danh mục</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Tên danh mục</th>
        <th>Mô tả</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="c" items="${categoryList}">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>
            <td>${c.description}</td>
            <td>
                <a href="categories?action=edit&id=${c.id}">✏️ Sửa</a> |
                <a href="categories?action=delete&id=${c.id}" onclick="return confirm('Xoá danh mục này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
