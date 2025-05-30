<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="model.User, model.ProductView, java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
	//Lấy danh sách đã được ShopController set
	List<ProductView> productViews = (List<ProductView>) request.getAttribute("productViews");
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

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const buttons = document.querySelectorAll('.cart-btn');

            buttons.forEach(btn => {
                btn.addEventListener('click', function () {
                    const productId = btn.dataset.id;

                    fetch('cart', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/x-www-form-urlencoded'
                        },
                        body: new URLSearchParams({
                            action: 'add',
                            productId: productId
                        })
                    })
                        .then(response => {
                            if (response.redirected) {
                                // Nếu server redirect sang trang cart, ta có thể chuyển trang
                                window.location.href = response.url;
                            } else {
                                alert('Đã thêm sản phẩm vào giỏ hàng!');
                            }
                        })
                        .catch(error => {
                            console.error('Lỗi khi thêm giỏ hàng:', error);
                            alert('Có lỗi xảy ra khi thêm giỏ hàng.');
                        });
                });
            });
        });
        document.querySelector('.search-box').addEventListener('input', function () {
            const keyword = this.value.toLowerCase();
            document.querySelectorAll('.product-card').forEach(card => {
                const name = card.querySelector('h3').textContent.toLowerCase();
                card.style.display = name.includes(keyword) ? 'block' : 'none';
            });
        });

    </script>
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
                <li class="nav-item active"><a href="shop" class="nav-link">Cửa Hàng</a></li>
                <li class="nav-item"><a href="cart" class="nav-link">Giỏ Hàng</a></li>
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
                <p class="breadcrumbs"><span class="mr-2"><a href="index">Trang Chủ <i
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
        <% if (productViews != null && !productViews.isEmpty()) {
            for (ProductView product : productViews) { %>
        <div class="product-card">
            <button class="cart-btn"
                    data-id="<%= product.getId() %>"
                    data-name="<%= product.getName() %>"
                    data-price="<%= product.getPricePerDay().doubleValue() %>"
                    data-image="<%= product.getImageUrl() != null ? product.getImageUrl() : "assets/images/default-product.jpg" %>">
                <img src="assets/images/cart_icon.jpg" style="width: 40px;height: 40px">
            </button>

            <img src="<%= product.getImageUrl() != null ? product.getImageUrl() : "assets/images/default-product.jpg" %>" alt="<%= product.getName() %>">
            <div class="product-info">
                <h3><%= product.getName() %></h3>
                <div class="price"><%= String.format("%,.0f₫/ngày", product.getPricePerDay().doubleValue()) %></div>
                <div class="category"><%= product.getCategory() %></div>
                <div class="rating-detai">
                    <div class="rating">
                        <% for (int i = 0; i < product.getRating(); i++) { %>★ <% } %>
                    </div>
                    <a class="detail" href="productDetail?id=<%= product.getId() %>">Xem chi tiết</a>
                </div>
            </div>
        </div>
        <%  }
        } else { %>
        <p>Không có sản phẩm nào trong danh sách.</p>
        <% } %>
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