<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/views/admin/common/header.jsp" />

<h2>📊 Dashboard - Thống kê nhanh</h2>
<ul>
    <li><strong>Tổng số sản phẩm:</strong> ${productCount}</li>
    <li><strong>Tổng đơn hàng:</strong> ${orderCount}</li>
    <li><strong>Tổng người dùng:</strong> ${customerCount}</li>
</ul>

<hr/><ul>
    <li><strong>Tổng số sản phẩm:</strong> ${productCount}</li>
    <li><strong>Tổng đơn hàng:</strong> ${orderCount}</li>
    <li><strong>Tổng người dùng:</strong> ${customerCount}</li>
</ul>

<h3>📈 Doanh thu 6 tháng gần nhất</h3>
<canvas id="revenueChart" width="800" height="300"></canvas>

    <!-- Chart.js -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    const ctx = document.getElementById('revenueChart').getContext('2d');
    const revenueChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: [
                <c:forEach var="entry" items="${revenueMap}">
                    '${entry.key}',
                </c:forEach>
            ],
            datasets: [{
                label: 'Doanh thu (VND)',
                data: [
                    <c:forEach var="entry" items="${revenueMap}">
                        ${entry.value},
                    </c:forEach>
                ],
                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        callback: function(value) {
                            return value.toLocaleString('vi-VN') + ' ₫';
                        }
                    }
                }
            }
        }
    });
</script>

<jsp:include page="/views/admin/common/footer.jsp" />
