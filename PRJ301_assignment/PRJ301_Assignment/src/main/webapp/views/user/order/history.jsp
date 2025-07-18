<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/common/header.jsp" />

<h2>📜 Lịch sử đơn hàng của bạn</h2>

<c:choose>
    <c:when test="${empty orders}">
        <p>Bạn chưa có đơn hàng nào.</p>
    </c:when>
    <c:otherwise>
        <table border="1" cellpadding="10" cellspacing="0" width="100%">
            <thead>
                <tr style="background:#f0f0f0">
                    <th>Mã đơn</th>
                    <th>Ngày đặt</th>
                    <th>Tổng tiền</th>
                    <th>Thanh toán</th>
                    <th>Giao hàng</th>
                    <th>Trạng thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="o" items="${orders}">
                    <tr>
                        <td>#${o.id}</td>
                        <td>${o.orderDate}</td>
                        <td>${o.total} VND</td>
                        <td>${o.paymentMethod.name}</td>
                        <td>${o.shippingMethod.name}</td>
                        <td>${o.status}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </c:otherwise>
</c:choose>

<jsp:include page="/views/common/footer.jsp" />
