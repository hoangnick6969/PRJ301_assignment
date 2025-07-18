<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/admin/common/header.jsp" />

<h2>👤 Thông tin tài khoản Admin</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/profile">
    <label>Tên hiển thị:</label><br/>
    <input type="text" name="displayName" value="${admin.displayName}" required /><br/><br/>

    <h3>🔒 Đổi mật khẩu</h3>
    <label>Mật khẩu hiện tại:</label><br/>
    <input type="password" name="currentPassword" /><br/>

    <label>Mật khẩu mới:</label><br/>
    <input type="password" name="newPassword" /><br/>

    <label>Nhập lại mật khẩu mới:</label><br/>
    <input type="password" name="confirmPassword" /><br/><br/>

    <button type="submit">Cập nhật</button>
</form>

<!-- Thông báo -->
<c:if test="${not empty success}">
    <p style="color:green">${success}</p>
</c:if>
<c:if test="${not empty error}">
    <p style="color:red">${error}</p>
</c:if>

<jsp:include page="/views/admin/common/footer.jsp" />
