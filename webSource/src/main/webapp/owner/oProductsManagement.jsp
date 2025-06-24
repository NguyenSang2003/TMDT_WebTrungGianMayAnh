<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ProductView, model.User, model.UserProfile" %>
<%
    User owner = (User) session.getAttribute("user");
    if (owner == null || !"nguoi_cho_thue".equals(owner.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    UserProfile profile = (UserProfile) request.getAttribute("ownerProfile");
    String fullName = (profile != null && profile.getFullName() != null) ? profile.getFullName() : owner.getUsername();
    String avatarPath = (profile != null && profile.getIdCardImageUrl() != null && !profile.getIdCardImageUrl().isEmpty())
            ? profile.getIdCardImageUrl() : "assets/images/default_avatar.png";

    List<ProductView> list = (List<ProductView>) request.getAttribute("products");
    String message = (String) request.getAttribute("message");
%>

<html>
<head>
    <title>Quản lý sản phẩm</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/owner.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/orderDetail.css">
</head>
<body>

<div class="sidebar">
    <h4>EagleCam Selection 365</h4>
    <a href="bookings">📅 Quản lý đặt thuê</a>
    <a href="comments">💬 Quản lý bình luận</a>
    <a href="customers">👥 Quản lý khách hàng</a>
    <a href="orders">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement" class="active">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📈 Doanh thu</a>
    <a href="reportsManagement.jsp">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
    <div class="owner-profile">
        <a href="<%= request.getContextPath() %>/profile">
            <img src="<%= request.getContextPath() %>/<%= avatarPath %>" alt="Avatar">
            <span><%= fullName %></span>
        </a>
    </div>
</div>

<div class="container">
    <p>Owner >> Quản lý sản phẩm</p>

    <h2>Danh sách sản phẩm</h2>
    <div class="card">
        <table>
            <tr>
                <th>#</th>
                <th>Tên</th>
                <th>Giá/ngày</th>
                <th>Số lượng</th>
                <th>Loại</th>
                <th>Đánh giá TB</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            <%
                if (list != null && !list.isEmpty()) {
                    int i = 1;
                    for (ProductView p : list) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= p.getName() %></td>
                <td><%= p.getFormattedPrice() %></td>
                <td><%= p.getQuantity() %></td>
                <td><%= p.getCategory() %></td>
                <td><%= (p.getAverageRating() != null) ? p.getAverageRating() : "Chưa có" %> ★</td>
                <td><%= p.getStatusText() %></td>
                <td>
                    <% if (p.getIsActive() == 1) { %>
                    <a href="oProductsManagement?action=toggleActive&id=<%= p.getId() %>&isActive=0"
                       class="status-badge status-huy"
                       onclick="return confirm('Ẩn sản phẩm này?');">Ẩn</a>
                    <% } else { %>
                    <a href="oProductsManagement?action=toggleActive&id=<%= p.getId() %>&isActive=1"
                       class="status-badge status-hoan_thanh"
                       onclick="return confirm('Hiện lại sản phẩm này?');">Hiện</a>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="8">Không có sản phẩm nào.</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

<% if (message != null) { %>
<script>alert("<%= message %>");</script>
<% } %>

</body>
</html>
