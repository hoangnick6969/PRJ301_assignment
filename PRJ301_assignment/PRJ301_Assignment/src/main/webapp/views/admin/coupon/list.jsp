<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/views/admin/common/header.jsp" />

<h2>🏷️ Danh sách mã giảm giá</h2>

<a href="${pageContext.request.contextPath}/admin/coupons?action=add">➕ Thêm mã giảm giá</a>

<table border="1" cellspacing="0" cellpadding="8" width="100%" style="margin-top:10px;">
    <tr>
        <th>ID</th>
        <th>Mã</th>
        <th>Giảm (%)</th>
        <th>Ngày hết hạn</th>
        <th>Thao tác</th>
    </tr>

    <c:forEach var="c" items="${couponList}">
        <tr>
            <td>${c.id}</td>
            <td>${c.code}</td>
            <td>${c.discount}</td>
            <td>${c.expiryDate}</td>
            <td>
                <a href="coupons?action=edit&id=${c.id}">✏️ Sửa</a> |
                <a href="coupons?action=delete&id=${c.id}" onclick="return confirm('Xoá mã này?')">🗑 Xoá</a>
            </td>
        </tr>
    </c:forEach>
</table>

<jsp:include page="/views/admin/common/footer.jsp" />
