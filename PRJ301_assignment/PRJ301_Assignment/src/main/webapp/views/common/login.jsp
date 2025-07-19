<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/common/header.jsp" />

<h2>🔐 Đăng nhập</h2>

<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<!-- Form đăng nhập truyền thống -->
<form action="${pageContext.request.contextPath}/login" method="post">
    <label>Email hoặc Tên đăng nhập:</label><br>
    <input type="text" name="email" required><br><br>

    <label>Mật khẩu:</label><br>
    <input type="password" name="password" required><br><br>

    <button type="submit">Đăng nhập</button>
</form>

<br>

<!-- HOẶC ĐĂNG NHẬP VỚI GOOGLE -->
<hr style="width:300px;">
<p>hoặc</p>

<a href="https://accounts.google.com/o/oauth2/auth?scope=email%20profile&redirect_uri=http://localhost:8080/PRJ301_Assignment/login-google-callback&response_type=code&client_id=310697196810-p53d42ua0mm2gdld2sfl2493m4ihvibg.apps.googleusercontent.com">
    <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png" alt="Đăng nhập bằng Google">
</a>

<p>Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>

<jsp:include page="/views/common/footer.jsp" />
