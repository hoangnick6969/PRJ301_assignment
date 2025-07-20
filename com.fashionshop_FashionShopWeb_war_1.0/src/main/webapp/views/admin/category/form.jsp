<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>
    <c:choose>
        <c:when test="${category != null}">✏️ Cập nhật danh mục</c:when>
        <c:otherwise>➕ Thêm danh mục</c:otherwise>
    </c:choose>
</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/categories" style="max-width: 400px;">
    <input type="hidden" name="id" value="${category.id}" />

    <label for="name">Tên danh mục:</label><br/>
    <input type="text" id="name" name="name" value="${category.name}" required style="width: 100%; padding: 8px; margin-top: 5px;" /><br/><br/>

    <button type="submit" style="padding: 8px 16px;">💾 Lưu</button>
</form>

<jsp:include page="/views/admin/common/footer.jsp" />
