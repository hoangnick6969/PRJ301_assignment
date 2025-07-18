<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📨 Danh sách liên hệ từ người dùng</h2>

<table border="1" cellspacing="0" cellpadding="8" width="100%">
    <tr>
        <th>ID</th>
        <th>Họ tên</th>
        <th>Email</th>
        <th>Nội dung</th>
        <th>Thời gian</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="m" items="${contactList}">
        <tr>
            <td>${m.id}</td>
            <td>${m.name}</td>
            <td>${m.email}</td>
            <td>${m.message}</td>
            <td>${m.createdAt}</td>
            <td>
                <a href="contacts?action=delete&id=${m.id}" onclick="return confirm('Xoá tin nhắn này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
