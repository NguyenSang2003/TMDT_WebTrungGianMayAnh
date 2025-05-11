<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/05/2025
  Time: 2:33 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Meta & Title -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Quên Mật Khẩu - EagleCam</title>

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
    </style>
</head>

<body>

<!-- Header/Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
    <div class="container">

        <%-- Logo và tên góc trái trên cùng --%>
        <a class="navbar-brand d-flex align-items-center" href="index.jsp">
            <img src="assets/images/logo.PNG" alt="Logo"
                 style="height: 40px; margin-right: 10px; border-radius: 4px">
            <div style="line-height: 1;">
                <strong style="font-size: 14px;color: black">EagleCam</strong><br>
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
                <li class="nav-item"><a href="index.jsp" class="nav-link">Home</a></li>
                <li class="nav-item"><a href="about.jsp" class="nav-link">About</a></li>
                <li class="nav-item"><a href="shop.jsp" class="nav-link">Shop</a></li>
                <li class="nav-item"><a href="cart.jsp" class="nav-link">Cart</a></li>
                <li class="nav-item"><a href="checkout.jsp" class="nav-link">CheckOut</a></li>
                <li class="nav-item"><a href="blog.jsp" class="nav-link">Blog</a></li>
                <li class="nav-item"><a href="contact.jsp" class="nav-link">Contact</a></li>
                <li class="nav-item"><a href="login.jsp" class="nav-link">Login</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- END nav -->

<%-- Quên mật khẩu --%>
<div class="container">
    <h2 class="page-title">Quên mật khẩu</h2>
    <div class="form">
        <img src="assets/images/camera_left.png" alt="Camera Left" class="camera-left">
        <div class="form-box login">
            <!-- Dùng thẻ <form> với onsubmit="return false;" để không chuyển trang -->
            <form onsubmit="return false;">
                <div class="input-box">
                    <span class="icon"><ion-icon name="mail-open"></ion-icon></span>
                    <input type="email" name="email" id="emailInput" placeholder="Nhập gmail của bạn..." required>
                    <label>Email:</label>
                    <!-- Vùng thông báo xác thực email -->
                    <div id="emailValidationMessage"
                         style="margin: 10px 0px 7px; color: red; font-size: 13px; font-weight: 700;"></div>
                </div>
                <button id="btnSendMail" class="btn btn-success" disabled>Gửi Email</button>
                <div class="login-register">
                    <p>
                        <span style="font-size: 14px; color: #1CA8FF">Bạn đã có tài khoản? </span>
                        <a href="login.jsp" class="register-link">Đăng nhập</a>
                    </p>
                </div>
            </form>
        </div>
        <img src="assets/images/camera_right.png" alt="Camera Right" class="camera-right">
    </div>
</div>

</body>

<script>
    window.onload = function () {
        const emailInput = document.getElementById("emailInput");
        const validationMessage = document.getElementById("emailValidationMessage");
        const sendMailButton = document.getElementById("btnSendMail");

        // kiểm tra input của gmail nhập vòa
        emailInput.addEventListener("input", function () {
            const email = emailInput.value;

            // Kiểm tra định dạng email trước khi gọi API
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            if (!emailRegex.test(email)) {
                validationMessage.style.color = "red";
                validationMessage.textContent = "Gmail không hợp lệ";
                sendMailButton.disabled = true; // Ẩn nút gửi mail
                return; // Dừng ở đây, không cần gửi request
            }

            // Gửi AJAX để kiểm tra email trên server
            fetch("validate-email", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "email=" + encodeURIComponent(email)
            })
                .then(response => response.json())
                .then(data => {
                    if (data.isValid) {
                        validationMessage.style.color = "#00ff00";
                        validationMessage.textContent = "Gmail hợp lệ";
                        sendMailButton.disabled = false; // Bật nút gửi mail
                    } else {
                        validationMessage.style.color = "red";
                        validationMessage.textContent = "Gmail không hợp lệ";
                        sendMailButton.disabled = true; // Ẩn nút gửi mail
                    }
                })
                .catch(error => {
                    console.error("Error:", error);
                });
        });

        // nút gửi mail
        sendMailButton.addEventListener("click", function (e) {
            e.preventDefault();
            const email = emailInput.value;

            // Gửi yêu cầu forgot-pass như hiện tại
            fetch("forgot-pass", {
                method: "POST",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: "email=" + encodeURIComponent(email)
            })
                .then(response => response.json())
                .then(data => {
                    alert(data.message);
                })
                .catch(error => {
                    console.error("Error:", error);
                    alert("Có lỗi xảy ra, vui lòng thử lại sau!");
                });
        });
    }
</script>

<!-- Footer -->
<footer class="ftco-footer ftco-bg-dark ftco-section">
    <div class="container">
        <div class="row mb-5">
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2"><a href="#" class="logo">Car<span>book</span></a></h2>
                    <p>Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there
                        live the blind texts.</p>
                    <ul class="ftco-footer-social list-unstyled float-md-left float-lft mt-5">
                        <li class="ftco-animate"><a href="#"><span class="icon-twitter"></span></a></li>
                        <li class="ftco-animate"><a href="#"><span class="icon-facebook"></span></a></li>
                        <li class="ftco-animate"><a href="#"><span class="icon-instagram"></span></a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4 ml-md-5">
                    <h2 class="ftco-heading-2">Information</h2>
                    <ul class="list-unstyled">
                        <li><a href="#" class="py-2 d-block">About</a></li>
                        <li><a href="#" class="py-2 d-block">Services</a></li>
                        <li><a href="#" class="py-2 d-block">Term and Conditions</a></li>
                        <li><a href="#" class="py-2 d-block">Best Price Guarantee</a></li>
                        <li><a href="#" class="py-2 d-block">Privacy &amp; Cookies Policy</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Customer Support</h2>
                    <ul class="list-unstyled">
                        <li><a href="#" class="py-2 d-block">FAQ</a></li>
                        <li><a href="#" class="py-2 d-block">Payment Option</a></li>
                        <li><a href="#" class="py-2 d-block">Booking Tips</a></li>
                        <li><a href="#" class="py-2 d-block">How it works</a></li>
                        <li><a href="#" class="py-2 d-block">Contact Us</a></li>
                    </ul>
                </div>
            </div>
            <div class="col-md">
                <div class="ftco-footer-widget mb-4">
                    <h2 class="ftco-heading-2">Have a Questions?</h2>
                    <div class="block-23 mb-3">
                        <ul>
                            <li>
                                <span class="icon icon-map-marker"></span>
                                <span class="text">203 Fake St. Mountain View, San Francisco, California, USA</span>
                            </li>
                            <li><a href="#"><span class="icon icon-phone"></span><span
                                    class="text">+2 392 3929 210</span></a></li>
                            <li><a href="#"><span class="icon icon-envelope"></span><span class="text">info@yourdomain.com</span></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-12 text-center">
                <p>
                    Copyright &copy;
                    <script>document.write(new Date().getFullYear());</script>
                    All rights reserved | This template is made with <i class="icon-heart color-danger"
                                                                        aria-hidden="true"></i> by
                    <a href="https://colorlib.com" target="_blank">Colorlib</a>
                </p>
            </div>
        </div>
    </div>
</footer>
<!-- END Footer -->

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