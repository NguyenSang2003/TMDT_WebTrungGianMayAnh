<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Comment" %>
<%@ page import="java.util.List" %>
<%
    List<Comment> commentList = (List<Comment>) request.getAttribute("commentList");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý bình luận</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="../ownerAssets/css/style.css">

</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>Trang quản lý</h4>
    <a href="bookingManagement">📅 Quản lý đặt thuê</a>
    <a href="commentManagement" class="active">💬 Quản lý bình luận</a>
    <a href="customerManagement">👥 Quản lý khách hàng</a>
    <a href="oOdersManagement">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📊 Doanh thu</a>
    <a href="reportsManagement">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
</div>

<!-- Content -->
<div class="content">
    <div class="card">
        <div class="card-header">
            <span>Danh sách bình luận</span>
            <span>Mới nhất →</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>Sản phẩm</th>
                <th>Người bình luận</th>
                <th>Nội dung</th>
                <th>Ngày</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (commentList != null && !commentList.isEmpty()) {
                    for (Comment c : commentList) {
            %>
            <tr>
                <td><%= c.getProductName() %></td>
                <td><%= c.getCommenterName() %></td>
                <td><%= c.getComment() %></td>
                <td><%= c.getCreatedAt() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="4" class="text-center">Không có bình luận nào.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
