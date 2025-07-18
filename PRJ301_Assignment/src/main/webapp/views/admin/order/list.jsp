<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📦 Danh sách đơn hàng</h2>

<table border="1" cellspacing="0" cellpadding="8" width="100%">
    <tr>
        <th>ID</th>
        <th>Khách hàng</th>
        <th>Ngày đặt</th>
        <th>Tổng tiền</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
    </tr>
    <c:forEach var="o" items="${orderList}">
        <tr>
            <td>${o.id}</td>
            <td>${o.customer.name}</td>
            <td><fmt:formatDate value="${o.orderDate}" pattern="dd/MM/yyyy" /></td>
            <td>${o.total} VND</td>
            <td>${o.status}</td>
            <td>
                <a href="orders?action=detail&id=${o.id}">🔍 Xem</a>
                |
                <a href="orders?action=delete&id=${o.id}" onclick="return confirm('Xóa đơn hàng này?')">🗑 Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
