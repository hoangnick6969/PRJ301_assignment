<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>
    <c:choose>
        <c:when test="${blog != null}">✏️ Cập nhật bài viết</c:when>
        <c:otherwise>➕ Thêm bài viết mới</c:otherwise>
    </c:choose>
</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/blogs">
    <input type="hidden" name="id" value="${blog.id}" />

    <label>Tiêu đề:</label><br/>
    <input type="text" name="title" value="${blog.title}" required /><br/><br/>

    <label>Link ảnh (thumbnail):</label><br/>
    <input type="text" name="thumbnail" value="${blog.thumbnail}" /><br/><br/>

    <label>Nội dung:</label><br/>
    <textarea name="content" rows="10" cols="80" required>${blog.content}</textarea><br/><br/>

    <button type="submit">Lưu</button>
</form>

<jsp:include page="/views/admin/common/footer.jsp" />
