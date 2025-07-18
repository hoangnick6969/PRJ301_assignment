<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/common/header.jsp" />

<h2>👤 Thông tin tài khoản</h2>

<c:if test="${not empty success}">
    <p style="color:green">${success}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/profile" method="post">
    <label>Họ tên:</label><br/>
    <input type="text" name="name" value="${user.name}" required /><br/><br/>

    <label>Email:</label><br/>
    <input type="email" name="email" value="${user.email}" readonly /><br/><br/>

    <label>Điện thoại:</label><br/>
    <input type="text" name="phone" value="${user.phone}" /><br/><br/>

    <label>Địa chỉ:</label><br/>
    <textarea name="address" rows="3">${user.address}</textarea><br/><br/>

    <button type="submit">💾 Cập nhật</button>
</form>

<jsp:include page="/views/common/footer.jsp" />
