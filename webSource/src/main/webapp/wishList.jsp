<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.UserView" %>
<%@ page import="model.UserProfile" %>

<%
    UserView view = (UserView) request.getAttribute("userView");

    String displayRole = (String) request.getAttribute("displayRole");

    User user = view != null ? view.getUser() : null;
    UserProfile profile = view != null ? view.getUserProfile() : null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Thông tin cá nhân</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet" href="assets/css/open-iconic-bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/animate.css">
    <link rel="stylesheet" href="assets/css/owl.carousel.min.css">
    <link rel="stylesheet" href="assets/css/owl.theme.default.min.css">
    <link rel="stylesheet" href="assets/css/magnific-popup.css">
    <link rel="stylesheet" href="assets/css/aos.css">
    <link rel="stylesheet" href="assets/css/ionicons.min.css">
    <link rel="stylesheet" href="assets/css/bootstrap-datepicker.css">
    <link rel="stylesheet" href="assets/css/jquery.timepicker.css">
    <link rel="stylesheet" href="assets/css/flaticon.css">
    <link rel="stylesheet" href="assets/css/icomoon.css">
    <link rel="stylesheet" href="assets/css/style.css">

    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

    <!-- Material Symbols Outlined -->
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>

    <%-- css_handMade --%>
    <link rel="stylesheet" href="assets/css_handMade/header_footer.css">
    <link rel="stylesheet" href="assets/css_handMade/userProfile.css">
</head>
<body>

<!-- Header/Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">

        <%-- Logo và tên góc trái trên cùng --%>
        <a class="navbar-brand d-flex align-items-center" href="index">
            <img src="assets/images/logo.PNG" alt="Logo"
                 style="height: 40px; margin-right: 10px; border-radius: 4px">
            <div style="line-height: 1;">
                <strong style="font-size: 14px;">EagleCam</strong><br>
                <span style="font-size: 13px;">Selection 365</span>
            </div>
        </a>

        <%-- Nút menu cho dang mobile --%>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav"
                aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="oi oi-menu"></span> Menu
        </button>

        <%-- nút menu --%>
        <div class="collapse navbar-collapse" id="ftco-nav">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active"><a href="index" class="nav-link">Trang Chủ</a></li>
                <li class="nav-item"><a href="shop.jsp" class="nav-link">Cửa Hàng</a></li>
                <li class="nav-item"><a href="cart.jsp" class="nav-link">Giỏ Hàng</a></li>
                <li class="nav-item"><a href="checkout.jsp" class="nav-link">Thanh Toán</a></li>

                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Thông Tin</a>
                    <div class="dropdown-menu rounded-0 m-0">
                        <a href="about.jsp" class="dropdown-item">Về Chúng Tôi</a>
                        <a href="blog.jsp" class="dropdown-item">Blog</a>
                    </div>
                </li>

                <li class="nav-item"><a href="contact.jsp" class="nav-link">Liên Hệ</a></li>

                <%-- Kiểm tra trạng thái đăng nhập --%>
                <%
                    if (user == null) {
                %>
                <li class="nav-item"><a href="login.jsp" class="nav-link">Đăng Nhập</a></li>
                <li class="nav-item"><a href="register.jsp" class="nav-link">Đăng Ký</a></li>
                <%
                } else {
                %>
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">
                        Hi, <%= user.getUsername() %>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right m-0">

                        <%-- Nếu chưa xác thực Gmail --%>
                        <% if (!user.isVerifyEmail()) { %>
                        <a href="GmailVerify.jsp" class="dropdown-item text-danger font-weight-bold">
                            <i class="fa fa-envelope"></i> Xác thực Gmail
                        </a>
                        <% } else { %>
                        <a href="profile" class="dropdown-item">Hồ sơ cá nhân</a>

                        <% if ("admin".equals(user.getRole())) { %>
                        <a href="admin/adminIndex.jsp" class="dropdown-item">Trang Admin</a>
                        <a href="admin/userManagement.jsp" class="dropdown-item">Quản lý người dùng</a>
                        <a href="admin/aProductsManagement.jsp" class="dropdown-item">Quản lý sản phẩm</a>
                        <a href="admin/ordersManagement.jsp" class="dropdown-item">Quản lý đơn hàng</a>

                        <% } else if ("nguoi_cho_thue".equals(user.getRole())) { %>
                        <a href="owner/oProductsManagement.jsp" class="dropdown-item">Sản phẩm đã đăng</a>
                        <a href="owner/oRevenueReport.jsp" class="dropdown-item">Doanh thu</a>
                        <a href="owner/withdrawalManagement.jsp" class="dropdown-item">Quản lý rút tiền</a>

                        <% } else if ("khach_thue".equals(user.getRole())) { %>
                        <a href="orders.jsp" class="dropdown-item">Đơn hàng của bạn</a>
                        <a href="wishlist.jsp" class="dropdown-item">Sản phẩm yêu thích</a>
                        <% } %>
                        <% } %>

                        <a href="logout" class="dropdown-item">Đăng xuất</a>
                    </div>
                </li>
                <% } %>
            </ul>
        </div>
    </div>
