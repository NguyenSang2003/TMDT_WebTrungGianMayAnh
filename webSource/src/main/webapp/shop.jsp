<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>

<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>EagleCam Selection 365</title>
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
    <link rel="stylesheet" href="assets/css_handMade/shop.css">

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
                <li class="nav-item"><a href="index" class="nav-link">Trang Chủ</a></li>
                <li class="nav-item active"><a href="shop.jsp" class="nav-link">Cửa Hàng</a></li>
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

                <%-- Nếu chưa đăng nhập --%>
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
                        <a href="orders.jsp" class="dropdown-item">Đơn hàng của bạn</a>
                        <a href="wishlist.jsp" class="dropdown-item">Sản phẩm yêu thích</a>
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

<section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('assets/images/bg_3.jpg');"
         data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
            <div class="col-md-9 ftco-animate pb-5">
                <p class="breadcrumbs"><span class="mr-2"><a href="index.jsp">Trang Chủ <i
                        class="ion-ios-arrow-forward"></i></a></span> <span>Cửa Hàng <i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Cửa Hàng</h1>
            </div>
        </div>
    </div>
</section>

<div class="container">
    <input type="text" style="margin-top: 10px " class="search-box" placeholder="Nhập từ khóa sản phẩm...">

    <div class="product-grid">

        <!-- Sản phẩm 1 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_1.jpg" alt="FX3">
            <div class="product-info">
                <h3>Sony FX3 Full-Frame Cinema Camera</h3>
                <div class="price">1,000,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ★</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 2 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_2.jpg" alt="A7 IV">
            <div class="product-info">
                <h3>Sony Alpha A7 IV</h3>
                <div class="price">900,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ★</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 3 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_3.jpg" alt="A7 III">
            <div class="product-info">
                <h3>Sony Alpha A7 III</h3>
                <div class="price">850,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ★</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 4 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_1.jpg" alt="AX100">
            <div class="product-info">
                <h3>Sony FDR-AX100 4K Camcorder</h3>
                <div class="price">550,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ☆</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 5 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_2.jpg" alt="C200">
            <div class="product-info">
                <h3>Canon EOS C200</h3>
                <div class="price">750,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ☆</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 6 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_4.jpg" alt="5D IV">
            <div class="product-info">
                <h3>Canon EOS 5D IV</h3>
                <div class="price">650,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ★</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 7 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_5.jpg" alt="6D Mark II">
            <div class="product-info">
                <h3>Canon 6D Mark II</h3>
                <div class="price">400,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ☆</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 8 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_6.jpg" alt="6D">
            <div class="product-info">
                <h3>Canon EOS 6D</h3>
                <div class="price">380,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating-detai">
                    <div class="rating">★ ★ ★ ★ ☆</div>
                    <a class="detail">Xem chi tiết</a>
                </div>
            </div>
        </div>

        <!-- Sản phẩm 9 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_7.jpg" alt="80D">
            <div class="product-info">
                <h3>Canon EOS 80D</h3>
                <div class="price">380,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 10 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_8.png" alt="80D">
            <div class="product-info">
                <h3>Fujifilm X-S20</h3>
                <div class="price">350,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 11 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_9.png" alt="80D">
            <div class="product-info">
                <h3>Canon EOS R6</h3>
                <div class="price">400,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 12 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_10.png" alt="80D">
            <div class="product-info">
                <h3>Sony Alpha a7 III</h3>
                <div class="price">380,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 13 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_11.png" alt="80D">
            <div class="product-info">
                <h3>Nikon Z6 II</h3>
                <div class="price">370,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 14 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayanh_12.png" alt="80D">
            <div class="product-info">
                <h3>Olympus OM-D E-M1 Mark III</h3>
                <div class="price">300,000 đ/ngày</div>
                <div class="category">Máy ảnh</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 15 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_3.png" alt="80D">
            <div class="product-info">
                <h3>Sony FX3</h3>
                <div class="price">600,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 16 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_4.png" alt="80D">
            <div class="product-info">
                <h3>Blackmagic Pocket Cinema Camera 6K</h3>
                <div class="price">550,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 17 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_4.png" alt="80D">
            <div class="product-info">
                <h3>Blackmagic Pocket Cinema Camera 6K</h3>
                <div class="price">550,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 18 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_5.png" alt="80D">
            <div class="product-info">
                <h3>Canon XA40</h3>
                <div class="price">450,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 19 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_6.png" alt="80D">
            <div class="product-info">
                <h3>Panasonic HC-X1</h3>
                <div class="price">500,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 20 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/mayquay_7.png" alt="80D">
            <div class="product-info">
                <h3>DJI Osmo Pocket 3</h3>
                <div class="price">280,000 đ/ngày</div>
                <div class="category">Máy quay</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 21 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/phukien_1.png" alt="80D">
            <div class="product-info">
                <h3>Bộ pin Canon LP-E8 - chính hãng RAVPower</h3>
                <div class="price">50,000 đ/ngày</div>
                <div class="category">Phụ kiện</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

        <!-- Sản phẩm 22 -->
        <div class="product-card">
            <button class="cart-btn"><img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px"></button>
            <img src="assets/images/phukien_2.png" alt="80D">
            <div class="product-info">
                <h3>Pin Sony NP-F970 RAVPower RP-OBCF002</h3>
                <div class="price">60,000 đ/ngày</div>
                <div class="category">Phụ kiện</div>
                <div class="rating">★ ★ ★ ★ ☆</div>

                <a class="detail">Xem chi tiết</a>
            </div>
        </div>

    </div>
</div>


<%-- start phần Footer --%>
<footer class="ftco-footer ftco-bg-dark ftco-section" style="margin-top: 45px;">
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