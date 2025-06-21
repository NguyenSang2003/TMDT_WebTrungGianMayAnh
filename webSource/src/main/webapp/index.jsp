<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ProductView" %>
<%@ page import="java.util.Set" %>

<%
    User user = (User) session.getAttribute("user");
    // Lấy danh sách sản phẩm từ request attribute (HomeController).
    List<ProductView> latestProducts = (List<ProductView>) request.getAttribute("latestProducts");
    List<ProductView> bestSellingProducts = (List<ProductView>) request.getAttribute("bestSellingProducts");
    List<ProductView> mostViewedProducts = (List<ProductView>) request.getAttribute("mostViewedProducts");

    Set<Integer> wishlistIds = (Set<Integer>) request.getAttribute("wishlistIds");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>EagleCam Selection 365</title>
    <link rel="icon" type="image/PNG" href="assets/images/logo.PNG"/>
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

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <%-- css_handMade --%>
    <link rel="stylesheet" href="assets/css_handMade/header_footer.css">
    <link rel="stylesheet" href="assets/css_handMade/wishList.css">

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

<!-- start Ảnh back ground của index -->
<div class="hero-wrap ftco-degree-bg" style="background-image: url('assets/images/bg_1.jpg');"
     data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text justify-content-center align-items-center">
            <div class="col-lg-8 ftco-animate">
                <div class="text w-100 text-center mb-md-5 pb-md-5">
                    <h1 class="mb-4">Cách Nhanh & Dễ Dàng Để Thuê Máy Ảnh</h1>
                    <p style="font-size: 18px;">Hệ thống trung gian của chúng tôi giúp bạn dễ dàng tiếp cận các máy ảnh
                        chuyên nghiệp với quy trình đặt thuê nhanh chóng, an toàn và tiện lợi. Dù bạn là nhiếp ảnh gia
                        chuyên nghiệp hay yêu thích chụp ảnh, luôn có giải pháp phù hợp cho bạn.</p>
                    <a href="https://vimeo.com/45830194"
                       class="icon-wrap popup-vimeo d-flex align-items-center mt-4 justify-content-center">
                        <div class="icon d-flex align-items-center justify-content-center">
                            <span class="ion-ios-play"></span>
                        </div>
                        <div class="heading-title ml-5">
                            <span>Các bước đơn giản để thuê máy ảnh</span>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- end Ảnh back ground của index -->

<%-- start form --%>
<section class="ftco-section ftco-no-pt bg-light">
    <div class="container">
        <div class="row no-gutters">
            <div class="col-md-12 featured-top">
                <div class="row no-gutters">
                    <div class="col-md-4 d-flex align-items-center">
                        <form action="#" class="request-form ftco-animate bg-primary">
                            <h2>ĐẶT THUÊ MÁY ẢNH</h2>
                            <div class="form-group">
                                <label for="pickup-location" class="label">Nơi nhận máy ảnh</label>
                                <input type="text" class="form-control" id="pickup-location"
                                       placeholder="Thành phố, sân bay, trung tâm,...">
                            </div>
                            <div class="form-group">
                                <label for="dropoff-location" class="label">Nơi trả máy ảnh</label>
                                <input type="text" class="form-control" id="dropoff-location"
                                       placeholder="Thành phố, sân bay, trung tâm,...">
                            </div>
                            <div class="d-flex">
                                <div class="form-group mr-2">
                                    <label for="book-pick-date" class="label">Ngày nhận máy ảnh</label>
                                    <input type="date" class="form-control" id="book-pick-date">
                                </div>
                                <div class="form-group ml-2">
                                    <label for="book-off-date" class="label">Ngày trả máy ảnh</label>
                                    <input type="date" class="form-control" id="book-off-date">
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="time-pick" class="label">Thời gian nhận máy ảnh</label>
                                <input type="time" class="form-control" id="time-pick">
                            </div>
                            <div class="form-group">
                                <input type="submit" value="Thuê Máy Ảnh Ngay" class="btn btn-secondary py-3 px-4">
                            </div>
                        </form>
                    </div>
                    <div class="col-md-8 d-flex align-items-center">
                        <div class="services-wrap rounded-right w-100">
                            <h3 class="heading-section mb-4">Cách Dễ Dàng Để Thuê Máy Ảnh Hoàn Hảo</h3>
                            <div class="row d-flex mb-4">
                                <div class="col-md-4 d-flex align-self-stretch ftco-animate">
                                    <div class="services w-100 text-center">
                                        <div class="icon d-flex align-items-center justify-content-center">
                                            <span class="material-symbols-outlined">local_see</span>
                                        </div>
                                        <div class="text w-100">
                                            <h3 class="heading mb-2">Chọn cửa hàng nhận máy</h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 d-flex align-self-stretch ftco-animate">
                                    <div class="services w-100 text-center">
                                        <div class="icon d-flex align-items-center justify-content-center">
                                            <span class="material-symbols-outlined">add_a_photo</span>
                                        </div>
                                        <div class="text w-100">
                                            <h3 class="heading mb-2">Chọn máy ảnh phù hợp nhất</h3>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-4 d-flex align-self-stretch ftco-animate">
                                    <div class="services w-100 text-center">
                                        <div class="icon d-flex align-items-center justify-content-center">
                                            <span class="material-symbols-outlined">photo_camera</span>
                                        </div>
                                        <div class="text w-100">
                                            <h3 class="heading mb-2">Đặt trước máy ảnh</h3>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <p>
                                <a href="#" class="btn btn-primary py-3 px-4">Đặt trước máy ảnh hoàn hảo của bạn</a>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<%-- end form --%>

