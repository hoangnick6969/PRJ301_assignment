<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h2>❌ Đã xảy ra lỗi!</h2>
<p>Vui lòng kiểm tra lại thao tác của bạn.</p>

<c:if test="${not empty error}">
    <p style="color:red;"><strong>Lỗi chi tiết:</strong> ${error}</p>
</c:if>

<a href="${pageContext.request.contextPath}/home">🔙 Quay về trang chủ</a>
