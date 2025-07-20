<%@ page contentType="text/html;charset=UTF-8" %>

<jsp:include page="/views/admin/common/header.jsp"/>

<h2 style="color: orange;">⚠️ 404 - Không tìm thấy</h2>
<p>Trang bạn yêu cầu không tồn tại hoặc đã bị xóa.</p>

<a href="${pageContext.request.contextPath}/admin/dashboard">🔙 Quay về Dashboard</a>

<jsp:include page="/views/admin/common/footer.jsp"/>