</nav>
<!-- END nav -->

<%-- Bread crumbs --%>
<section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('assets/images/bg_3.jpg');"
         data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
            <div class="col-md-9 ftco-animate pb-5">
                <p class="breadcrumbs"><span class="mr-2"><a href="index">Trang chủ<i
                        class="ion-ios-arrow-forward"></i></a></span> <span>Thông tin người dùng<i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Thông tin người dùng</h1>
            </div>
        </div>
    </div>
</section>
<%-- Bread crumbs end --%>

<% if (user != null && profile != null) { %>
<%-- User profile --%>
<div class="profile-wrapper">
    <div class="container">
        <!-- Thông tin tài khoản User -->
        <h2>Thông Tin Tài Khoản</h2>
        <div class="info-section">
            <table>
                <tr>
                    <th>Tên đăng nhập</th>
                    <td><%= user.getUsername() %>
                    </td>
                </tr>
                <tr>
                    <th>Email</th>
                    <td><%= user.getEmail() %>
                    </td>
                </tr>
                <tr>
                    <th>Vai trò</th>
                    <td><%= displayRole %>
                    </td>
                </tr>
                <tr>
                    <th>Email:</th>
                    <td><%= user.isVerifyEmail() ? "Đã xác thực" : "Chưa xác thực" %>
                    </td>
                </tr>
                <tr>
                    <th>Xác thực CMND & Họ tên:</th>
                    <td><%= profile.isVerifiedIdentity() ? "Đã xác thực" : "Chưa xác thực" %>
                    </td>
                </tr>
                <tr>
                    <th>Trạng thái tài khoản:</th>
                    <td><%= user.isActive() ? "Hoạt động" : "Không hoạt động" %>
                    </td>
                </tr>
                <tr>
                    <th>Ngày tạo</th>
                    <td><%= request.getAttribute("createdAtFormatted") %>
                    </td>
                </tr>
                <tr>
                    <th>Ngày cập nhật</th>
                    <td><%= request.getAttribute("updatedAtFormatted") %>
                    </td>
                </tr>
            </table>
        </div>

        <!-- Thông tin hồ sơ và form cập nhật -->
        <h2>Thông Tin Hồ Sơ</h2>
        <div class="form-section">
            <form method="post" action="profile">
                <label for="fullName">Họ tên:</label>
                <input type="text" id="fullName" name="fullName"
                       value="<%= profile.getFullName() != null ? profile.getFullName() : "" %>"
                       required>

                <label for="idCardNumber">CMND/CCCD:</label>
                <input type="text" id="idCardNumber" name="idCardNumber"
                       value="<%= profile.getIdCardNumber() != null ? profile.getIdCardNumber() : "" %>"
                       required>

                <label for="address">Địa chỉ:</label>
                <input type="text" id="address" name="address"
                       value="<%= profile.getAddress() != null ? profile.getAddress() : "" %>"
                       required>

                <label for="phone">SĐT:</label>
                <input type="text" id="phone" name="phone"
                       value="<%= profile.getPhoneNumber() != null ? profile.getPhoneNumber() : "" %>"
                       required>

                <label for="dob">Ngày sinh:</label>
                <input type="date" id="dob" name="dob"
                       value="<%= profile.getDateOfBirth() != null ? profile.getDateOfBirth() : "" %>"
                       required>

                <%-- Nút cập nhật profile --%>
                <input type="submit" value="Cập nhật thông tin">
            </form>
        </div>

        <%-- Thông tin ảnh CMND và upload --%>
        <h2>Ảnh CMND/CCCD</h2>
        <div class="form-section">
            <form method="post" action="./upload-idcard" enctype="multipart/form-data">

                <% if (profile.getIdCardImageUrl() != null && !profile.getIdCardImageUrl().isEmpty()) { %>
                <label>Ảnh CMND/CCCD (2 mặt):</label>
                <div class="img-preview">
                    <img src="<%= request.getContextPath() + "/" + profile.getIdCardImageUrl() + "?v=" + System.currentTimeMillis() %>"
                         alt="Ảnh chụp 2 mặt CMND">
                </div>
                <% } %>

                <label for="idCardImage">Chọn ảnh CMND/CCCD:</label>
                <input type="file" id="idCardImage" name="idCardImage" accept="image/*" required>

                <%-- ảnh cmnd với người --%>
                <% if (profile.getIdCardWithUserImageUrl() != null && !profile.getIdCardWithUserImageUrl().isEmpty()) { %>
                <label>Ảnh chụp cùng CMND/CCCD:</label>
                <div class="img-preview">
                    <img src="<%= request.getContextPath() + "/" + profile.getIdCardWithUserImageUrl() + "?v=" + System.currentTimeMillis() %>"
                         alt="Ảnh chụp cùng CMND">
                </div>
                <% } %>

                <label for="idCardWithUserImage">Chọn ảnh chụp cùng CMND/CCCD:</label>
                <input type="file" id="idCardWithUserImage" name="idCardWithUserImage" accept="image/*" required>

                <%-- Nút submit ảnh CMND --%>
                <input type="submit" value="Tải ảnh lên">
            </form>
        </div>

    </div>
</div>
<%-- User profile end--%>
<% } else { %>
<p>Không thể tải thông tin người dùng.</p>
<% } %>

