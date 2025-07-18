<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../../common/header.jsp" />

<h2>📞 Liên hệ với chúng tôi</h2>

<c:if test="${not empty success}">
    <p style="color: green;">${success}</p>
</c:if>

<form action="${pageContext.request.contextPath}/contact" method="post">
    <label>Họ tên:</label><br/>
    <input type="text" name="name" required><br/><br/>

    <label>Email:</label><br/>
    <input type="email" name="email" required><br/><br/>

    <label>Chủ đề:</label><br/>
    <input type="text" name="subject"><br/><br/>

    <label>Nội dung:</label><br/>
    <textarea name="message" rows="5" cols="50" required></textarea><br/><br/>

    <button type="submit">Gửi liên hệ</button>
</form>

<jsp:include page="../../common/footer.jsp" />
