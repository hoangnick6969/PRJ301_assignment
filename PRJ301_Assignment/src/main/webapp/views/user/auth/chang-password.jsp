<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Đổi mật khẩu</title>
</head>
<body>
    <h2>Đổi mật khẩu</h2>
    <form action="${pageContext.request.contextPath}/change-password" method="post">
        <label>Mật khẩu hiện tại:</label>
        <input type="password" name="currentPassword" required /><br/>

        <label>Mật khẩu mới:</label>
        <input type="password" name="newPassword" required /><br/>

        <label>Xác nhận mật khẩu mới:</label>
        <input type="password" name="confirmPassword" required /><br/>

        <button type="submit">Cập nhật</button>
    </form>

    <c:if test="${not empty error}">
        <p style="color:red">${error}</p>
    </c:if>
    <c:if test="${not empty success}">
        <p style="color:green">${success}</p>
    </c:if>
</body>
</html>
