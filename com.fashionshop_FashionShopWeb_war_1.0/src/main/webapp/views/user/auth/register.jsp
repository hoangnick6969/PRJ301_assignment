    <%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/common/header.jsp" />

<h2>📝 Đăng ký tài khoản</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/register" method="post">
    <label>Họ tên:</label><br/>
    <input type="text" name="name" required /><br/><br/>

    <label>Email:</label><br/>
    <input type="email" name="email" required /><br/><br/>

    <label>Mật khẩu:</label><br/>
    <input type="password" name="password" required /><br/><br/>

    <label>Điện thoại:</label><br/>
    <input type="text" name="phone" /><br/><br/>

    <label>Địa chỉ:</label><br/>
    <textarea name="address" rows="3"></textarea><br/><br/>

    <button type="submit">Đăng ký</button>
</form>

<p>Đã có tài khoản? <a href="${pageContext.request.contextPath}/login">Đăng nhập</a></p>
<jsp:include page="/views/common/footer.jsp" />
