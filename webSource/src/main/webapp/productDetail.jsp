<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/05/2025
  Time: 2:29 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.ProductView" %>
<%@ page import="java.util.List" %>

<%
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>Chi tiết sản phẩm</title>
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

    <style>
        .marginReset {
            margin-top: 0px !important;
        }

        .marginLeftIcon {
            margin-left: 10px;
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
                <li class="nav-item"><a href="index" class="nav-link">Trang Chủ</a></li>
                <li class="nav-item"><a href="shop" class="nav-link">Cửa Hàng</a></li>
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

<%-- breadcrumbs --%>
<section class="hero-wrap hero-wrap-2 js-fullheight" style="background-image: url('assets/images/bg_3.jpg');"
         data-stellar-background-ratio="0.5">
    <div class="overlay"></div>
    <div class="container">
        <div class="row no-gutters slider-text js-fullheight align-items-end justify-content-start">
            <div class="col-md-9 ftco-animate pb-5">
                <p class="breadcrumbs"><span class="mr-2"><a href="index">Trang chủ <i
                        class="ion-ios-arrow-forward"></i></a></span> <span>Chi tiết sản phẩm <i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Chi tiết sản phẩm</h1>
            </div>
        </div>
    </div>
</section>
<%-- breadcrumbs end --%>

<%-- Phần hiển error --%>
<%
    Boolean invalidId = (Boolean) request.getAttribute("invalidId");
    Boolean notFound = (Boolean) request.getAttribute("notFound");

    if (invalidId != null && invalidId == true) {
%>
<!-- Giao diện ID không hợp lệ -->
<section class="ftco-section text-center">
    <div class="container">
        <img src="assets/images/error_id.png" alt="ID không hợp lệ"
             style="max-width: 500px;border-radius: 10px;border: 1px solid red;margin-bottom: 15px;">
        <h2>ID sản phẩm không hợp lệ</h2>
        <p>Vui lòng kiểm tra lại liên kết.</p>
        <a href="index" class="btn btn-primary mt-3">Quay về trang chủ</a>
    </div>
</section>

<%
} else if (notFound != null && notFound == true) {
%>

<%-- Phần hiển thị sản phẩm nếu có ID --%>
<section class="ftco-section text-center">
    <div class="container">
        <img src="assets/images/no_products.png" alt="Sản phẩm không tồn tại"
             style="max-width: 500px;border-radius: 10px;border: 1px solid black;margin-bottom: 15px;">
        <h2>Sản phẩm không tồn tại</h2>
        <p>Rất tiếc, sản phẩm bạn đang tìm không có trong hệ thống.</p>
        <a href="index" class="btn btn-primary mt-3">Quay về trang chủ</a>
    </div>
</section>

<%
} else {
%>

<%-- Chi tiết sản phẩm --%>
<section class="ftco-section ftco-car-details">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12">
                <div class="car-details">
                    <div class="img rounded"
                         style="background-image: url('${pageContext.request.contextPath}/${product.imageUrl != null ? product.imageUrl : 'assets/images/mayanh_5.jpg'}');
                                 height: 400px; background-size: contain; background-position: center; margin-bottom: 0px;">
                    </div>

                    <div class="text text-center mt-3">
                        <span class="subheading">${detail.brand}</span>
                        <h2>${product.name}</h2>
                        <p><strong>Giá thuê/ngày: </strong> ${product.formattedPricePerDay} vnđ</p>
                        <p><strong>Trạng thái: </strong> ${displayStatus}</p>
                    </div>
                </div>
            </div>
        </div>

        <%-- dãy Icon tình trạng, phụ kiện, weight, color --%>
        <div class="row mt-5 marginReset">
            <div class="col-md d-flex align-self-stretch">
                <div class="media block-6 services">
                    <div class="media-body py-md-4">
                        <div class="d-flex mb-3 align-items-center">
                            <div class="icon d-flex align-items-center justify-content-center"><span
                                    class="flaticon-dashboard"></span></div>
                            <div class="text">
                                <h3 class="heading mb-0 pl-3">Tình trạng <span>${detail.productCondition}</span></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md d-flex align-self-stretch">
                <div class="media block-6 services">
                    <div class="media-body py-md-4">
                        <div class="d-flex mb-3 align-items-center">
                            <div class="icon d-flex align-items-center justify-content-center"><span
                                    class="flaticon-car-seat marginLeftIcon"></span></div>
                            <div class="text">
                                <h3 class="heading mb-0 pl-3">Phụ kiện <span>${detail.accessories}</span></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md d-flex align-self-stretch">
                <div class="media block-6 services">
                    <div class="media-body py-md-4">
                        <div class="d-flex mb-3 align-items-center">
                            <div class="icon d-flex align-items-center justify-content-center"><span
                                    class="flaticon-backpack"></span></div>
                            <div class="text">
                                <h3 class="heading mb-0 pl-3">Trọng lượng <span>${detail.weight} kg</span></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md d-flex align-self-stretch">
                <div class="media block-6 services">
                    <div class="media-body py-md-4">
                        <div class="d-flex mb-3 align-items-center">
                            <div class="icon d-flex align-items-center justify-content-center"><span
                                    class="flaticon-diesel marginLeftIcon"></span></div>
                            <div class="text">
                                <h3 class="heading mb-0 pl-3">Màu sắc <span>${detail.color}</span></h3>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%-- dãy Icon tình trạng, phụ kiện, weight, color enđ --%>

        <%-- Thông số kỹ thuật - Mô tả --%>
        <div class="row mt-4 marginReset">
            <div class="col-md-12 pills marginReset">
                <div class="bd-example bd-example-tabs">
                    <div class="d-flex justify-content-center">
                        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                            <li class="nav-item">
                                <a class="nav-link active" id="pills-features-tab" data-toggle="pill"
                                   href="#pills-features" role="tab" aria-controls="pills-features"
                                   aria-selected="true">Thông số kỹ thuật</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" id="pills-description-tab" data-toggle="pill"
                                   href="#pills-description" role="tab" aria-controls="pills-description"
                                   aria-selected="false">Mô tả</a>
                            </li>
                        </ul>
                    </div>

                    <div class="tab-content" id="pills-tabContent">
                        <div class="tab-pane fade show active" id="pills-features" role="tabpanel"
                             aria-labelledby="pills-features-tab">
                            <div class="row">
                                <div class="col-md-6">
                                    <ul class="features">
                                        <li><strong>Hãng:</strong> ${detail.brand}</li>
                                        <li><strong>Model:</strong> ${detail.model}</li>
                                        <li><strong>Danh mục:</strong> ${detail.category}</li>
                                        <li><strong>Trạng thái:</strong> ${detail.productCondition}</li>
                                        <li><strong>Phụ kiện:</strong> ${detail.accessories}</li>
                                    </ul>
                                </div>
                                <div class="col-md-6">
                                    <ul class="features">
                                        <li><strong>Màu sắc:</strong> ${detail.color}</li>
                                        <li><strong>Trọng lượng:</strong> ${detail.weight} kg</li>
                                        <li><strong>Lượt xem:</strong> ${product.viewCount}</li>
                                        <li><strong>Đã thuê:</strong> ${product.soldCount} lượt</li>
                                        <li><strong>Ngày đăng:</strong> ${product.createdAt}</li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane fade" id="pills-description" role="tabpanel"
                             aria-labelledby="pills-description-tab">
                            <p>${detail.description}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <%-- Thông số kỹ thuật - Mô tả end--%>

        <hr/>
        <h5 class="mt-4">💬 Bình luận</h5>
<%--        <% for (ProductView cmt : comments) {--%>
        <%--            String avatar = uv.getUserProfile().getAvatarUrl();--%>
        <%--        %>--%>
        <%--        <div class="d-flex align-items-start mb-3">--%>
        <%--            <img src="<%= avatar %>"--%>
        <%--                 alt="avatar"--%>
        <%--                 style="width: 60px; height: 60px; border-radius: 50%; object-fit: cover;"/>--%>

        <%--            <div class="bg-light p-2 px-3 ml-3 rounded shadow-sm w-100">--%>
        <%--                <strong><%= uv.getUserProfile().getFullName() %>--%>
        <%--                </strong>--%>
        <%--                <p class="mb-0"><%= cmt.getComment() %>--%>
        <%--                </p>--%>
        <%--                <small class="text-muted"><%= sdf.format(cmt.getCreatedAt()) %>--%>
        <%--                </small>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <%--        <% } %>--%>

        <%-- Bình luận --%>
        <% if (session.getAttribute("user") != null) { %>
        <form method="post" action="" class="mt-4">
            <div class="form-group">
                <label for="comment">Viết bình luận:</label>
                <textarea id="comment" name="comment" class="form-control" rows="3" required></textarea>
            </div>
            <button type="submit" class="btn btn-primary mt-2">Gửi bình luận</button>
        </form>
        <% } else { %>
        <p class="text-danger mt-4">Vui lòng <a href="login.jsp">đăng nhập</a> để bình luận.</p>
        <% } %>

    </div>
</section>
<%-- Chi tiết sản phẩm end --%>

<%-- Phần sản phẩm liên quan --%>
<section class="ftco-section ftco-no-pt">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12 heading-section text-center ftco-animate mb-5">
                <span class="subheading">Chọn thiết bị</span>
                <h2 class="mb-2">Sản phẩm liên quan</h2>
            </div>
        </div>
        <div class="row">
            <%-- Scriptlet để duyệt danh sách sản phẩm liên quan  --%>
            <%
                List<ProductView> related = (List<model.ProductView>) request.getAttribute("relatedProducts");
                if (related != null) {
                    for (model.ProductView item : related) {
            %>
            <div class="col-md-4">
                <div class="car-wrap rounded ftco-animate">
                    <div class="img rounded d-flex align-items-end"
                         style="background-image: url('<%= item.getImageUrl() %>');">
                    </div>
                    <div class="text">
                        <h2 class="mb-0">
                            <a href="product-detail?id=<%= item.getId() %>">
                                <%= item.getName() %>
                            </a>
                        </h2>
                        <div class="d-flex mb-3">
                            <span class="cat"><%= item.getBrand() != null ? item.getBrand() : "Đang cập nhật" %></span>
                            <p class="price ml-auto"><%= item.getFormattedPricePerDay() %> <span>/ngày</span></p>
                        </div>
                        <p class="d-flex justify-content-center mb-0">
                            <a href="product-detail?id=<%= item.getId() %>" class="btn btn-secondary py-2 ml-1">Xem chi
                                tiết</a>
                        </p>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            %>
        </div>
    </div>
</section>
<%-- Phần sản phẩm liên quan end --%>
<%
    }
%>

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

</body>
</html>