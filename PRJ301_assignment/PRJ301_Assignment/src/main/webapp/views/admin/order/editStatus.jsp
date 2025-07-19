<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📝 Cập nhật trạng thái đơn hàng</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/orders?action=updateStatus">
    <input type="hidden" name="id" value="${order.id}" />

    <label>Khách hàng:</label>
    <p>${order.customer.name}</p>

    <label>Ngày đặt:</label>
    <p>${order.orderDate}</p>

    <label>Tổng tiền:</label>
    <p>${order.total} VND</p>

    <label>Trạng thái:</label>
    <select name="status" required>
        <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>🕒 Chờ xử lý</option>
        <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>✅ Đã xác nhận</option>
        <option value="SHIPPED" ${order.status == 'SHIPPED' ? 'selected' : ''}>🚚 Đang giao</option>
        <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>📦 Đã giao</option>
        <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>❌ Đã hủy</option>
        <option value="FAILED" ${order.status == 'FAILED' ? 'selected' : ''}>⚠️ Giao thất bại</option>
    </select><br/><br/>

    <button type="submit">💾 Cập nhật</button>
</form>

<jsp:include page="/views/admin/common/footer.jsp" />
