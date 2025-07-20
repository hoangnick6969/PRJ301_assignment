<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📝 Danh sách bài viết</h2>

<a href="${pageContext.request.contextPath}/admin/blogs?action=add">➕ Thêm bài viết mới</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Tiêu đề</th>
        <th>Tác giả</th>
        <th>Ngày đăng</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="b" items="${blogList}">
        <tr>
            <td>${b.id}</td>
            <td>${b.title}</td>
            <td>${b.author}</td>
            <td>${b.createdAt}</td>
            <td>
                <a href="blogs?action=edit&id=${b.id}">✏️ Sửa</a> |
                <a href="blogs?action=delete&id=${b.id}" onclick="return confirm('Xoá bài viết này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
