<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Withdrawal" %>
<%@ page import="java.util.List" %>
<%
    List<Withdrawal> withdrawalList = (List<Withdrawal>) request.getAttribute("withdrawalList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý rút tiền</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../ownerAssets/css/style.css">
</head>
<body>
<div class="sidebar">
    <h4>Trang quản lý</h4>
    <a href="bookingManagement">📅 Quản lý đặt thuê</a>
    <a href="commentManagement">💬 Quản lý bình luận</a>
    <a href="customerManagement">👥 Quản lý khách hàng</a>
    <a href="oOdersManagement">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📊 Doanh thu</a>
    <a href="reportsManagement">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement" class="active">💰 Rút tiền</a>
</div>
<div class="content">
    <div class="card">
        <div class="card-header">
            <span>Danh sách yêu cầu rút tiền</span>
            <span>Mới nhất →</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Số tiền</th>
                <th>Trạng thái</th>
                <th>Ngày yêu cầu</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (withdrawalList != null && !withdrawalList.isEmpty()) {
                    for (Withdrawal w : withdrawalList) {
            %>
            <tr>
                <td><%= w.getId() %></td>
                <td><%= w.getAmount() %> VNĐ</td>
                <td><%= w.getStatus() %></td>
                <td><%= w.getCreatedAt() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="4" class="text-center">Không có yêu cầu rút tiền nào.</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
