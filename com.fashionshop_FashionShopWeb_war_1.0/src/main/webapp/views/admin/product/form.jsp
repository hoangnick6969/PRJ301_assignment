<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>
    <c:choose>
        <c:when test="${product != null}">✏️ Cập nhật sản phẩm</c:when>
        <c:otherwise>➕ Thêm sản phẩm mới</c:otherwise>
    </c:choose>
</h2>

<form method="post" action="${pageContext.request.contextPath}/admin/products">
    <!-- Nếu không có product thì set id = 0 -->
    <input type="hidden" name="id" value="${product != null ? product.id : 0}" />

    <label>Tên sản phẩm:</label><br/>
    <input type="text" name="name" value="${product != null ? product.name : ''}" required /><br/>

    <label>Giá:</label><br/>
    <input type="number" name="price" value="${product != null ? product.price : ''}" required /><br/>

    <label>Ảnh chính:</label><br/>
    <input type="text" name="mainImage" value="${product != null ? product.mainImage : ''}" /><br/>

    <label>Mô tả:</label><br/>
    <textarea name="description">${product != null ? product.description : ''}</textarea><br/>

    <label>Danh mục:</label><br/>
    <select name="categoryId" required>
        <c:forEach var="c" items="${categories}">
            <c:choose>
                <c:when test="${product != null && product.category != null && product.category.id == c.id}">
                    <option value="${c.id}" selected>${c.name}</option>
                </c:when>
                <c:otherwise>
                    <option value="${c.id}">${c.name}</option>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </select><br/><br/>

    <button type="submit">Lưu</button>
</form>

<jsp:include page="/views/admin/common/footer.jsp" />
