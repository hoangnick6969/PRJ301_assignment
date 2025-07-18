<hr/>
<footer>
    <p>&copy; 2025 FashionShop. All rights reserved.</p>
    <p>Liên h?: <a href="mailto:support@fashionshop.com">support@fashionshop.com</a></p>
    <form action="${pageContext.request.contextPath}/subscribe-newsletter" method="post">
        <label>Email:</label>
        <input type="email" name="email" required />
        <button type="submit">Nh?n b?n tin</button>
    </form>
    <c:if test="${not empty msg}">
        <p style="color:green">${msg}</p>
    </c:if>

</footer>
</body>
</html>
