<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.BookingSchedule" %>
<%@ page import="java.util.List" %>

<%
    List<BookingSchedule> bookingList = (List<BookingSchedule>) request.getAttribute("bookingList");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Quản lý đặt thuê</title>
    <link rel="stylesheet" href="../assets/css/bootstrap.min.css">

    <link rel="stylesheet" href="../ownerAssets/css/style.css">
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>Trang quản lý</h4>
    <a href="bookingManagement" class="active">📅 Quản lý đặt thuê</a>
    <a href="commentManagement">💬 Quản lý bình luận</a>
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
            <span>Danh sách đặt thuê</span>
            <span>Lịch sử →</span>
        </div>
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Sản phẩm</th>
                <th>Người thuê</th>
                <th>Người cho thuê</th>
                <th>Bắt đầu</th>
                <th>Kết thúc</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (bookingList != null && !bookingList.isEmpty()) {
                    for (BookingSchedule b : bookingList) {
            %>
            <tr>
                <td><%= b.getId() %></td>
                <td><%= b.getProductName() %></td>
                <td><%= b.getRenterName() %></td>
                <td><%= b.getOwnerName() %></td>
                <td><%= b.getRentStart() %></td>
                <td><%= b.getRentEnd() %></td>
                <td>
                    <span class="badge
                        <%= "cho_duyet".equals(b.getStatus()) ? "badge-warning" :
                             "xac_nhan".equals(b.getStatus()) ? "badge-success" :
                             "badge-danger" %>">
                        <%= b.getStatus() %>
                    </span>
                </td>
                <td>
                    <%
                        if ("cho_duyet".equals(b.getStatus())) {
                    %>
                    <form method="post" action="../bookingManagement" style="display:inline;">
                        <input type="hidden" name="id" value="<%= b.getId() %>">
                        <input type="hidden" name="status" value="xac_nhan">
                        <button type="submit" class="action-button btn-success">✔</button>
                    </form>
                    <form method="post" action="../bookingManagement" style="display:inline;">
                        <input type="hidden" name="id" value="<%= b.getId() %>">
                        <input type="hidden" name="status" value="huy">
                        <button type="submit" class="action-button btn-danger">✖</button>
                    </form>
                    <%
                        } else {
                            System.out.print("-");
                        }
                    %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8" class="text-center">Không có dữ liệu đặt thuê nào.</td>
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
