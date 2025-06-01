<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Order" %>
<%@ page import="java.util.List" %>
<%
    List<Order> orderList = (List<Order>) request.getAttribute("orderList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../ownerAssets/css/style.css">
</head>
<body>
<!-- Sidebar -->
<div class="sidebar">
    <h4>Trang quản lý</h4>
    <a href="bookingManagement">📅 Quản lý đặt thuê</a>
    <a href="commentManagement">💬 Quản lý bình luận</a>
    <a href="customerManagement">👥 Quản lý khách hàng</a>
    <a href="oOdersManagement" class="active">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📊 Doanh thu</a>
    <a href="reportsManagement">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
</div>

<!-- Content -->
<div class="content">
    <div class="card">
        <div class="card-header">
            <span>Danh sách đơn hàng</span>
            <span>Mới nhất →</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Sản phẩm ID</th>
                <th>Người thuê ID</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Trạng thái</th>
                <th>Bắt đầu</th>
                <th>Kết thúc</th>
                <th>Ngày tạo</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (orderList != null && !orderList.isEmpty()) {
                    for (Order o : orderList) {
            %>
            <tr>
                <td><%= o.getId() %></td>
                <td><%= o.getProductId() %></td>
                <td><%= o.getRenterId() %></td>
                <td><%= o.getQuantity() %></td>
                <td><%= o.getTotalPrice() %></td>
                <td><%= o.getStatus() %></td>
                <td><%= o.getRentStart() %></td>
                <td><%= o.getRentEnd() %></td>
                <td><%= o.getCreatedAt() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="9" class="text-center">Không có đơn hàng nào.</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>