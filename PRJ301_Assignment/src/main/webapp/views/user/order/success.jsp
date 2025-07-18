<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/views/common/header.jsp" />

<h2>Đặt hàng thành công!</h2>
<p>Cảm ơn bạn đã mua sắm tại cửa hàng của chúng tôi.</p>
<a href="${pageContext.request.contextPath}/home">Quay về trang chủ</a>

<jsp:include page="/views/common/footer.jsp" />
