<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="../../common/header.jsp" />

<h2>📝 Bài viết mới nhất</h2>

<c:forEach var="blog" items="${blogs}">
    <div style="border-bottom:1px solid #ccc; padding: 10px 0;">
        <h3>${blog.title}</h3>
        <img src="${pageContext.request.contextPath}/${blog.thumbnail}" width="200"/>
        <p><i>${blog.createdAt}</i></p>
        <p>${fn:substring(blog.content, 0, 150)}...</p>
        <a href="#">Đọc tiếp</a>
    </div>
</c:forEach>

<jsp:include page="../../common/footer.jsp" />
