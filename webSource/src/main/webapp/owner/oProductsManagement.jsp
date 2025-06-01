<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.List" %>
<%
    List<Product> productList = (List<Product>) request.getAttribute("productList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý sản phẩm</title>
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
    <a href="oOdersManagement">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement" class="active">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📊 Doanh thu</a>
    <a href="reportsManagement">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
</div>

<!-- Content -->
<div class="content">
    <div class="card">
        <div class="card-header">
            <span>Danh sách sản phẩm</span>
            <span>Mới nhất →</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Tên sản phẩm</th>
                <th>Giá/ngày</th>
                <th>Số lượng</th>
                <th>Đã bán</th>
                <th>Lượt xem</th>
                <th>Trạng thái</th>
                <th>Ngày tạo</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (productList != null && !productList.isEmpty()) {
                    for (Product p : productList) {
            %>
            <tr>
                <td><%= p.getId() %></td>
                <td><%= p.getName() %></td>
                <td><%= p.getPricePerDay() %></td>
                <td><%= p.getQuantity() %></td>
                <td><%= p.getSoldCount() %></td>
                <td><%= p.getViewCount() %></td>
                <td><%= p.getStatus() %></td>
                <td><%= p.getCreatedAt() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="8" class="text-center">Không có sản phẩm nào.</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
