<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EagleCam Selection 365| Admin</title>
    <!-- Favicon -->
    <link rel="shortcut icon" href="#" type="image/x-icon">
    <!-- Custom styles -->
    <link rel="stylesheet" href="../adminAssets/css/style.min.css">
</head>

<body>
<div class="layer"></div>
<!-- ! Body -->
<a class="skip-link sr-only" href="#skip-target">Skip to content</a>
<div class="page-flex">
    <!-- ! Sidebar -->
    <aside class="sidebar">
        <div class="sidebar-start">
            <div class="sidebar-head">
                <a href="#" class="logo-wrapper" title="Home">
                    <span class="sr-only">Home</span>

                    <div class="logo-text">
                        <span class="logo-title">EagleCam 365</span>
                        <span class="logo-subtitle">Admin</span>
                    </div>

                </a>
                <button class="sidebar-toggle transparent-btn" title="Menu" type="button">
                    <span class="sr-only">Toggle menu</span>
                    <span class="icon menu-toggle" aria-hidden="true"></span>
                </button>
            </div>
            <div class="sidebar-body">
                <ul class="sidebar-body-menu">
                    <li>
                        <a class="active" href="/admin/adminIndex"><span class="icon home" aria-hidden="true"></span>Quản lý hệ thống </a>
                    </li>
                    <li>
                        <a class="active" href="/admin/productsManagement"><span class="icon folder" aria-hidden="true"></span>Quản lý sản phẩm </a>
                    </li>
                    <li>
                        <a class="active" href="#"><span class="icon document" aria-hidden="true"></span>Quản lý đơn thuê </a>
                    </li>
                    <li>
                        <a class="active"  href="/RevenueManagement"><span class="icon document" aria-hidden="true"></span>Quản lý doanh thu </a>
                    </li>

                    <li>
                        <a class="active" href="#"><span class="icon message" aria-hidden="true"></span>Quản lý khiếu nại</a>
                    </li>
                    <ul>
                        <li>
                            <a class="show-cat-btn" href="#">
                                <span class="icon users" aria-hidden="true"></span>Quản lý bình luận đánh giá
                                <span class="category__btn transparent-btn" title="Open list">
                        <span class="sr-only">Open list</span>
                        <span class="icon arrow-down" aria-hidden="true"></span>
                    </span>
                            </a>
                            <ul class="cat-sub-menu">
                                <li><a href="#">Quản lý bình luận</a></li>
                                <li><a href="#">Quản lý đánh giá</a></li>
                            </ul>
                        </li>

                        <li>
                            <a class="active" href="/admin/users"><span class="icon user-3" aria-hidden="true"></span>Quản khách hàng </a>
                        </li>
                    </ul>
                </ul>
            </div>
        </div>
        <div class="sidebar-footer">
            <a href="#" class="sidebar-user">
            <span class="sidebar-user-img">
                <picture><source srcset="../adminAssets/img/avatar/avatar-illustrated-01.webp" type="image/webp"><img src="../adminAssets/img/avatar/avatar-illustrated-01.png" alt="User name"></picture>
            </span>
                <div class="sidebar-user-info">
                    <span class="sidebar-user__title">Mrs.Cute</span>
                    <span class="sidebar-user__subtitle">Support manager</span>
                </div>
            </a>
        </div>
    </aside>
    <div class="main-wrapper">
        <!-- ! Main nav -->
        <nav class="main-nav--bg">
            <div class="container main-nav">
                <div class="main-nav-start">
                    <div class="search-wrapper">
                        <i data-feather="search" aria-hidden="true"></i>
                        <label>
                            <input type="text" placeholder="Nhập từ khóa ..." required>
                        </label>
                    </div>
                </div>
                <div class="main-nav-end">
                    <button class="sidebar-toggle transparent-btn" title="Menu" type="button">
                        <span class="sr-only">Toggle menu</span>
                        <span class="icon menu-toggle--gray" aria-hidden="true"></span>
                    </button>
                    <div class="lang-switcher-wrapper">
                        <button class="lang-switcher transparent-btn" type="button">
                            EN
                            <i data-feather="chevron-down" aria-hidden="true"></i>
                        </button>
                        <ul class="lang-menu dropdown">
                            <li><a href="#">English</a></li>
                            <li><a href="#">Vietnamese</a></li>
                        </ul>
                    </div>
                    <div class="notification-wrapper">
                        <button class="gray-circle-btn dropdown-btn" title="To messages" type="button">
                            <span class="sr-only">To messages</span>
                            <span class="icon notification active" aria-hidden="true"></span>
                        </button>
                        <ul class="users-item-dropdown notification-dropdown dropdown">
                            <li>
                                <a href="#">
                                    <div class="notification-dropdown-icon info">
                                        <i data-feather="check"></i>
                                    </div>
                                    <div class="notification-dropdown-text">
                                        <span class="notification-dropdown__title">Hệ thống vừa được cập nhật</span>
                                        <span class="notification-dropdown__subtitle">Hệ thống đã được cập nhật. Đọc thêm tại đây
                  </span>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <div class="notification-dropdown-icon danger">
                                        <i data-feather="info" aria-hidden="true"></i>
                                    </div>
                                    <div class="notification-dropdown-text">
                                        <span class="notification-dropdown__title">Bộ nhớ đệm đã đầy!</span>
                                        <span class="notification-dropdown__subtitle">Các bộ nhớ đệm không cần thiết chiếm nhiều dung lượng và gây cản trở
                  </span>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a href="#">
                                    <div class="notification-dropdown-icon info">
                                        <i data-feather="check" aria-hidden="true"></i>
                                    </div>
                                    <div class="notification-dropdown-text">
                                        <span class="notification-dropdown__title">Có người đăng ký mới!</span>
                                        <span class="notification-dropdown__subtitle">Một người đăng ký mới vừa đăng ký</span>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a class="link-to-page" href="#">Đi tới Trang thông báo</a>
                            </li>
                        </ul>
                    </div>
                    <div class="nav-user-wrapper">
                        <button href="##" class="nav-user-btn dropdown-btn" title="My profile" type="button">
                            <span class="sr-only">My profile</span>
                            <span class="nav-user-img">
            <picture><source srcset="../adminAssets/img/avatar/avatar-illustrated-02.webp" type="image/webp"><img src="../adminAssets/img/avatar/avatar-illustrated-02.png" alt="User name"></picture>
          </span>
                        </button>
                        <ul class="users-item-dropdown nav-user-dropdown dropdown">
                            <li><a href="#">
                                <i data-feather="user" aria-hidden="true"></i>
                                <span>Hồ sơ</span>
                            </a></li>
                            <li><a href="#">
                                <i data-feather="settings" aria-hidden="true"></i>
                                <span>Thiết lập tài khoản</span>
                            </a></li>
                            <li><a class="danger" href="#">
                                <i data-feather="log-out" aria-hidden="true"></i>
                                <span>Đăng xuất</span>
                            </a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        <!-- ! Main -->
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <h2 class="main-title">Quản lý hệ thống</h2>
                <div class="row stat-cards">
                    <div class="col-md-6 col-xl-3">
                        <article class="stat-cards-item">
                            <div class="stat-cards-icon primary">
                                <i data-feather="bar-chart-2" aria-hidden="true"></i>
                            </div>
                            <div class="stat-cards-info">
                                <p class="stat-cards-info__num">1234</p>
                                <p class="stat-cards-info__title">Total Order</p>
                                <p class="stat-cards-info__progress">
                  <span class="stat-cards-info__profit success">
                    <i data-feather="trending-up" aria-hidden="true"></i>4.07%
                  </span>
                                    Last month
                                </p>
                            </div>
                        </article>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <article class="stat-cards-item">
                            <div class="stat-cards-icon warning">
                                <i data-feather="file" aria-hidden="true"></i>
                            </div>
                            <div class="stat-cards-info">
                                <p class="stat-cards-info__num">1234</p>
                                <p class="stat-cards-info__title">Active Oders</p>
                                <p class="stat-cards-info__progress">
                  <span class="stat-cards-info__profit success">
                    <i data-feather="trending-up" aria-hidden="true"></i>0.24%
                  </span>
                                    Last month
                                </p>
                            </div>
                        </article>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <article class="stat-cards-item">
                            <div class="stat-cards-icon purple">
                                <i data-feather="file" aria-hidden="true"></i>
                            </div>
                            <div class="stat-cards-info">
                                <p class="stat-cards-info__num">900</p>
                                <p class="stat-cards-info__title">Completed Orders</p>
                                <p class="stat-cards-info__progress">
                  <span class="stat-cards-info__profit danger">
                    <i data-feather="trending-down" aria-hidden="true"></i>1.64%
                  </span>
                                    Last month
                                </p>
                            </div>
                        </article>
                    </div>
                    <div class="col-md-6 col-xl-3">
                        <article class="stat-cards-item">
                            <div class="stat-cards-icon success">
                                <i data-feather="feather" aria-hidden="true"></i>
                            </div>
                            <div class="stat-cards-info">
                                <p class="stat-cards-info__num">334</p>
                                <p class="stat-cards-info__title">Return Orders</p>
                                <p class="stat-cards-info__progress">
                  <span class="stat-cards-info__profit warning">
                    <i data-feather="trending-up" aria-hidden="true"></i>3.03%
                  </span>
                                    Last month
                                </p>
                            </div>
                        </article>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-9">
                        <div class="chart">
                            <div id="main-content">
                                <jsp:include page="adminRevenueReport.jsp" />
                            </div>
                        </div>
                        <!-- index.jsp -->
                        <div class="users-table table-wrapper">
                            <div id="complain-content">
                                <jsp:include page="adminComplain.jsp" />
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <article class="customers-wrapper">
                            <canvas id="customersChart" aria-label="Customers statistics" role="img"></canvas>
                            <!--              <p class="customers__title">New Customers <span>+958</span></p>
                            <p class="customers__date">28 Daily Avg.</p>
                            <picture><source srcset="./img/svg/customers.svg" type="image/webp"><img src="./img/svg/customers.svg" alt=""></picture> -->
                        </article>
                        <article>
                            <div id="main-content">
                                <jsp:include page="adminBestseller.jsp"/>
                            </div>
                        </article>
                    </div>
                </div>
            </div>
        </main>

        <!-- ! Footer -->
        <footer class="footer">
            <div class="container footer--flex">
                <div class="footer-start">
                    <p>2025 © EagleCamSelection 365 - <a href="#" target="_blank"
                                                         rel="noopener noreferrer">eaglecam-dashboard.com</a></p>
                </div>
                <ul class="footer-end">
                    <li><a href="#">About</a></li>
                    <li><a href="#">Support</a></li>
                    <li><a href="#">Puchase</a></li>
                </ul>
            </div>
        </footer>
    </div>
</div>
<!-- Chart library -->
<script src="../adminAssets/plugins/chart.min.js"></script>
<!-- Icons library -->
<script src="../adminAssets/plugins/feather.min.js"></script>
<!-- Custom scripts -->
<script src="../adminAssets/js/script.js"></script>
</body>

</html>