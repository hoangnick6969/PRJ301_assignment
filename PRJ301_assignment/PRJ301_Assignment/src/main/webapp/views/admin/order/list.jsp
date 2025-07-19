<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
            <td><fmt:formatNumber value="${o.total}" type="currency" currencySymbol="₫" maxFractionDigits="0" /></td>
            <td>
                <c:choose>
                    <c:when test="${o.status == 'PENDING'}">🕒 Chờ xử lý</c:when>
                    <c:when test="${o.status == 'CONFIRMED'}">✅ Đã xác nhận</c:when>
                    <c:when test="${o.status == 'SHIPPED'}">🚚 Đang giao</c:when>
                    <c:when test="${o.status == 'DELIVERED'}">📦 Đã giao</c:when>
                    <c:when test="${o.status == 'CANCELLED'}">❌ Đã hủy</c:when>
                    <c:when test="${o.status == 'FAILED'}">⚠️ Giao thất bại</c:when>
                    <c:otherwise>${o.status}</c:otherwise>
                </c:choose>
            </td>
            <td>
                <a href="${pageContext.request.contextPath}/admin/orders?action=detail&id=${o.id}">🔍 Xem</a> |
                <a href="${pageContext.request.contextPath}/admin/orders?action=edit&id=${o.id}">📝 Trạng thái</a> |
                <a href="${pageContext.request.contextPath}/admin/orders?action=delete&id=${o.id}"
                   onclick="return confirm('Xóa đơn hàng này?')">🗑 Xóa</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
