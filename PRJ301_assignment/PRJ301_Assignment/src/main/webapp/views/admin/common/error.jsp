<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/views/admin/common/header.jsp"/>

<h2 style="color: crimson;">❌ Lỗi hệ thống!</h2>
<p>Vui lòng kiểm tra lại thao tác của bạn.</p>

<c:if test="${not empty error}">
    <p style="color:red"><strong>Chi tiết lỗi:</strong> ${error}</p>
</c:if>

<a href="${pageContext.request.contextPath}/admin/dashboard">🔙 Quay về Dashboard</a>

<jsp:include page="/views/admin/common/footer.jsp"/>
