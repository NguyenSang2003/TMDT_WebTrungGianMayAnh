<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 15/05/2025
  Time: 11:39 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<% String email = (String) request.getAttribute("email"); %>
<h2>Tài khoản <%= email %> chưa được xác minh</h2>
<p>Vui lòng kiểm tra email để xác minh tài khoản.</p>
<a href="resendVerification?email=<%= email %>">Gửi lại mã xác minh</a>

</body>
</html>
