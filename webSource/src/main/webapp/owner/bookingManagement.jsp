<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*, model.BookingView" %>
<html>
<head>
    <title>Quản lý đặt thuê</title>
    <link rel="stylesheet" href="/webSource_war/assets/css_handMade/owner.css">

</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>Trang quản lý</h4>
    <a href="bookings">📅 Quản lý đặt thuê</a>
    <a href="comments" class="active">💬 Quản lý bình luận</a>
    <a href="customers">👥 Quản lý khách hàng</a>
    <a href="orders">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📊 Doanh thu</a>
    <a href="reportsManagement.jsp">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
</div>
<div class="container">
    <h2>Quản lý đặt thuê</h2>

    <p style="margin-bottom: 20px;">💡 Xem lịch booking: ngày rảnh, ngày trống của từng sản phẩm sẽ được hiển thị tại đây.</p>

    <table>
        <tr>
            <th>#</th>
            <th>Sản phẩm</th>
            <th>Người thuê</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th>Trạng thái</th>
        </tr>
        <%
            List<BookingView> list = (List<BookingView>) request.getAttribute("bookings");
            int i = 1;
            if (list != null && !list.isEmpty()) {
                for (BookingView b : list) {
        %>
        <tr>
            <td><%= i++ %></td>
            <td><%= b.getProductName() %></td>
            <td><%= b.getRenterName() %></td>
            <td><%= b.getRentStart() %></td>
            <td><%= b.getRentEnd() %></td>
            <td><%= b.getStatus() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6">Không có dữ liệu đặt thuê.</td>
        </tr>
        <% } %>
    </table>
</div>
</body>
</html>
