<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/user/common/header.jsp" />

<h2>🔐 Đăng nhập</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/login" method="post">
    <label>Email:</label><br/>
    <input type="email" name="email" required /><br/><br/>

    <label>Mật khẩu:</label><br/>
    <input type="password" name="password" required /><br/><br/>

    <button type="submit">Đăng nhập</button>
</form>

<p>Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>

<jsp:include page="/user/common/footer.jsp" />
