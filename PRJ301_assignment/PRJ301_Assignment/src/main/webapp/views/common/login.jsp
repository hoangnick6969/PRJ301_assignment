<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/common/header.jsp" />

<h2>🔐 Đăng nhập</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/login" method="post">
    <label>Email hoặc Tên đăng nhập:</label>
    <input type="text" name="email" required>

    <label>Mật khẩu:</label>
    <input type="password" name="password" required>
    <button type="submit">Đăng nhập</button>
</form>

<p>Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>

<jsp:include page="/views/common/footer.jsp" />
