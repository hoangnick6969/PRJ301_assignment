<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>👥 Danh sách khách hàng</h2>

<table border="1" cellspacing="0" cellpadding="8" width="100%">
    <tr>
        <th>ID</th>
        <th>Tên</th>
        <th>Email</th>
        <th>SĐT</th>
        <th>Địa chỉ</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="c" items="${customerList}">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>
            <td>${c.email}</td>
            <td>${c.phone}</td>
            <td>${c.address}</td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/orders?customerId=${c.id}">📦 Xem đơn hàng</a> |
                <a href="${pageContext.request.contextPath}/admin/customers?action=delete&id=${c.id}"
                   onclick="return confirm('Xoá khách hàng này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
