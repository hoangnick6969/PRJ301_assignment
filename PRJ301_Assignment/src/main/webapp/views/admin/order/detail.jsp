<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>📋 Chi tiết đơn hàng #${order.id}</h2>

<p><strong>Khách hàng:</strong> ${order.customer.name}</p>
<p><strong>Số điện thoại:</strong> ${order.customer.phone}</p>
<p><strong>Địa chỉ:</strong> ${order.customer.address}</p>
<p><strong>Ngày đặt:</strong> ${order.orderDate}</p>
<p><strong>Phương thức thanh toán:</strong> ${order.paymentMethod.name}</p>
<p><strong>Phương thức giao hàng:</strong> ${order.shippingMethod.name}</p>
<p><strong>Trạng thái:</strong> ${order.status}</p>

<h3>🧾 Sản phẩm đã đặt</h3>
<table border="1" cellpadding="8" width="100%">
    <tr>
        <th>Tên sản phẩm</th>
        <th>Đơn giá</th>
        <th>Số lượng</th>
        <th>Thành tiền</th>
    </tr>
    <c:forEach var="d" items="${orderDetails}">
        <tr>
            <td>${d.product.name}</td>
            <td>${d.price}</td>
            <td>${d.quantity}</td>
            <td>${d.price * d.quantity}</td>
        </tr>
    </c:forEach>
</table>

<p><strong>Tổng cộng:</strong> ${order.total} VND</p>

<a href="${pageContext.request.contextPath}/admin/orders">⬅ Quay lại danh sách</a>

<jsp:include page="/views/admin/common/footer.jsp" />