<!-- Section Sản phẩm bán chạy -->
<section class="ftco-section ftco-no-pt bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12 heading-section text-center ftco-animate mb-5">
                <span class="subheading">Dịch vụ của chúng tôi</span>
                <h2 class="mb-2">Máy Ảnh Bán Chạy</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="carousel-car owl-carousel">
                    <% if (bestSellingProducts != null) {
                        for (ProductView product : bestSellingProducts) {
                            boolean isInWishlist = wishlistIds != null && wishlistIds.contains(product.getId());
                    %>
                    <div class="item">
                        <div class="car-wrap rounded ftco-animate">
                            <!-- Container hình ảnh cần có position: relative -->
                            <div class="img rounded d-flex align-items-end"
                                 style="background-image: url('<%= product.getImageUrl() %>'); position: relative;">
                                <!-- Wishlist button đặt ở góc phải trên cùng -->
                                <% if (user != null) { %>
                                <% if (isInWishlist) { %>
                                <form method="post" action="wishlist"
                                      style="position: absolute; top: 10px; right: 10px;">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="wishlist-btn liked" disabled
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Đã yêu thích">
                                        <span class="material-icons">favorite</span>
                                    </button>
                                </form>
                                <% } else { %>
                                <form method="post" action="wishlist"
                                      style="position: absolute; top: 10px; right: 10px;">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="wishlist-btn not-liked"
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Thêm vào yêu thích">
                                        <span class="material-icons">favorite</span>
                                    </button>
                                </form>
                                <% } %>
                                <% } %>

                            </div>
                            <div class="text">
                                <h2 class="mb-0">
                                    <a href="product-detail?id=<%= product.getId() %>">
                                        <%= product.getName() %>
                                    </a>
                                </h2>
                                <div class="d-flex mb-3">
                                    <span class="cat small-text-color">Sản phẩm bán chạy</span>
                                    <p class="price ml-auto">
                                        <%= product.getFormattedPricePerDay() %> vnđ
                                        <span class="small-text-color">/ngày</span>
                                    </p>
                                </div>
                                <p class="d-flex mb-0 d-block">
                                    <a class="cart-btn btn btn-primary py-2 mr-1"
                                       data-bs-toggle="tooltip" data-bs-placement="top"
                                       data-id="<%= product.getId() %>"
                                       title="Thêm vào giỏ hàng">
                                        <span class="material-symbols-outlined">shopping_cart</span>
                                    </a>

                                    <a href="product-detail?id=<%= product.getId() %>"
                                       class="btn btn-secondary py-2 ml-1"
                                       data-bs-toggle="tooltip" data-bs-placement="top"
                                       title="Xem chi tiết">
                                        <span class="material-symbols-outlined">info</span>
                                    </a>

                                </p>
                            </div>
                        </div>
                    </div>
                    <% }
                    } %>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Section Sản phẩm mới nhất -->
