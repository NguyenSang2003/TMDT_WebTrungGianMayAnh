<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%@ page import="java.util.List, java.util.ArrayList, model.User" %>
<%@ page import="model.ProductView" %>

<%
    // Lấy user và cart từ session/request
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Về chúng tôi</title>
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
                        <a href="about.jsp" class="dropdown-item active">Về Chúng Tôi</a>
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
                        <a href="orders" class="dropdown-item">Đơn hàng của bạn</a>
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
                        class="ion-ios-arrow-forward"></i></a></span> <span>Về chúng tôi <i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Về chúng tôi</h1>
            </div>
        </div>
    </div>
</section>
<%-- breadCrumbs end --%>

<%-- Phần giới thiệu về EagleCam bắt đầu --%>
<section class="ftco-section ftco-about">
    <div class="container">
        <div class="row no-gutters">
            <div class="col-md-6 p-md-5 img img-2 d-flex justify-content-center align-items-center"
                 style="background-image: url(assets/images/about.jpg);">
            </div>
            <div class="col-md-6 wrap-about ftco-animate">
                <div class="heading-section heading-section-white pl-md-5">
                    <span class="subheading">Về chúng tôi</span>
                    <h2 class="mb-4">Chào mừng bạn đến với EagleCam Selection 365!</h2>

                    <p>Chúng tôi tự hào là nền tảng chuyên nghiệp hàng đầu trong lĩnh vực cho thuê máy ảnh và phụ kiện
                        máy ảnh, phục vụ nhu cầu từ cá nhân đam mê nhiếp ảnh đến các đơn vị sản xuất chuyên nghiệp. Với
                        tiêu chí “Chất lượng - Linh hoạt - Tiện lợi”, chúng tôi mang đến cho bạn những thiết bị hiện đại
                        nhất, từ máy ảnh, ống kính đến các phụ kiện hỗ trợ sáng tạo hình ảnh.</p>

                    <p>Tại EagleCam Selection 365, chúng tôi hiểu rằng mỗi khoảnh khắc đều quý giá. Vì vậy, chúng tôi
                        cam kết cung cấp dịch vụ thuê thiết bị nhanh chóng, thủ tục đơn giản và mức giá cạnh tranh, giúp
                        bạn dễ dàng thực hiện các dự án cá nhân hay thương mại một cách trọn vẹn.</p>

                    <p>Dù bạn là nhiếp ảnh gia chuyên nghiệp, người sáng tạo nội dung, hay đơn giản chỉ là người yêu
                        thích lưu giữ kỷ niệm, chúng tôi luôn sẵn sàng đồng hành cùng bạn. Cùng EagleCam Selection 365,
                        bạn sẽ luôn có thiết bị tốt nhất để biến ý tưởng thành hiện thực.</p>

                    <p><a href="shop" class="btn btn-primary py-3 px-4">Xem các thiết bị</a></p>
                </div>
            </div>
        </div>
    </div>
</section>
<%-- Phần giới thiệu về EagleCam kết thúc --%>

<%-- Phần kêu gọi đăng ký tài khoản bắt đầu --%>
<section class="ftco-section ftco-intro" style="background-image: url(assets/images/bg_3.jpg);">
    <div class="overlay"></div>
    <div class="container">
        <div class="row justify-content-end">
            <div class="col-md-6 heading-section heading-section-white ftco-animate">
                <h2 class="mb-3">Bạn muốn thuê hoặc cho thuê máy ảnh? Đừng bỏ lỡ cơ hội!</h2>
                <a href="login.jsp" class="btn btn-primary btn-lg">Đăng ký tài khoản ngay!</a>
            </div>
        </div>
    </div>
</section>
<%-- Phần kêu gọi đăng ký tài khoản kết thúc --%>

