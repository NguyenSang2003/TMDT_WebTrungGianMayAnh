<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Report" %>
<%@ page import="java.util.List" %>
<%
    List<Report> reportList = (List<Report>) request.getAttribute("reportList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý báo cáo</title>
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
    <a href="reportsManagement" class="active">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
</div>
<div class="content">
    <div class="card">
        <div class="card-header">
            <span>Danh sách báo cáo sản phẩm</span>
            <span>Mới nhất →</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Người báo cáo</th>
                <th>Lý do</th>
                <th>Ngày</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (reportList != null && !reportList.isEmpty()) {
                    for (Report r : reportList) {
            %>
            <tr>
                <td><%= r.getProductName() %></td>
                <td><%= r.getReporterName() %></td>
                <td><%= r.getReason() %></td>
                <td><%= r.getCreatedAt() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr><td colspan="4" class="text-center">Không có báo cáo nào.</td></tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