<section class="ftco-section ftco-no-pt bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12 heading-section text-center ftco-animate mb-5">
                <span class="subheading">Khám phá sản phẩm mới</span>
                <h2 class="mb-2">Máy Ảnh Mới Nhất</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="carousel-car owl-carousel">
                    <% if (latestProducts != null) {
                        for (ProductView product : latestProducts) {
                            boolean isInWishlist = wishlistIds != null && wishlistIds.contains(product.getId());
                    %>
                    <div class="item">
                        <div class="car-wrap rounded ftco-animate">
                            <!-- Container hình ảnh cần có position: relative -->
                            <div class="img rounded d-flex align-items-end"
                                 style="background-image: url('<%= product.getImageUrl() %>'); position: relative;">
                                <!-- Wishlist button đặt ở góc phải trên cùng -->
                                <% if (user != null) { %>
                                <% if (isInWishlist) { %>
                                <form method="post" action="wishlist"
                                      style="position: absolute; top: 10px; right: 10px;">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="wishlist-btn liked" disabled
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Đã yêu thích">
                                        <span class="material-icons">favorite</span>
                                    </button>
                                </form>
                                <% } else { %>
                                <form method="post" action="wishlist"
                                      style="position: absolute; top: 10px; right: 10px;">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="wishlist-btn not-liked"
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Thêm vào yêu thích">
                                        <span class="material-icons">favorite</span>
                                    </button>
                                </form>
                                <% } %>
                                <% } %>
                            </div>

                            <div class="text">
                                <h2 class="mb-0"><a
                                        href="product-detail?id=<%= product.getId() %>"><%= product.getName() %>
                                </a></h2>
                                <div class="d-flex mb-3">
                                    <span class="cat small-text-color">Sản phẩm mới</span>
                                    <p class="price ml-auto"><%= product.getFormattedPricePerDay() %>
                                        vnđ
                                        <span class="small-text-color">/ngày</span></p>
                                </div>
                                <p class="d-flex mb-0 d-block">

                                    <a class="cart-btn btn btn-primary py-2 mr-1"
                                       data-bs-toggle="tooltip" data-bs-placement="top"
                                       data-id="<%= product.getId() %>"
                                       title="Thêm vào giỏ hàng">
                                        <span class="material-symbols-outlined">shopping_cart</span>
                                    </a>

                                    <a href="product-detail?id=<%= product.getId() %>"
                                       class="btn btn-secondary py-2 ml-1" data-bs-toggle="tooltip"
                                       data-bs-placement="top" title="Xem chi tiết">
                                        <span class="material-symbols-outlined">info</span>
                                    </a>

                                </p>
                            </div>
                        </div>
                    </div>
                    <% }
                    } %>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Section Sản phẩm được xem nhiều nhất -->
<section class="ftco-section ftco-no-pt bg-light">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12 heading-section text-center ftco-animate mb-5">
                <span class="subheading">Xem nhiều nhất</span>
                <h2 class="mb-2">Sản Phẩm Được Xem Nhiều Nhất</h2>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="carousel-car owl-carousel">
                    <% if (mostViewedProducts != null) {
                        for (ProductView product : mostViewedProducts) {
                            boolean isInWishlist = wishlistIds != null && wishlistIds.contains(product.getId());
                    %>
                    <div class="item">
                        <div class="car-wrap rounded ftco-animate">
                            <!-- Container hình ảnh cần có position: relative -->
                            <div class="img rounded d-flex align-items-end"
                                 style="background-image: url('<%= product.getImageUrl() %>'); position: relative;">

                                <!-- Wishlist button đặt ở góc phải trên cùng -->
                                <% if (user != null) { %>
                                <% if (isInWishlist) { %>
                                <form method="post" action="wishlist"
                                      style="position: absolute; top: 10px; right: 10px;">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="wishlist-btn liked" disabled
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Đã yêu thích">
                                        <span class="material-icons">favorite</span>
                                    </button>
                                </form>
                                <% } else { %>
                                <form method="post" action="wishlist"
                                      style="position: absolute; top: 10px; right: 10px;">
                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                    <button type="submit" class="wishlist-btn not-liked"
                                            data-bs-toggle="tooltip" data-bs-placement="top" title="Thêm vào yêu thích">
                                        <span class="material-icons">favorite</span>
                                    </button>
                                </form>
                                <% } %>
                                <% } %>
                            </div>

                            <div class="text">
                                <h2 class="mb-0"><a
                                        href="product-detail?id=<%= product.getId() %>"><%= product.getName() %>
                                </a></h2>
                                <div class="d-flex mb-3">
                                    <span class="cat small-text-color">Hot</span>
                                    <p class="price ml-auto"><%= product.getFormattedPricePerDay() %>
                                        vnđ
                                        <span class="small-text-color">/ngày</span></p>
                                </div>
                                <p class="d-flex mb-0 d-block">
                                    <a class="cart-btn btn btn-primary py-2 mr-1"
                                       data-bs-toggle="tooltip" data-bs-placement="top"
                                       data-id="<%= product.getId() %>"
                                       title="Thêm vào giỏ hàng">
                                        <span class="material-symbols-outlined">shopping_cart</span>
                                    </a>

                                    <a href="product-detail?id=<%= product.getId() %>"
                                       class="btn btn-secondary py-2 ml-1" data-bs-toggle="tooltip"
                                       data-bs-placement="top" title="Xem chi tiết">
                                        <span class="material-symbols-outlined">info</span>
                                    </a>
                                </p>
                            </div>
                        </div>
                    </div>
                    <% }
                    } %>
                </div>
            </div>
        </div>
    </div>
