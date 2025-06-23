<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page import="model.BlogDetailView" %>
<%@ page import="model.BlogComment" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:useBean id="detail" class="model.BlogDetailView" scope="request" />
<%
	User user = (User) session.getAttribute("user");
	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
	java.util.List<BlogComment> comments = detail.getComments();
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Blog - EagleCam</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

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

    <style>
        .blog-header {
            background: url('assets/images/mayanh_1.jpg') center/cover no-repeat;
            height: 300px;
            position: relative;
            color: white;
        }

        .blog-header .overlay {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.4);
        }

        .blog-header h1 {
            position: relative;
            z-index: 2;
            top: 50%;
            transform: translateY(-50%);
            text-align: center;
        }

        .blog-content {
            padding: 20px 0;
            background-color: #f9f9f9;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .blog-content .row {
            display: flex;
            align-items: flex-start;
        }

        .blog-image {
            flex: 1;
            max-width: 50%;
            padding-right: 15px;
        }

        .blog-image img {
            max-width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 8px;
        }

        .blog-details {
            flex: 1;
            max-width: 50%;
            padding-left: 15px;
            background-color: #fff;
            border-radius: 8px;
            padding: 15px;
            border: 1px solid #e9ecef;
        }

        .post-meta span {
            display: block;
            color: #606770;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .post-content p {
            margin-bottom: 10px;
            color: #1c2526;
            font-size: 15px;
            line-height: 1.5;
        }

        .post-content h3 {
            color: #1a73e8;
            font-size: 18px;
            margin-top: 15px;
            margin-bottom: 10px;
        }

        .post-content ul {
            list-style-type: disc;
            padding-left: 20px;
            margin-bottom: 15px;
        }

        .post-content ul li {
            color: #606770;
            font-size: 15px;
            margin-bottom: 8px;
        }

        .post-stats {
            margin-top: 10px;
            color: #606770;
            font-size: 14px;
        }

        .post-stats span {
            margin-right: 15px;
        }

        .post-actions {
            margin-top: 15px;
        }

        .post-actions .btn {
            margin-right: 10px;
            font-size: 14px;
            padding: 5px 10px;
        }

        .post-actions .form-control {
            font-size: 14px;
            padding: 5px 10px;
        }

        .comment-section {
            margin-top: 15px;
        }

        .comment {
            display: flex;
            align-items: flex-start;
            margin-bottom: 10px;
        }

        .comment .avatar {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            background-color: #ddd;
            margin-right: 10px;
        }

        .comment .comment-text {
            color: #606770;
            font-size: 14px;
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
                <li class="nav-item"><a href="cart" class="nav-link">Giỏ Hàng</a></li>
                <li class="nav-item"><a href="checkout" class="nav-link">Thanh Toán</a></li>

                <li class="nav-item active dropdown">
                    <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Thông Tin</a>
                    <div class="dropdown-menu rounded-0 m-0">
                        <a href="about.jsp" class="dropdown-item">Về Chúng Tôi</a>
                        <a href="blog" class="dropdown-item">Blog</a>
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
                        <a href="profile.jsp" class="dropdown-item">Hồ sơ cá nhân</a>
                        <a href="owner/oProductsManagement.jsp" class="dropdown-item">Sản phẩm đã đăng</a>
                        <a href="owner/oRevenueReport.jsp" class="dropdown-item">Doanh thu</a>
                        <a href="owner/withdrawalManagement.jsp" class="dropdown-item">Quản lý rút tiền</a>
                        <% } else if ("khach_thue".equals(user.getRole())) { %>
                        <a href="profile.jsp" class="dropdown-item">Hồ sơ cá nhân</a>
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
                        class="ion-ios-arrow-forward"></i></a></span> <span>Blog Details<i
                        class="ion-ios-arrow-forward"></i></span></p>
                <h1 class="mb-3 bread">Blog Details</h1>
            </div>
        </div>
    </div>
</section>

<section>
  <div class="container py-5">
    <h3 class="fw-bold mb-3"><%= detail.getBlog().getTitle() %></h3>
    <div class="d-flex ">
    	<%
		    String imageUrl = detail.getBlogAuthor().getUserProfile().getAvatarUrl();
		%>
		<img src="<%=imageUrl %>"
		     alt="imageUrl"
		     style="width: 60px; height: 60px; border-radius: 50%; object-fit: cover;" />


		<div class="ml-4">
			<p class="text-muted">✍️ Tác giả: <%= detail.getBlogAuthor().getUserProfile().getFullName() %></p>
	    	<p class="text-muted">🕒 Ngày đăng: <%= sdf.format(detail.getBlog().getCreatedAt()) %></p>
		</div>
    </div>
    <%
	    String blogImage = detail.getBlog().getImageUrl();
	    if (blogImage != null && !blogImage.trim().isEmpty()) {
	%>
	    <img src="<%= blogImage %>" alt="Ảnh blog"
	         class="img-fluid rounded shadow-sm mb-3"
	         style="width: 100%; max-height: 500px; object-fit: cover;">
	<% } %>

    <p><%= detail.getBlog().getContent() %></p>

    <hr />
    <h5 class="mt-4">💬 Bình luận</h5>
	<% for (BlogComment cmt : comments) {
	     model.UserView uv = detail.getCommentUserViews().get(cmt.getUserId());
	     String avatar = uv.getUserProfile().getAvatarUrl();
	%>
	    <div class="d-flex align-items-start mb-3">
	    	<img src="<%= avatar %>"
			     alt="avatar"
			     style="width: 60px; height: 60px; border-radius: 50%; object-fit: cover;" />

	        <div class="bg-light p-2 px-3 ml-3 rounded shadow-sm w-100">
	            <strong><%= uv.getUserProfile().getFullName() %></strong>
	            <p class="mb-0"><%= cmt.getComment() %></p>
	            <small class="text-muted"><%= sdf.format(cmt.getCreatedAt()) %></small>
	        </div>
	    </div>
	<% } %>

	<% if (session.getAttribute("user") != null) { %>
	    <form method="post" action="blog-detail?id=<%= detail.getBlog().getId() %>" class="mt-4">
	        <div class="form-group">
	            <label for="comment">Viết bình luận:</label>
	            <textarea name="comment" class="form-control" rows="3" required></textarea>
	        </div>
	        <button type="submit" class="btn btn-primary mt-2">Gửi bình luận</button>
	    </form>
	<% } else { %>
	    <p class="text-danger mt-4">Vui lòng <a href="login.jsp">đăng nhập</a> để bình luận.</p>
	<% } %>
		
  </div>
</section>

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

<script>
  // Xem thêm nội dung
  document.getElementById("toggle-content").addEventListener("click", function () {
    const summary = document.getElementById("post-summary");
    const full = document.getElementById("post-full");
    if (full.classList.contains("d-none")) {
      summary.classList.add("d-none");
      full.classList.remove("d-none");
      this.textContent = "Ẩn bớt";
    } else {
      summary.classList.remove("d-none");
      full.classList.add("d-none");
      this.textContent = "Xem thêm";
    }
  });

  // Focus vào input khi bấm "Bình luận"
  document.getElementById("comment-btn").addEventListener("click", function () {
    document.getElementById("comment-input").focus();
  });

  // Sao chép URL khi chia sẻ
  function sharePost() {
    const url = window.location.href;
    navigator.clipboard.writeText(url).then(() => {
      alert("Đã sao chép liên kết vào bộ nhớ tạm!");
    });
  }
</script>

</body>
</html>
