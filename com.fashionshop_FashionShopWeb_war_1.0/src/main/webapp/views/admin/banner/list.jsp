<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>🖼️ Danh sách banner</h2>

<a href="${pageContext.request.contextPath}/admin/banners?action=add">➕ Thêm banner mới</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Tiêu đề</th>
        <th>Hình ảnh</th>
        <th>Liên kết</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="b" items="${bannerList}">
        <tr>
            <td>${b.id}</td>
            <td>${b.title}</td>
            <td><img src="${pageContext.request.contextPath}/${b.image}" width="150"/></td>
            <td><a href="${b.link}" target="_blank">${b.link}</a></td>
            <td>
                <a href="banners?action=edit&id=${b.id}">✏️ Sửa</a> |
                <a href="banners?action=delete&id=${b.id}" onclick="return confirm('Xoá banner này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