</section>

<%-- banner --%>
<%--<section class="ftco-section ftco-intro" style="background-image: url(assets/images/bg_3.jpg);">--%>
<%--    <div class="overlay"></div>--%>
<%--    <div class="container">--%>
<%--        <div class="row justify-content-end">--%>
<%--            <div class="col-md-6 heading-section heading-section-white ftco-animate">--%>
<%--                <h2 class="mb-3">Do You Want To Earn With Us? So Don't Be Late.</h2>--%>
<%--                <a href="#" class="btn btn-primary btn-lg">Become A Driver</a>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</section>--%>

<%-- Phản hồi khách hàng --%>
<section class="ftco-section testimony-section bg-light" style="padding-top: 0px;">
    <div class="container">
        <div class="row justify-content-center mb-5">
            <div class="col-md-7 text-center heading-section ftco-animate">
                <span class="subheading">Phản Hồi</span>
                <h2 class="mb-3">Khách Hàng Hài Lòng</h2>
            </div>
        </div>
        <div class="row ftco-animate">
            <div class="col-md-12">
                <!-- Dùng lại lớp carousel-car để tận dụng cấu hình slide có sẵn -->
                <div class="carousel-car owl-carousel">
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_1.jpg);"></div>
                            <div class="text pt-4">
                                <p class="mb-4">
                                    Dịch vụ thuê máy ảnh ở đây thực sự chuyên nghiệp. Tôi cảm thấy an tâm và hài lòng
                                    với chất lượng sản phẩm cũng như sự hỗ trợ tận tình của đội ngũ.
                                </p>
                                <p class="name">Nguyễn Văn Huy</p>
                                <span class="position">Quản lý Marketing</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_2.jpg);"></div>
                            <div class="text pt-4">
                                <p class="mb-4">
                                    Tôi đã thuê máy ảnh cho buổi chụp sự kiện và kết quả vượt ngoài mong đợi. Máy ảnh
                                    luôn đảm bảo chất lượng cao và giao dịch nhanh chóng.
                                </p>
                                <p class="name">Trần Thị Trang</p>
                                <span class="position">Nhà thiết kế giao diện</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_3.jpg);"></div>
                            <div class="text pt-4">
                                <p class="mb-4">
                                    Trải nghiệm sử dụng dịch vụ này thật sự đáng giá. Giá cả hợp lý, máy ảnh hiện đại
                                    cùng dịch vụ chăm sóc khách hàng chu đáo đã làm tôi hoàn toàn yên tâm.
                                </p>
                                <p class="name">Lê Thanh Sơn</p>
                                <span class="position">Nhà thiết kế UI</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_1.jpg);"></div>
                            <div class="text pt-4">
                                <p class="mb-4">
                                    Đã sử dụng dịch vụ thuê máy ảnh nhiều lần, tôi luôn ấn tượng với sự chuyên nghiệp và
                                    nhanh nhẹn của đội ngũ hỗ trợ. Mỗi trải nghiệm đều tuyệt vời.
                                </p>
                                <p class="name">Phạm Văn Đức</p>
                                <span class="position">Lập trình viên Website</span>
                            </div>
                        </div>
                    </div>
                    <div class="item">
                        <div class="testimony-wrap rounded text-center py-4 pb-5">
                            <div class="user-img mb-2" style="background-image: url(assets/images/person_1.jpg);"></div>
                            <div class="text pt-4">
                                <p class="mb-4">
                                    Dịch vụ cho thuê máy ảnh này thật sự làm tôi ấn tượng. Từng chi tiết nhỏ nhất đều
                                    được chăm sóc sát sao, giúp tôi có những bức ảnh hoàn hảo cho dự án của mình.
                                </p>
                                <p class="name">Hoàng Minh Tú</p>
                                <span class="position">Chuyên viên Phân tích Hệ thống</span>
                            </div>
                        </div>
                    </div>
                </div>  <!-- End carousel-car -->
            </div>
        </div>
    </div>
</section>
<%-- End phản hồi của khách --%>

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

<%-- js_handMade --%>
<script src="assets/js_handMade/addcart.js"></script>

</body>
</html>