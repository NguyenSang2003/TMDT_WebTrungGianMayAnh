<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.math.BigDecimal, model.WithdrawalView, model.User, model.UserProfile" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null || !"nguoi_cho_thue".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    UserProfile profile = (UserProfile) request.getAttribute("ownerProfile");
    String fullName = (profile != null && profile.getFullName() != null) ? profile.getFullName() : user.getUsername();
    String avatarPath = (profile != null && profile.getIdCardImageUrl() != null && !profile.getIdCardImageUrl().isEmpty())
            ? profile.getIdCardImageUrl() : "assets/images/default_avatar.png";
%>
<html>
<head>
    <title>Yêu cầu rút tiền</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/assets/css_handMade/owner.css">
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
    <a href="reportsManagement.jsp">🚩 Quản lý báo cáo</a>
    <a href="withdrawalManagement" class="active">💰 Rút tiền</a>
    <div class="owner-profile">
        <a href="<%= request.getContextPath() %>/profile" style="text-decoration: none; color: white;">
            <img src="<%= request.getContextPath() %>/<%= avatarPath %>" alt="Avatar">
            <span><%= fullName %></span>
        </a>
    </div>
</div>

<div class="container">
    <p>Owner >> Rút tiền</p>

    <h2>Tổng doanh thu đã nhận:
        <%= request.getAttribute("totalRevenue") != null ? request.getAttribute("totalRevenue") + " VND" : "0 VND" %>
    </h2>

    <h2>Tổng tiền đã yêu cầu rút:
        <%= request.getAttribute("totalRequested") != null ? request.getAttribute("totalRequested") + " VND" : "0 VND" %>
    </h2>

    <h2>Số tiền còn có thể rút:
        <%= request.getAttribute("availableToWithdraw") != null ? request.getAttribute("availableToWithdraw") + " VND" : "0 VND" %>
    </h2>

    <!-- Form tạo yêu cầu rút tiền -->
    <form method="post" action="<%= request.getContextPath() %>/owner/withdrawalManagement">
        <label for="amount">Số tiền muốn rút (VND):</label>
        <input type="number" id="amount" name="amount" required min="1000" step="1000">
        <input type="hidden" name="action" value="add">
        <button type="submit">Gửi yêu cầu</button>
    </form>

    <hr>
    <h3>Danh sách yêu cầu rút tiền đã gửi</h3>
    <table>
        <tr>
            <th>#</th>
            <th>Mã yêu cầu</th>
            <th>Số tiền yêu cầu (VND)</th>
            <th>Ngày gửi</th>
            <th>Hành động</th>
        </tr>
        <%
            List<WithdrawalView> withdrawalRequests = (List<WithdrawalView>) request.getAttribute("withdrawalRequests");
            int index = 1;
            if (withdrawalRequests != null && !withdrawalRequests.isEmpty()) {
                for (WithdrawalView r : withdrawalRequests) {
        %>
        <tr>
            <td><%= index++ %></td>
            <td>REQ<%= r.getOrderId() %></td>
            <td><%= r.getAmount() %></td>
            <td><%= r.getCreatedAt() %></td>
            <td>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="id" value="<%= r.getOrderId() %>">
                    <input type="number" name="amount" value="<%= r.getAmount() %>" min="1000" step="1000" required>
                    <input type="hidden" name="action" value="edit">
                    <button type="submit">Sửa</button>
                </form>
                <form method="post" style="display:inline;" onsubmit="return confirm('Bạn có chắc muốn xóa yêu cầu này?');">
                    <input type="hidden" name="id" value="<%= r.getOrderId() %>">
                    <input type="hidden" name="action" value="delete">
                    <button type="submit">Xóa</button>
                </form>
            </td>
        </tr>
        <% } } else { %>
        <tr><td colspan="5">Chưa có yêu cầu rút tiền nào.</td></tr>
        <% } %>
    </table>

    <hr>
    <h3>Lịch sử nhận tiền thành công</h3>
    <table>
        <tr>
            <th>#</th>
            <th>Mã giao dịch</th>
            <th>Số tiền đã nhận (VND)</th>
            <th>Ngày nhận</th>
        </tr>
        <%
            List<WithdrawalView> historyList = (List<WithdrawalView>) request.getAttribute("withdrawalHistorySuccess");
            int count = 1;
            if (historyList != null && !historyList.isEmpty()) {
                for (WithdrawalView h : historyList) {
        %>
        <tr>
            <td><%= count++ %></td>
            <td>WD<%= h.getOrderId() %></td>
            <td><%= h.getAmount() %></td>
            <td><%= h.getCreatedAt() %></td>
        </tr>
        <% } } else { %>
        <tr><td colspan="4">Chưa có giao dịch nào thành công.</td></tr>
        <% } %>
    </table>

</div>
</body>
</html>
