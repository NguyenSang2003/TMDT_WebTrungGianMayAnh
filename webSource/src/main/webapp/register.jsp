<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <!-- Meta & Title -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Đăng nhập - EagleCam</title>

    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css?family=Poppins:200,300,400,500,600,700,800&display=swap"
          rel="stylesheet">

    <!-- CSS từ Header chung -->
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

    <!-- CSS và Scripts cho trang Đăng nhập riêng -->
    <link rel="stylesheet" href="assets/css_handMade/login.css">
    <script type="module" src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.esm.js"></script>
    <script nomodule src="https://unpkg.com/ionicons@7.1.0/dist/ionicons/ionicons.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <!-- Nơi chèn CSS nội bộ -->
    <style type="text/css">
        /* Ghi đè màu chữ mặc định cho các menu khi sử dụng navbar-dark */
        .navbar.navbar-dark .navbar-nav .nav-link {
            color: #000 !important;
        }

        /* Ghi đè màu khi hover và active */
        .navbar.navbar-dark .navbar-nav .nav-link:hover,
        .navbar.navbar-dark .navbar-nav .nav-item.active .nav-link,
        .navbar.navbar-dark .navbar-nav .nav-link.active {
            color: #01d28e !important;
        }

        .pThongBao {
            margin-bottom: 0px;
        }

        .notification2 {
            margin: 0 auto 10px auto;
            width: 50%;
            font-weight: bold;
            text-align: center;
            padding: 10px;
            border-radius: 5px;
        }
    </style>

    <%-- css_handMade --%>
    <link rel="stylesheet" href="assets/css_handMade/header_footer.css">
    <link rel="stylesheet" href="assets/css_handMade/register.css">

</head>

<body>

<!-- Header/Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">

        <%-- Logo và tên góc trái trên cùng --%>
        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="assets/images/logo.PNG" alt="Logo"
                 style="height: 40px; margin-right: 10px; border-radius: 4px; border: 1px solid black;">
            <div style="line-height: 1;">
                <strong style="font-size: 14px; color: black;">EagleCam</strong><br>
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
                <li class="nav-item"><a href="index" class="nav-link">Trang Chủ</a></li>
                <li class="nav-item"><a href="shop.jsp" class="nav-link">Cửa Hàng</a></li>
                <li class="nav-item"><a href="cart.jsp" class="nav-link">Giỏ Hàng</a></li>
                <li class="nav-item"><a href="checkout.jsp" class="nav-link">Thanh Toán</a></li>

                <!-- Dropdown mới cho "Về Chúng Tôi" và "Blog" -->
                <li class="nav-item dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Thông Tin</a>
                    <div class="dropdown-menu rounded-0 m-0 dropdown-menu">
                        <a href="about.jsp" class="dropdown-item">Về Chúng Tôi</a>
                        <a href="blog.jsp" class="dropdown-item">Blog</a>
                    </div>
                </li>

                <li class="nav-item"><a href="contact.jsp" class="nav-link">Liên Hệ</a></li>
                <li class="nav-item"><a href="login.jsp" class="nav-link">Đăng Nhập</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- END nav -->

<%-- Regiter --%>
<div class="container">
    <h2 class="page-title">Đăng ký</h2>

    <%--    <%--%>
    <%--        String status = (String) request.getAttribute("status");--%>
    <%--        if (status != null && !status.trim().isEmpty()) {--%>
    <%--            String bgColor = "";--%>
    <%--            String textColor = "#ffffff";--%>
    <%--            if ("success".equals(status)) {--%>
    <%--                bgColor = "green";--%>
    <%--            } else {--%>
    <%--                bgColor = "red";--%>
    <%--            }--%>
    <%--    %>--%>
    <%--    <div class="notification2" style="background-color: <%= bgColor %>; color: <%= textColor %>;">--%>
    <%--        <% if ("email_exists".equals(status)) { %>--%>
    <%--        <p class="pThongBao">Email đã tồn tại. Vui lòng nhập email khác.</p>--%>
    <%--        <% } else if ("username_exists".equals(status)) { %>--%>
    <%--        <p class="pThongBao">Tên người dùng đã tồn tại. Vui lòng chọn tên khác.</p>--%>
    <%--        <% } else if ("password_error".equals(status)) { %>--%>
    <%--        <p class="pThongBao">Mật khẩu nhập lại không khớp hoặc độ dài mật khẩu phải từ 6 ký tự.</p>--%>
    <%--        <% } else if ("register_failed".equals(status)) { %>--%>
    <%--        <p class="pThongBao">Đăng ký không thành công. Vui lòng thử lại!</p>--%>
    <%--        <% } else if ("success".equals(status)) { %>--%>
    <%--        <p class="pThongBao">Đăng ký thành công!</p>--%>
    <%--        <% } %>--%>
    <%--    </div>--%>
    <%--    <%--%>
    <%--            request.removeAttribute("status");--%>
    <%--        }--%>
    <%--    %>--%>


    <div class="form">
        <img src="assets/images/camera_left.png" alt="Camera Left" class="camera-left">
        <div class="form-box register">
            <form id="form" action="register" method="post">
                <div class="input-box">
                    <span class="icon"><ion-icon name="person"></ion-icon></span>
                    <input type="text" id="userName" name="userName" placeholder="Nhập tên người dùng" required>
                    <label>Tên người dùng:</label>
                    <small></small>
                </div>
                <div class="input-box">
                    <span class="icon"><ion-icon name="mail-open"></ion-icon></span>
                    <input type="email" id="email" name="email" placeholder="Nhập Email" required>
                    <label>Email:</label>
                    <small></small>
                </div>
                <div class="input-box">
                    <span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
                    <input type="password" id="password" name="password" placeholder="Nhập mật khẩu" required>
                    <label>Mật khẩu:</label>
                    <small></small>
                </div>
                <div class="input-box">
                    <span class="icon"><ion-icon name="lock-closed"></ion-icon></span>
                    <input type="password" id="retypePassword" name="retypePassword" placeholder="Nhập lại mật khẩu"
                           required>
                    <label>Nhập lại mật khẩu:</label>
                    <small></small>
                </div>
                <div class="remenber-forgot">
                    <label>
                        <input type="checkbox" required> Tôi đồng ý với các điều khoản &amp; điều kiện
                    </label>
                </div>
                <button type="submit" id="registerBtn" class="btn btn-success" disabled>Đăng Ký</button>

                <div class="login-register">
                    <p>
                        <span style="font-size: 14px; color: #1CA8FF">Bạn đã có tài khoản? </span>
                        <a href="login.jsp" class="login-link">Đăng Nhập</a>
                    </p>
                </div>
            </form>
        </div>
        <img src="assets/images/camera_right.png" alt="Camera Right" class="camera-right">
    </div>
</div>

<script src="assets/js_handMade/register.js"></script>

<%-- start phần Footer --%>
<footer class="ftco-footer ftco-bg-dark ftco-section">
    <div class="container">
        <div class="row mb-5">
            <!-- Cột Logo & Giới thiệu -->
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">
                        <a class="logo d-flex align-items-center" href="index.jsp">
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
                        <li><a href="index.jsp" class="py-2 d-block">Trang Chủ</a></li>
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

<!-- Loader & Additional Scripts -->
<div id="ftco-loader" class="show fullscreen">
    <svg class="circular" width="48px" height="48px">
        <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"></circle>
        <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"
                stroke="#F96D00"></circle>
    </svg>
</div>

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