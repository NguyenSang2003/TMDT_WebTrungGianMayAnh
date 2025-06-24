<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.CommentView, model.User, model.UserProfile" %>
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

    List<CommentView> productComments = (List<CommentView>) request.getAttribute("productComments");
    List<CommentView> ownerComments = (List<CommentView>) request.getAttribute("ownerComments");
    String message = (String) request.getAttribute("message");
%>

<html>
<head>
    <title>Quản lý bình luận</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/owner.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/orderDetail.css">
</head>
<body>

<div class="sidebar">
    <h4>EagleCam Selection 365</h4>
    <a href="bookings">📅 Quản lý đặt thuê</a>
    <a href="comments" class="active">💬 Quản lý bình luận</a>
    <a href="customers">👥 Quản lý khách hàng</a>
    <a href="orders">📦 Quản lý đơn hàng</a>
    <a href="oProductsManagement">📸 Quản lý sản phẩm</a>
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
    <p>Owner >> Quản lý bình luận</p>

    <h2>Bình luận sản phẩm của bạn</h2>
    <div class="card">
        <table>
            <tr>
                <th>#</th>
                <th>Sản phẩm</th>
                <th>Người bình luận</th>
                <th>Số sao</th>
                <th>Nội dung</th>
                <th>Thời gian</th>
                <th>Hành động</th>
            </tr>
            <%
                if (productComments != null && !productComments.isEmpty()) {
                    int i = 1;
                    for (CommentView c : productComments) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= c.getProductName() %></td>
                <td><%= c.getCommenter() %></td>
                <td><%= c.getRating() %></td>
                <td><%= c.getComment() %></td>
                <td><%= c.getCreatedAt() %></td>
                <td>
                    <% if (c.getIsShow() == 1) { %>
                    <a href="comments?action=toggleProductComment&id=<%= c.getId() %>&isShow=0"
                       class="status-badge status-huy"
                       onclick="return confirm('Ẩn bình luận sản phẩm này?');">Ẩn</a>
                    <% } else { %>
                    <a href="comments?action=toggleProductComment&id=<%= c.getId() %>&isShow=1"
                       class="status-badge status-hoan_thanh"
                       onclick="return confirm('Hiện lại bình luận sản phẩm này?');">Hiện</a>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">Chưa có bình luận nào.</td>
            </tr>
            <% } %>
        </table>
    </div>

    <h2>Đánh giá về bạn</h2>
    <div class="card">
        <table>
            <tr>
                <th>#</th>
                <th>Người đánh giá</th>
                <th>Số sao</th>
                <th>Nội dung</th>
                <th>Thời gian</th>
                <th>Hành động</th>
            </tr>
            <%
                if (ownerComments != null && !ownerComments.isEmpty()) {
                    int i = 1;
                    for (CommentView c : ownerComments) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= c.getCommenter() %></td>
                <td><%= c.getRating() %></td>
                <td><%= c.getComment() %></td>
                <td><%= c.getCreatedAt() %></td>
                <td>
                    <% if (c.getIsShow() == 1) { %>
                    <a href="comments?action=toggleOwnerReview&id=<%= c.getId() %>&isShow=0"
                       class="status-badge status-huy"
                       onclick="return confirm('Ẩn đánh giá này?');">🙈 Ẩn</a>
                    <% } else { %>
                    <a href="comments?action=toggleOwnerReview&id=<%= c.getId() %>&isShow=1"
                       class="status-badge status-hoan_thanh"
                       onclick="return confirm('Hiện lại đánh giá này?');">👁 Hiện</a>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6">Chưa có đánh giá nào.</td>
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
