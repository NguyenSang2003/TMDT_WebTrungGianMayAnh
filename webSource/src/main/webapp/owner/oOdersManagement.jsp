<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.OrderListView, model.User, model.UserProfile" %>
<%
    User owner = (User) session.getAttribute("user");
    if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    UserProfile profile = (UserProfile) request.getAttribute("ownerProfile");
    String fullName = (profile != null && profile.getFullName() != null) ? profile.getFullName() : owner.getUsername();
    String avatarPath = (profile != null && profile.getIdCardImageUrl() != null && !profile.getIdCardImageUrl().isEmpty()) ? profile.getIdCardImageUrl() : "assets/images/default_avatar.png";
%>
<html>
<head>
    <title>Quản lý đơn hàng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/owner.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/orderDetail.css">
</head>
<body>

<div class="sidebar">
    <h4>EagleCam Selection 365</h4>
    <a href="bookings">📅 Quản lý đặt thuê</a>
    <a href="comments">💬 Quản lý bình luận</a>
    <a href="customers">👥 Quản lý khách hàng</a>
    <a href="orders" class="active">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📈 Doanh thu</a>
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
    <p>Owner >> Quản lý đơn hàng</p>

    <h2>Danh sách đơn hàng</h2>

    <div class="card">
        <table>
            <tr>
                <th>#</th>
                <th>Khách thuê</th>
                <th>Tổng tiền (đ)</th>
                <th>Thuê từ</th>
                <th>Đến ngày</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            <%
                List<OrderListView> orderList = (List<OrderListView>) request.getAttribute("orderList");
                if (orderList != null && !orderList.isEmpty()) {
                    int i = 1;
                    for (OrderListView o : orderList) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= o.getRenterName() %></td>
                <td><%= o.getTotalPrice() %></td>
                <td><%= o.getRentStart() %></td>
                <td><%= o.getRentEnd() %></td>
                <td>
                    <span class="status-badge status-<%= o.getStatus() %>"><%= o.getStatusDisplay() %></span>
                </td>
                <td>
                    <% if ("cho_duyet".equals(o.getStatus())) { %>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="action" value="approve">
                        <input type="hidden" name="orderId" value="<%= o.getId() %>">
                        <button type="submit" onclick="return confirm('Xác nhận duyệt đơn?')">Duyệt</button>
                    </form>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="orderId" value="<%= o.getId() %>">
                        <button type="submit" onclick="return confirm('Xác nhận hủy đơn?')">Hủy</button>
                    </form>
                    <% } else { %>
                    Không có
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">Chưa có đơn hàng nào.</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

</body>
</html>
