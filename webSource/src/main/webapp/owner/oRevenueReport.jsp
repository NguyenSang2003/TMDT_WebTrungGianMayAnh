<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.util.ArrayList, model.RevenueReportView, model.User, model.UserProfile, java.math.BigDecimal" %>
<%@ page import="com.google.gson.Gson" %>
<%
    User owner = (User) session.getAttribute("user");
    if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    UserProfile profile = (UserProfile) request.getAttribute("ownerProfile");
    String fullName = (profile != null && profile.getFullName() != null) ? profile.getFullName() : owner.getUsername();
    String avatarPath = (profile != null && profile.getIdCardImageUrl() != null && !profile.getIdCardImageUrl().isEmpty())
            ? profile.getIdCardImageUrl()
            : "assets/images/default_avatar.png";
%>
<html>
<head>
    <title>Báo cáo doanh thu</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/owner.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .chart-container {
            display: flex;
            justify-content: space-between;
            gap: 20px;
            margin: 20px 0;
        }

        .chart-left, .chart-right {
            flex: 1;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        .chart-left canvas,
        .chart-right canvas {
            max-width: 100%;
            height: auto !important;
        }
    </style>
</head>
<body>
<div class="sidebar">
    <h4>EagleCam Selection 365</h4>
    <a href="bookings">📅 Quản lý đặt thuê</a>
    <a href="comments">💬 Quản lý bình luận</a>
    <a href="customers">👥 Quản lý khách hàng</a>
    <a href="orders">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport" class="active">📈 Doanh thu</a>
    <a href="reportsManagement.jsp">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>

    <div class="owner-profile">
        <a href="<%= request.getContextPath() %>/profile" style="text-decoration: none; color: white;">
            <img src="<%= request.getContextPath() %>/<%= avatarPath %>" alt="Avatar">
            <span><%= fullName %></span>
        </a>
    </div>
</div>

<div class="container">
    <p>Owner >> Doanh thu</p>
    <h2>Báo cáo doanh thu theo thời gian</h2>

    <form method="get" action="<%= request.getContextPath() %>/owner/oRevenueReport">
        <label for="from">Từ ngày:</label>
        <input type="date" id="from" name="from" value="<%= request.getAttribute("fromDate") != null ? request.getAttribute("fromDate") : "" %>" required>
        <label for="to">Đến ngày:</label>
        <input type="date" id="to" name="to" value="<%= request.getAttribute("toDate") != null ? request.getAttribute("toDate") : "" %>" required>
        <button type="submit">Xem</button>
    </form>


    <hr>

    <table>
        <tr>
            <th>#</th>
            <th>Sản phẩm</th>
            <th>Số lượng</th>
            <th>Doanh thu</th>
            <th>Ngày đặt</th>
        </tr>
        <%
            List<RevenueReportView> list = (List<RevenueReportView>) request.getAttribute("revenueList");
            BigDecimal total = (BigDecimal) request.getAttribute("totalRevenue");
            int i = 1;
            List<String> productNames = new ArrayList<>();
            List<BigDecimal> revenues = new ArrayList<>();
            if (list != null && !list.isEmpty()) {
                for (RevenueReportView r : list) {
                    productNames.add(r.getProductName());
                    revenues.add(r.getTotalRevenue());
        %>
        <tr>
            <td><%= i++ %></td>
            <td><%= r.getProductName() %></td>
            <td><%= r.getQuantity() %></td>
            <td><%= r.getTotalRevenue() %></td>
            <td><%= r.getRentDate() %></td>
        </tr>
        <%      }
        } else { %>
        <tr>
            <td colspan="5">Không có dữ liệu trong khoảng thời gian đã chọn.</td>
        </tr>
        <% } %>
        <tr>
            <td colspan="3"><strong>Tổng doanh thu:</strong></td>
            <td colspan="2"><strong><%= total != null ? total : "0" %> VND</strong></td>
        </tr>
    </table>

    <%
        if (list != null && !list.isEmpty()) {
            Gson gson = new Gson();
            String labelJson = gson.toJson(productNames);
            String dataJson = gson.toJson(revenues);
    %>
    <div class="chart-container">
        <div class="chart-left">
            <h4>Biểu đồ cột: Doanh thu theo sản phẩm</h4>
            <canvas id="barChart"></canvas>
        </div>
        <div class="chart-right">
            <h4>Biểu đồ tròn: Tỷ lệ doanh thu theo sản phẩm</h4>
            <canvas id="pieChart"></canvas>
        </div>
    </div>
    <script>
        const labels = <%= labelJson %>;
        const data = <%= dataJson %>;

        new Chart(document.getElementById('barChart'), {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Doanh thu (VNĐ)',
                    data: data,
                    borderWidth: 1,
                    backgroundColor: '#2f7dd4'
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: { display: true, text: 'Biểu đồ cột: Doanh thu theo sản phẩm' }
                },
                scales: {
                    y: { beginAtZero: true }
                }
            }
        });

        new Chart(document.getElementById('pieChart'), {
            type: 'pie',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Tỷ lệ doanh thu',
                    data: data
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    title: { display: true, text: 'Biểu đồ tròn: Tỷ lệ doanh thu theo sản phẩm' }
                }
            }
        });
    </script>
    <% } %>
</div>
</body>
</html>
