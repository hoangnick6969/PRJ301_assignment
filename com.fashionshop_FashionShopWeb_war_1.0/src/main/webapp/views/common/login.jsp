    <%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <jsp:include page="/views/common/header.jsp" />
    
    <h2>🔐 Đăng nhập</h2>

    <c:if test="${not empty errorMessage}">
    <p style="color:red;">${errorMessage}</p>
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

    <a href="${pageContext.request.contextPath}/login-google">
        <img src="https://developers.google.com/identity/images/btn_google_signin_dark_normal_web.png" />
    </a>


    <p>Bạn chưa có tài khoản? <a href="${pageContext.request.contextPath}/register">Đăng ký ngay</a></p>

    <jsp:include page="/views/common/footer.jsp" />
    