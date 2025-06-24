<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.CustomerView, model.User, model.UserProfile" %>
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
%>
<html>
<head>
    <title>Quản lý khách hàng</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/owner.css">
</head>
<body>
<div class="sidebar">
    <h4>EagleCam Selection 365</h4>
    <a href="bookings">📅 Quản lý đặt thuê</a>
    <a href="comments">💬 Quản lý bình luận</a>
    <a href="customers" class="active">👥 Quản lý khách hàng</a>
    <a href="orders">📦 Quản lý đơn hàng</a>
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
    <p>Owner >> Quản lý khách hàng</p>

    <h2>Danh sách khách đã từng thuê</h2>

    <div class="card">
        <table>
            <tr>
                <th>#</th>
                <th>Tài khoản</th>
                <th>Email</th>
                <th>Họ tên</th>
                <th>SĐT</th>
                <th>Địa chỉ</th>
                <th>CMND</th>
            </tr>
            <%
                List<CustomerView> list = (List<CustomerView>) request.getAttribute("customerList");
                if (list != null && !list.isEmpty()) {
                    int i = 1;
                    for (CustomerView c : list) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= c.getUsername() %></td>
                <td><%= c.getEmail() %></td>
                <td><%= c.getFullName() != null ? c.getFullName() : "" %></td>
                <td><%= c.getPhoneNumber() != null ? c.getPhoneNumber() : "" %></td>
                <td><%= c.getAddress() != null ? c.getAddress() : "" %></td>
                <td><%= c.getIdCardNumber() != null ? c.getIdCardNumber() : "" %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">Chưa có khách hàng nào thuê sản phẩm của bạn.</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>
</body>
</html>
