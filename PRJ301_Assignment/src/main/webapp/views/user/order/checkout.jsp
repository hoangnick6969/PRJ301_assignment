<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/user/common/header.jsp" />

<h2>🧾 Thanh toán đơn hàng</h2>

<form action="${pageContext.request.contextPath}/checkout" method="post">
    <label>Phương thức giao hàng:</label>
    <select name="shippingMethod" required>
        <c:forEach var="s" items="${shippingMethods}">
            <option value="${s.id}">${s.name} (${s.fee} VND)</option>
        </c:forEach>
    </select>
    <br/><br/>

    <label>Phương thức thanh toán:</label>
    <select name="paymentMethod" required>
        <c:forEach var="p" items="${paymentMethods}">
            <option value="${p.id}">${p.name}</option>
        </c:forEach>
    </select>
    <br/><br/>

    <button type="submit">✅ Xác nhận đặt hàng</button>
</form>

<jsp:include page="/user/common/footer.jsp" />
