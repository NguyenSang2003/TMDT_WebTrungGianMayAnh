<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
    List<User> customerList = (List<User>) request.getAttribute("customerList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý khách hàng</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../ownerAssets/css/style.css">
</head>
<body>
<div class="sidebar">
    <h4>Trang quản lý</h4>
    <a href="bookingManagement">📅 Quản lý đặt thuê</a>
    <a href="commentManagement">💬 Quản lý bình luận</a>
    <a href="customerManagement" class="active">👥 Quản lý khách hàng</a>
    <a href="oOdersManagement">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📊 Doanh thu</a>
    <a href="reportsManagement">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
</div>
<div class="content">
    <div class="card">
        <div class="card-header">
            <span>Danh sách khách hàng</span>
            <span>Mới nhất →</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>Username</th>
                <th>Email</th>
                <th>Xác thực Gmail</th>
                <th>Trạng thái</th>
                <th>Ngày đăng ký</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (customerList != null && !customerList.isEmpty()) {
                    for (User u : customerList) {
            %>
            <tr>
                <td><%= u.getUsername() %></td>
                <td><%= u.getEmail() %></td>
                <td><%= u.isVerifyEmail() ? "✔" : "✖" %></td>
                <td><%= u.isActive() ? "Đang hoạt động" : "Bị khóa" %></td>
                <td><%= u.getCreatedAt() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="5" class="text-center">Không có khách hàng nào.</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
