<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>

<%
    // Lấy user và cart từ session/request
    User user = (User) session.getAttribute("user");
%>


<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Thanh toán</title>

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

    <style>
        .title-underline {
            border-bottom: 4px solid black;
            display: inline-block;
            padding-bottom: 5px;
        }
        .product-img {
            width: 60px;
            height: 60px;
            object-fit: cover;
        }
        .note-box {
            height: 120px;
        }
    </style>
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
                <li class="nav-item "><a href="cart" class="nav-link">Giỏ Hàng</a></li>
                <li class="nav-item active"><a href="checkout.jsp" class="nav-link">Thanh Toán</a></li>

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

<section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('assets/images/bg_3.jpg');"
         data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
            <div class="col-md-9 ftco-animate pb-5">
                <p class="breadcrumbs"><span class="mr-2"><a href="index">Trang Chủ <i
                        class="ion-ios-arrow-forward"></i></a></span> <span>Thanh toán<i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Thanh Toán</h1>
            </div>
        </div>
    </div>
</section>

<div class="container mt-5">
    <h2 class="text-center mb-4"><span class="title-underline">Thanh toán</span></h2>

    <div class="border p-4 rounded">
        <h5 class="mb-4 fw-bold">Thông tin đơn hàng</h5>
        <div class="row">
            <!-- Left: Order Details -->
            <div class="col-md-8">
                <%
                    List<OrderView> recentOrderViews = (List<OrderView>) request.getAttribute("recentOrderViews");
                    Double shippingFee = (Double) request.getAttribute("shippingFee");
                    if (shippingFee == null) shippingFee = 0.0;
                    double totalAmount = 0;
                %>

                <h4 class="fw-bold mb-4">🛒 Thông tin đơn hàng</h4>

                <% if (recentOrderViews != null && !recentOrderViews.isEmpty()) { %>
                <% for (OrderView ov : recentOrderViews) {
                    Order o = ov.getOrder();
                    Product p = ov.getProduct();
                    totalAmount += o.getTotalPrice();
                %>
                <div class="card mb-3 shadow-sm">
                    <div class="row g-0 align-items-center">
                        <div class="col-md-3">
                            <img src="<%= ov.getImageUrl() %>" class="img-fluid rounded-start" alt="Ảnh sản phẩm">
                        </div>
                        <div class="col-md-9">
                            <div class="card-body d-flex flex-column gap-2">
                                <!-- Thông tin sản phẩm -->
                                <div>
                                    <h5 class="card-title fw-semibold mb-1"><%= p.getName() %></h5>
                                    <p class="mb-1 text-muted">💸 Giá thuê/ngày: <strong><%= String.format("%,.0f ₫/ngày ", p.getPricePerDay().doubleValue()) %> VNĐ</strong></p>
                                    <p class="mb-1 text-muted">🔢 Số lượng: <%= o.getQuantity() %></p>
                                </div>

                                <!-- Thông tin thời gian thuê -->
                                <div class="d-flex flex-column flex-md-row justify-content-between">
                                    <p class="mb-1 text-muted me-3">📅 Ngày thuê: <strong><%= o.getRentStart() %></strong></p>
                                    <p class="mb-1 text-muted me-3">📆 Ngày trả: <strong><%= o.getRentEnd() %></strong></p>
                                </div>

                                <!-- Thành tiền -->
                                <div class="mt-2">
                                    <p class="fw-bold text-danger mb-0">💰 Thành tiền: <%= String.format("%,.0f ₫/ngày ", o.getTotalPrice()) %> VNĐ</p>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
                <% } %>
                <% } else { %>
                <p class="text-muted mt-3">Không có đơn hàng đang chờ duyệt.</p>
                <% } %>

                <!-- Extra Options -->
                <div class="border-top pt-4 mt-4">
                    <div class="mb-3">
                        <strong>🚚 Phí vận chuyển:</strong>
                        <span class="ms-2">
                            <%= (shippingFee == null || shippingFee == 0) ? "Free" : String.format("%,.0f ₫", shippingFee) %>
                        </span>
                    </div>
                    <div class="mb-3">
                        <label class="form-label fw-semibold">🎁 Mã giảm giá</label>
                        <input type="text" class="form-control w-75" placeholder="Nhập mã giảm giá">
                    </div>
                    <div class="mb-3">
                        <strong>💰 Tổng thanh toán: </strong>
                        <span class="ms-2"><%= String.format("%,.0f ₫", totalAmount + shippingFee) %></span>  <!-- Cộng phí vận chuyển -->
                    </div>
                    <div class="mb-3">
                        <label for="note" class="form-label fw-semibold">📝 Ghi chú đơn hàng</label>
                        <textarea id="note" class="form-control" rows="3" placeholder="Ghi chú"></textarea>
                    </div>
                    <button class="btn btn-danger px-4 py-2 fw-bold">Thanh toán</button>
                </div>
            </div>

            <!-- Right: Image -->
            <div class="col-md-4 text-center"
                 style="background-image: url('assets/images/image_page_checkout.jpg');
                background-size: cover;
                background-position: center;
                background-repeat: no-repeat;">
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
                        <li><a href="index" class="py-2 d-block">Trang Chủ</a></li>
                        <li><a href="shop" class="py-2 d-block">Cửa Hàng</a></li>
                        <li><a href="blog.jsp" class="py-2 d-block">Blog</a></li>
                        <li><a href="cart" class="py-2 d-block">Giỏ Hàng</a></li>
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

</body>
</html>
