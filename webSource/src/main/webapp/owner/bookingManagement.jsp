<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.BookingView, model.User, model.UserProfile" %>
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
    <title>Quản lý đặt thuê</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/owner.css">
</head>
<body>

<div class="sidebar">
    <h4>EagleCam Selection 365</h4>
    <a href="bookings" class="active">📅 Quản lý đặt thuê</a>
    <a href="comments">💬 Quản lý bình luận</a>
    <a href="customers">👥 Quản lý khách hàng</a>
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
    <p>Owner >> Quản lý đặt thuê</p>

    <h2>Danh sách đặt thuê</h2>

    <div class="card">
        <table>
            <tr>
                <th>#</th>
                <th>Sản phẩm</th>
                <th>Người thuê</th>
                <th>Thuê từ</th>
                <th>Đến ngày</th>
                <th>Trạng thái</th>
                <th>Hành động</th>
            </tr>
            <%
                List<BookingView> list = (List<BookingView>) request.getAttribute("bookingList");
                if (list != null && !list.isEmpty()) {
                    int i = 1;
                    for (BookingView b : list) {
            %>
            <tr>
                <td><%= i++ %></td>
                <td><%= b.getProductName() %></td>
                <td><%= b.getRenterName() %></td>
                <td><%= b.getRentStart() %></td>
                <td><%= b.getRentEnd() %></td>
                <td>
                    <%
                        String statusText = "";
                        switch (b.getStatus()) {
                            case "cho_duyet":
                                statusText = "Chờ duyệt";
                                break;
                            case "xac_nhan":
                                statusText = "Đã xác nhận";
                                break;
                            case "huy":
                                statusText = "Đã hủy";
                                break;
                            default:
                                statusText = b.getStatus();
                        }
                    %>
                    <%= statusText %>
                </td>
                <td>
                    <form method="post" style="display:inline;">
                        <input type="hidden" name="bookingId" value="<%= b.getId() %>">
                        <% if (!"xac_nhan".equals(b.getStatus())) { %>
                        <button name="action" value="approve">Duyệt</button>
                        <% } %>
                        <% if (!"huy".equals(b.getStatus())) { %>
                        <button name="action" value="cancel">Hủy</button>
                        <% } %>
                        <% if (!"cho_duyet".equals(b.getStatus())) { %>
                        <button name="action" value="pending">Chờ duyệt</button>
                        <% } %>
                        <button name="action" value="delete" onclick="return confirm('Xóa đặt thuê này?');">Xóa</button>
                    </form>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="7">Không có đặt thuê nào.</td>
            </tr>
            <% } %>
        </table>
    </div>
</div>

</body>
</html>
