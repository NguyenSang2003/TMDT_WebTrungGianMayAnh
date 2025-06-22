<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.OrderView" %>
<%@ page import="model.User" %>
<%@ page import="model.OrderItems" %>
<%@ page import="model.Product" %>

<%
    // Lấy user và cart từ session/request
    User user = (User) session.getAttribute("user");

    OrderView orderView = (OrderView) request.getAttribute("order");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link rel="icon" type="image/PNG" href="assets/images/logo.PNG"/>
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

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <%-- css_handMade --%>
    <link rel="stylesheet" href="assets/css_handMade/header_footer.css">
    <link rel="stylesheet" href="assets/css_handMade/orderDetail.css">

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
                <li class="nav-item "><a href="index" class="nav-link">Trang Chủ</a></li>
                <li class="nav-item"><a href="shop" class="nav-link">Cửa Hàng</a></li>
                <li class="nav-item"><a href="cart" class="nav-link">Giỏ Hàng</a></li>
                <li class="nav-item"><a href="checkout" class="nav-link">Thanh Toán</a></li>

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
                        <a href="profile.jsp" class="dropdown-item">Hồ sơ cá nhân</a>

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
                        <a href="orders" class="dropdown-item active">Đơn hàng của bạn</a>
                        <a href="wishList" class="dropdown-item">Sản phẩm yêu thích</a>
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

<%-- breadCrumbs --%>
<section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('assets/images/bg_3.jpg');"
         data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
            <div class="col-md-9 ftco-animate pb-5">
                <p class="breadcrumbs"><span class="mr-2"><a href="index">Trang Chủ <i
                        class="ion-ios-arrow-forward"></i></a></span> <span>Chi tiết đơn hàng <i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Chi tiết đơn hàng</h1>
            </div>
        </div>
    </div>
</section>
<%-- breadCrumbs end --%>

<%-- OrderDetail start --%>
<div class="container py-4">
    <h2 class="mb-4 fw-bold">Chi tiết đơn hàng #<%= orderView.getOrder().getId() %>
    </h2>

    <div class="mb-3">
        <p><strong>Ngày đặt:</strong> <%= orderView.getOrder().getCreatedAt() %>
        </p>
        <p>
            <strong>Thời gian thuê:</strong>
            <%= orderView.getOrder().getRentStart() %> &rarr; <%= orderView.getOrder().getRentEnd() %>
        </p>
        <p>
            <strong>Trạng thái:</strong>
            <span class="status-badge status-<%= orderView.getOrder().getStatus() %>">
                <%= orderView.getOrder().getDisplayStatus() %></span>
        </p>

        <p><strong>Tổng tiền:</strong> <%= String.format("%,.0f", orderView.getOrder().getTotalPrice()) %> VND</p>
    </div>

    <h4 class="mb-3">Danh sách sản phẩm:</h4>
    <div class="table-responsive">
        <table class="table table-bordered table-striped text-center">
            <thead>
            <tr>
                <th>Ảnh</th>
                <th>Tên sản phẩm</th>
                <th>Số lượng</th>
                <th>Giá thuê/ngày</th>
                <th>Thành tiền</th>
            </tr>
            </thead>
            <tbody>
            <% for (int i = 0; i < orderView.getItems().size(); i++) {
                OrderItems item = orderView.getItems().get(i);
                Product product = orderView.getProducts().get(i);
                String imageUrl = orderView.getImageUrls().get(i);
            %>
            <tr>
                <td><img src="<%= imageUrl %>" alt="Ảnh sản phẩm" style="width: 80px;"></td>
                <td><%= product.getName() %>
                </td>
                <td><%= item.getQuantity() %>
                </td>
                <td><%= String.format("%,.0f", item.getPricePerDay()) %> VND</td>
                <td><%= String.format("%,.0f", item.getTotalPrice()) %> VND</td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <a href="orders" class="btn btn-secondary mt-3">&larr; Quay lại danh sách đơn</a>
</div>
<%-- OrderDetail end --%>

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
                        <li><a href="shop" class="py-2 d-block">Cửa Hàng</a></li>
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

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

</body>
</html>