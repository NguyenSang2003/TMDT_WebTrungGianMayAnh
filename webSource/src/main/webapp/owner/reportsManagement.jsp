<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.ReportView, model.User, model.UserProfile" %>
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
    <title>Quản lý báo cáo</title>
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
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
    <a href="oRevenueReport">📈 Doanh thu</a>
    <a href="reportsManagement.jsp" class="active">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement">💰 Rút tiền</a>
    <div class="owner-profile">
        <a href="<%= request.getContextPath() %>/profile" style="text-decoration: none; color: white;">
            <img src="<%= request.getContextPath() %>/<%= avatarPath %>" alt="Avatar">
            <span><%= fullName %></span>
        </a>
    </div>
</div>

<div class="container">
    <p>Owner >> Quản lý báo cáo</p>

    <h2>Danh sách báo cáo sản phẩm</h2>

    <div class="card">
        <table>
            <tr>
                <th>#</th>
                <th>Sản phẩm</th>
                <th>Người báo cáo</th>
                <th>Lý do</th>
                <th>Ngày báo cáo</th>
            </tr>
            <%
                List<ReportView> list = (List<ReportView>) request.getAttribute("reportList");
                if (list != null && !list.isEmpty()) {
                    int i = 1;
                    for (ReportView r : list) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= r.getProductName() %></td>
                <td><%= r.getReporterName() %></td>
                <td><%= r.getReason() %></td>
                <td><%= r.getCreatedAt() %></td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="5">Chưa có báo cáo nào liên quan đến sản phẩm của bạn.</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

</body>
</html>
