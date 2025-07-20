<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>
    <c:choose>
        <c:when test="${category != null}">✏️ Cập nhật danh mục</c:when>
        <c:otherwise>➕ Thêm danh mục</c:otherwise>
    </c:choose>
</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/categories">
    <input type="hidden" name="id" value="${category.id}" />

    <label>Tên danh mục:</label><br/>
    <input type="text" name="name" value="${category.name}" required /><br/><br/>

    <button type="submit">Lưu</button>
</form>

<jsp:include page="/views/admin/common/footer.jsp" />