<%-- Phần đánh giá của khách hàng bắt đầu --%>
<section class="ftco-section testimony-section bg-light">
    <div class="container">
        <div class="row justify-content-center mb-5">
            <div class="col-md-7 text-center heading-section ftco-animate">
                <span class="subheading">Đánh Giá</span>
                <h2 class="mb-3">Khách Hàng Hài Lòng</h2>
            </div>
        </div>
        <div class="row ftco-animate">
            <div class="col-md-12">
                <div class="carousel-testimony owl-carousel ftco-owl">
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_1.jpg)">
                            </div>
                            <div class="text pt-4">
                                <p class="mb-4">Rất xa nơi những ngọn núi từ ngữ, xa khỏi vùng đất Vokalia và
                                    Consonantia, có những đoạn văn mù sống ẩn mình.</p>
                                <p class="name">Roger Scott</p>
                                <span class="position">Quản lý Marketing</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_2.jpg)">
                            </div>
                            <div class="text pt-4">
                                <p class="mb-4">Rất xa nơi những ngọn núi từ ngữ, xa khỏi vùng đất Vokalia và
                                    Consonantia, có những đoạn văn mù sống ẩn mình.</p>
                                <p class="name">Roger Scott</p>
                                <span class="position">Nhà thiết kế giao diện</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_3.jpg)">
                            </div>
                            <div class="text pt-4">
                                <p class="mb-4">Rất xa nơi những ngọn núi từ ngữ, xa khỏi vùng đất Vokalia và
                                    Consonantia, có những đoạn văn mù sống ẩn mình.</p>
                                <p class="name">Roger Scott</p>
                                <span class="position">Nhà thiết kế UI</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_1.jpg)">
                            </div>
                            <div class="text pt-4">
                                <p class="mb-4">Rất xa nơi những ngọn núi từ ngữ, xa khỏi vùng đất Vokalia và
                                    Consonantia, có những đoạn văn mù sống ẩn mình.</p>
                                <p class="name">Roger Scott</p>
                                <span class="position">Lập trình viên Web</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_1.jpg)">
                            </div>
                            <div class="text pt-4">
                                <p class="mb-4">Rất xa nơi những ngọn núi từ ngữ, xa khỏi vùng đất Vokalia và
                                    Consonantia, có những đoạn văn mù sống ẩn mình.</p>
                                <p class="name">Roger Scott</p>
                                <span class="position">Chuyên viên phân tích hệ thống</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%-- Phần đánh giá của khách hàng kết thúc --%>

<%-- Phần thống kê thành tựu của EagleCam bắt đầu --%>
<section class="ftco-counter ftco-section img" id="section-counter">
    <div class="overlay"></div>
    <div class="container">
        <div class="row">
            <!-- Số năm kinh nghiệm -->
            <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
                <div class="block-18">
                    <div class="text text-border d-flex align-items-center">
                        <strong class="number" data-number="3">0</strong>
                        <span>Năm <br>Kinh nghiệm</span>
                    </div>
                </div>
            </div>
            <!-- Số lượt giao dịch -->
            <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
                <div class="block-18">
                    <div class="text text-border d-flex align-items-center">
                        <strong class="number" data-number="300">0</strong>
                        <span>Cuộc <br>Giao dịch</span>
                    </div>
                </div>
            </div>
            <!-- Số khách hàng hài lòng -->
            <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
                <div class="block-18">
                    <div class="text text-border d-flex align-items-center">
                        <strong class="number" data-number="2590">0</strong>
                        <span>Khách hàng <br>Hài lòng</span>
                    </div>
                </div>
            </div>
            <!-- Số đối tác/chi nhánh -->
            <div class="col-md-6 col-lg-3 justify-content-center counter-wrap ftco-animate">
                <div class="block-18">
                    <div class="text d-flex align-items-center">
                        <strong class="number" data-number="67">0</strong>
                        <span>Đối tác <br>Phân phối</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%-- Phần thống kê thành tựu của EagleCam kết thúc --%>

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

<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

</body>
</html>