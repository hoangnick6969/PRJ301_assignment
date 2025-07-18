<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>
    <c:choose>
        <c:when test="${coupon != null}">✏️ Cập nhật mã giảm giá</c:when>
        <c:otherwise>➕ Thêm mã giảm giá</c:otherwise>
    </c:choose>
</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/coupons">
    <input type="hidden" name="id" value="${coupon.id}" />

    <label>Mã giảm giá:</label><br/>
    <input type="text" name="code" value="${coupon.code}" required /><br/><br/>

    <label>Giảm giá (%):</label><br/>
    <input type="number" name="discountPercent" min="1" max="100" value="${coupon.discountPercent}" required /><br/><br/>

    <label>Ngày hết hạn:</label><br/>
    <input type="date" name="expiryDate" value="${coupon.expiryDate}" required /><br/><br/>

    <button type="submit">Lưu</button>
</form>

<jsp:include page="/views/admin/common/footer.jsp" />
