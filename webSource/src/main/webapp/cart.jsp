<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, java.math.BigDecimal" %>

<%@ page import="java.util.List, java.util.ArrayList, java.math.BigDecimal, model.User" %>
<%@ page import="model.ProductView" %>
<%@ page import="model.BookingSchedule" %>

<%
    // Lấy user và cart từ session/request
    User user = (User) session.getAttribute("user");

    List<ProductView> cart = (List<ProductView>) request.getAttribute("cart");
    if (cart == null) {
        cart = new ArrayList<>();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng</title>
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
                <li class="nav-item active"><a href="cart" class="nav-link">Giỏ Hàng</a></li>
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
                        <a href="orders" class="dropdown-item">Đơn hàng của bạn</a>
                        <a href="wishlist" class="dropdown-item">Sản phẩm yêu thích</a>
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
                        class="ion-ios-arrow-forward"></i></a></span> <span>Giỏ Hàng <i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Giỏ Hàng</h1>
            </div>
        </div>
    </div>
</section>
<%-- breadCrumbs end --%>

<%-- Phần cart start --%>
<div class="container py-4">
    <h2 class="mb-2 fw-bold text-center" style="font-size: 28px;">Giỏ hàng của bạn</h2>
    <p class="text-center mb-4" style="font-size: 18px; color: #555;">Có <%= cart.size() %> sản phẩm trong giỏ hàng</p>

    <% if (cart.isEmpty()) { %>
    <div class="text-center" style="min-height: 300px;">
        <img loading="lazy" src="assets/images/empty_cart.jpeg" alt="Giỏ hàng trống" style="max-width: 500px;">
        <p class="mt-3 text-muted">Giỏ hàng của bạn đang trống</p>
    </div>
    <% } else { %>
    <div class="row">
        <!-- Sản phẩm trong giỏ -->
        <div class="col-md-8">
            <% BigDecimal total = BigDecimal.ZERO; %>
            <% for (ProductView p : cart) { %>
            <% total = total.add(p.getPricePerDay().multiply(BigDecimal.valueOf(p.getQuantity()))); %>
            <div class="d-flex border p-3 mb-3 align-items-start position-relative">
                <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>"
                     style="width: 100px; height: auto; margin: 0 1rem" class="me-3">
                <div class="flex-grow-1">
                    <div class="d-flex justify-content-between align-items-start">
                        <strong><%= p.getName() %>
                        </strong>
                        <form action="cart" method="post">
                            <input type="hidden" name="action" value="remove"/>
                            <input type="hidden" name="productId" value="<%= p.getId() %>"/>
                            <button type="submit" class="btn btn-link text-danger p-0"
                                    style="position: absolute; top: 20px; right: 20px;">X
                            </button>
                        </form>
                    </div>
                    <p><%= String.format("%,d", p.getPricePerDay().longValue()) %> vnd</p>

                    <form action="cart" method="post" class="d-flex align-items-center">
                        <input type="hidden" name="action" value="updateQuantity"/>
                        <input type="hidden" name="productId" value="<%= p.getId() %>"/>
                        <button type="submit" name="operation" value="decrease"
                                class="btn btn-sm btn-outline-secondary">-
                        </button>
                        <input type="text" name="quantity" value="<%= p.getQuantity() %>" readonly
                               class="form-control text-center mx-2" style="width: 50px;"/>
                        <button type="submit" name="operation" value="increase"
                                class="btn btn-sm btn-outline-secondary">+
                        </button>
                    </form>
                </div>
                <div class="text-end ms-3" style="min-width: 120px; font-weight: bold; margin-top: auto">
                    <%= String.format("%,d", p.getPricePerDay().multiply(BigDecimal.valueOf(p.getQuantity())).longValue()) %>
                    vnd
                </div>
            </div>
            <!-- Chọn ngày thuê cho sản phẩm -->
            <div class="mt-2">
                <label class="form-label">Chọn khoảng thời gian thuê</label>
                <input type="text"
                       name="rentalDate_<%= p.getId() %>" id="rentalDate_<%= p.getId() %>"
                       class="form-control rental-date"
                       placeholder="Chọn khoảng ngày"
                       autocomplete="off"/>

                <small class="text-muted">Không thể chọn những ngày đã được đặt trước.</small>

                <!-- Hiển thị các ngày đã đặt -->
                <p class="text-muted mt-2 mb-0">Ngày đã đặt:</p>
                <ul class="text-muted ps-3 mb-2">
                    <%
                        List<BookingSchedule> schedules = p.getBookingSchedules();
                        java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
                        if (schedules == null || schedules.isEmpty()) {
                    %>
                    <li>Còn trống</li>
                    <% } else {
                        for (BookingSchedule schedule : schedules) { %>
                    <li><%= sdf.format(schedule.getRentStart()) %> - <%= sdf.format(schedule.getRentEnd()) %>
                    </li>
                    <% }
                    } %>
                </ul>
            </div>
            <% } %>

            <!-- Ghi chú đơn hàng + Chính sách -->
            <div class="row mt-4">
                <div class="col-md-6">
                    <label class="form-label fw-bold">Ghi chú đơn hàng</label>
                    <textarea class="form-control" placeholder="Ghi chú" rows="4"></textarea>
                </div>
                <div class="col-md-6">
                    <label class="form-label fw-bold">Chính sách mua hàng</label>
                    <ul class="text-muted small ps-3">
                        <li>Sản phẩm được đổi 1 lần duy nhất, không hỗ trả trả.</li>
                        <li>Sản phẩm còn đủ tem mác, chưa qua sử dụng.</li>
                        <li>Sản phẩm nguyên giá được đổi trong 30 ngày trên toàn hệ thống.</li>
                        <li>Sản phẩm sale chỉ hỗ trợ đổi size (nếu còn hàng) trong 7 ngày trên toàn hệ thống.</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Thông tin thanh toán -->
        <div class="col-md-4">
            <div class="border rounded p-3 shadow-sm">
                <h5 class="fw-bold mb-3">Thông tin đơn hàng</h5>
                <div class="d-flex justify-content-between mb-2">
                    <span>Tổng tiền:</span>
                    <span class="fw-bold text-danger"><%= String.format("%,d", total.longValue()) %> vnd</span>
                </div>
                <p class="text-muted small">Phí vận chuyển sẽ được tính ở trang thanh toán. Bạn cũng có thể nhập mã giảm
                    giá ở trang thanh toán.</p>
                <form action="checkout" method="post">
                    <button type="submit" class="btn btn-danger btn-lg w-100">Thanh toán</button>
                </form>

                <div class="text-center mt-3">
                    <a href="shop" class="text-decoration-none small">&larr; Tiếp tục mua hàng</a>
                </div>
            </div>
        </div>
    </div>
    <% } %>
</div>
<%-- Phần cart end --%>

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

<!-- loader -->
<%--<div id="ftco-loader" class="show fullscreen">--%>
<%--    <svg class="circular" width="48px" height="48px">--%>
<%--        <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/>--%>
<%--        <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10"--%>
<%--                stroke="#F96D00"/>--%>
<%--    </svg>--%>
<%--</div>--%>

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

<%-- js_handMade --%>
<script src="assets/js_handMade/cart.js"></script>
<script>
    <%
    // Định dạng ngày cho Flatpickr khi hiển thị trên giao diện (ví dụ: 31/05/2025)
    java.text.SimpleDateFormat displayFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
    // Định dạng ngày mà Flatpickr sẽ gửi đi và DB lưu trữ (ví dụ: 2025-05-31)
    java.text.SimpleDateFormat serverFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    %>
    <% for (ProductView p : cart) { %>
    <% List<BookingSchedule> schedules = p.getBookingSchedules(); %>
    flatpickr("#rentalDate_<%= p.getId() %>", {
        mode: "range",
        minDate: "today",
        dateFormat: "Y-m-d", // Định dạng gửi lên server
        altInput: true,
        altFormat: "d-m-Y", // Định dạng hiển thị cho người dùng
        disable: [
            <% if (schedules != null) {
        for (BookingSchedule s : schedules) {
            String from = serverFormat.format(s.getRentStart());
            String to = serverFormat.format(s.getRentEnd());
        %>
            {from: "<%= from %>", to: "<%= to %>"},
            <% } } %>
        ],
        onDayCreate: function (dObj, dStr, fp, dayElem) {
            if (dayElem.classList.contains('flatpickr-disabled')) {
                dayElem.classList.add('booked-day');
            }
        }
    });
    <% } %>
</script>

</body>
</html>
