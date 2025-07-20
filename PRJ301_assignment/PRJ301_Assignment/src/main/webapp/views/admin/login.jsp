<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Đăng nhập quản trị</title>
    <style>
        body { font-family: Arial; background-color: #f2f2f2; padding: 40px; }
        .login-box {
            width: 350px; margin: auto; background: white;
            padding: 20px; border-radius: 8px; box-shadow: 0 0 10px #ccc;
        }
        input[type=text], input[type=password] {
            width: 100%; padding: 8px; margin: 5px 0;
        }
        button {
            width: 100%; padding: 10px; background-color: #333;
            color: white; border: none; cursor: pointer;
        }
        button:hover { background-color: #555; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Admin Login</h2>
        <form method="post" action="${pageContext.request.contextPath}/admin-login">
            <label>Tài khoản:</label>
            <input type="text" name="username" required>

            <label>Mật khẩu:</label>
            <input type="password" name="password" required>

            <button type="submit">Đăng nhập</button>

            <c:if test="${not empty error}">
                <p style="color:red">${error}</p>
            </c:if>
        </form>
    </div>
</body>
</html>
