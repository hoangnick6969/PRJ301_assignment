<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📨 Danh sách liên hệ từ người dùng</h2>

<table border="1" cellspacing="0" cellpadding="8" width="100%">
    <tr>
        <th>ID</th>
        <th>Họ tên</th>
        <th>Email</th>
        <th>Tiêu đề</th>
        <th>Nội dung</th>
        <th>Thời gian</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="m" items="${contactList}">
        <tr>
            <td>${m.id}</td>
            <td>${m.name}</td>
            <td>${m.email}</td>
            <td>${m.subject}</td>
            <td>${m.content}</td>
            <td>
                <fmt:formatDate value="${m.sentAt}" pattern="dd/MM/yyyy HH:mm" />
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/messages?action=delete&id=${m.id}"
                   onclick="return confirm('Xoá tin nhắn này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