<%-- start phần Footer --%>
<footer class="ftco-footer ftco-bg-dark ftco-section">
    <div class="container">
        <div class="row mb-5">
            <!-- Cột Logo & Giới thiệu -->
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">
                        <a class="logo d-flex align-items-center" href="index">
                            <img src="assets/images/logo.PNG" alt="Logo"
                                 style="height: 40px; margin-right: 10px; border-radius: 4px">
                            <div style="line-height: 1;">
                                <strong style="font-size: 14px;">EagleCam</strong><br>
                                <span style="font-size: 13px;">Selection 365</span>
                            </div>
                        </a>
                    </h2>
                    <p>EagleCam Selection 365 cung cấp dịch vụ cho thuê máy ảnh và phụ kiện chất lượng cao, đáp ứng mọi
                        nhu cầu của bạn với giá cả hợp lý và dịch vụ chuyên nghiệp.</p>
                    <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                        <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                        <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                        <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
                    </ul>
                </div>
            </div>
            <!-- Cột Thông tin -->
            <div class="col-md">
                <div class="ftco-footer-widget mb-4 ml-md-5">
                    <h2 class="ftco-heading-2">Đường tắt khác</h2>
                    <ul class="list-unstyled">
                        <li><a href="index" class="py-2 d-block">Trang Chủ</a></li>
                        <li><a href="shop.jsp" class="py-2 d-block">Cửa Hàng</a></li>
                        <li><a href="blog.jsp" class="py-2 d-block">Blog</a></li>
                        <li><a href="cart.jsp" class="py-2 d-block">Giỏ Hàng</a></li>
                        <li><a href="#" class="py-2 d-block">Chính sách bảo mật & Cookie</a></li>
                    </ul>
                </div>
            </div>
            <!-- Cột Hỗ trợ khách hàng -->
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Hỗ trợ khách hàng</h2>
                    <ul class="list-unstyled">
                        <li><a href="#" class="py-2 d-block">Câu hỏi thường gặp</a></li>
                        <li><a href="#" class="py-2 d-block">Phương thức thanh toán</a></li>
                        <li><a href="#" class="py-2 d-block">Mẹo đặt thuê</a></li>
                        <li><a href="#" class="py-2 d-block">Cách thức hoạt động</a></li>
                        <li><a href="#" class="py-2 d-block">Liên hệ</a></li>
                    </ul>
                </div>
            </div>
            <!-- Cột Liên hệ -->
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Có thắc mắc?</h2>
                    <div class="block-23 mb-3">
                        <ul>
                            <li>
                                <span class="icon icon-map-marker"></span>
                                <span class="text">CN2 - Đại học Nông Lâm Hồ Chí Minh, Thành phố Thủ Đức</span>
                            </li>
                            <li>
                                <a href="#"><span class="icon icon-phone"></span><span class="text">+84 345295324</span></a>
                            </li>
                            <li>
                                <a href="#"><span class="icon icon-envelope"></span><span class="text">EagleCam365@gmail.com</span></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        <!-- Dòng Copyright -->
        <div class="row">
            <div class="col-md-12 text-center">
                <p><!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                    Copyright &copy;
                    <script>document.write(new Date().getFullYear());</script>
                    All rights reserved | This template is made with <i class="icon-heart color-danger"
                                                                        aria-hidden="true"></i> by
                    <a href="https://colorlib.com" target="_blank">Colorlib</a>
                    <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. --></p>
            </div>
        </div>
    </div>
</footer>
<%-- end phần Footer --%>

<!-- loader -->
<div id="ftco-loader" class="show fullscreen">
    <svg class="circular" width="48px" height="48px">
        <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/>
        <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"
                stroke="#F96D00"/>
    </svg>
</div>

<!-- JS scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/jquery-migrate-3.0.1.min.js"></script>
<script src="assets/js/popper.min.js"></script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/jquery.easing.1.3.js"></script>
<script src="assets/js/jquery.waypoints.min.js"></script>
<script src="assets/js/jquery.stellar.min.js"></script>
<script src="assets/js/owl.carousel.min.js"></script>
<script src="assets/js/jquery.magnific-popup.min.js"></script>
<script src="assets/js/aos.js"></script>
<script src="assets/js/jquery.animateNumber.min.js"></script>
<script src="assets/js/bootstrap-datepicker.js"></script>
<script src="assets/js/jquery.timepicker.min.js"></script>
<script src="assets/js/scrollax.min.js"></script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
<script src="assets/js/google-map.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>