    <%@ page contentType="text/html;charset=UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="views/common/header.jsp" />

    <h2>🛒 Giỏ hàng của bạn</h2>

    <c:choose>
        <c:when test="${empty cart}">
            <p>Giỏ hàng của bạn đang trống.</p>
        </c:when>
        <c:otherwise>
            <table border="1" cellpadding="10" cellspacing="0" width="100%">
                <thead>
                    <tr style="background:#f0f0f0">
                        <th>Ảnh</th>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Tổng</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="entry" items="${cart}">
                        <tr>
                            <td><img src="${pageContext.request.contextPath}/${entry.key.mainImage}" width="80"/></td>
                            <td>${entry.key.name}</td>
                            <td>${entry.key.price} VND</td>
                            <td>${entry.value}</td>
                            <td>${entry.key.price * entry.value} VND</td>
                            <td>
                                <a href="${pageContext.request.contextPath}/remove-from-cart?productId=${entry.key.id}" onclick="return confirm('Xóa sản phẩm này khỏi giỏ?')">
                                    ❌ Xóa
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="4" align="right"><strong>Tổng cộng:</strong></td>
                        <td colspan="2"><strong>${total} VND</strong></td>
                    </tr>
                </tbody>
            </table>

            <br/>
            <div style="text-align: right;">
                <a href="${pageContext.request.contextPath}/checkout">
                    <button>🧾 Tiến hành thanh toán</button>
                </a>
            </div>
        </c:otherwise>
    </c:choose>

<jsp:include page="views/common/header.jsp" />