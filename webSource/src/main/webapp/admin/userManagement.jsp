
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


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
<style>
    /* Nền mờ phía sau modal */
    .modal-overlay {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.4);
        z-index: 999;
        display: none;
    }

    /* Popup modal chính giữa, to hơn */
    .modal {
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 600px;
        background-color: #fff;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 0 15px rgba(0,0,0,0.2);
        z-index: 1000;
    }
</style>

<body>
<%
    Exception e = (Exception) request.getAttribute("javax.servlet.error.exception");
    if (e != null) {
        e.printStackTrace(new java.io.PrintWriter(String.valueOf(out)));
    }
%>
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
                        <a class="active" href="/adminIndex"><span class="icon home" aria-hidden="true"></span>Quản lý hệ thống </a>
                    </li>
                    <li>
                        <a class="active" href="/aProductsManagement"><span class="icon folder" aria-hidden="true"></span>Quản lý sản phẩm </a>
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
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>EagleCam Selection 365 | Admin</title>
            <link rel="shortcut icon" href="#" type="image/x-icon">
            <link rel="stylesheet" href="../adminAssets/css/style.min.css">
            <style>
                .user-form {
                    margin-top: 20px;
                    background-color: #f9f9f9;
                    padding: 20px;
                    border-radius: 10px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
                }

                .user-form input,
                .user-form select,
                .user-form button {
                    margin-right: 10px;
                    padding: 8px 12px;
                    border-radius: 6px;
                    border: 1px solid #ccc;
                }

                .user-form button {
                    background-color: #3f51b5;
                    color: white;
                    border: none;
                    cursor: pointer;
                }

                .user-form button:hover {
                    background-color: #303f9f;
                }

                .user-table {
                    width: 100%;
                    border-collapse: collapse;
                    margin-top: 30px;
                    border-radius: 10px;
                    overflow: hidden;
                    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
                    background: #fff;
                }

                .user-table th {
                    background-color: #3f51b5;
                    color: white;
                    padding: 12px;
                    text-align: center;
                }

                .user-table td {
                    padding: 10px;
                    text-align: center;
                    border-bottom: 1px solid #ddd;
                }

                .user-table tr:hover {
                    background-color: #f1f1f1;
                }

                .delete-btn {
                    background-color: #f44336;
                    color: white;
                    padding: 5px 10px;
                    border: none;
                    border-radius: 5px;
                    cursor: pointer;
                }

                .delete-btn:hover {
                    background-color: #d32f2f;
                }
            </style>
        </head>

        <body>
        <div class="main-wrapper">
            <main class="main users chart-page" id="skip-target">
                <div class="container">
                    <h2 class="main-title">Quản lý khách hàng</h2>

                    <form action="${pageContext.request.contextPath}/admin/users" method="post" class="user-form">
                        <input type="hidden" name="action" value="add"/>
                        <input name="username" placeholder="Username" required>
                        <input name="email" placeholder="Email" required>
                        <input name="role" placeholder="Role" required>
                        <select name="isVerifyEmail">
                            <option value="true">Đã xác thực</option>
                            <option value="false">Chưa xác thực</option>
                        </select>
                        <select name="isActive">
                            <option value="true">Active</option>
                            <option value="false">Blocked</option>
                        </select>
                        <button type="submit">Thêm người dùng</button>
                    </form>

                    <table class="user-table">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Xác thực Email</th>
                            <th>Active</th>
                            <th>Created At</th>
                            <th>Thao tác</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="u" items="${userList}">
                            <tr>
                                <td>${u.id}</td>
                                <td>${u.username}</td>
                                <td>${u.email}</td>
                                <td>${u.role}</td>
                                <td>${u.verifyEmail}</td>
                                <td>${u.active}</td>
                                <td>${u.createdAt}</td>
                                <td>
                                    <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete"/>
                                        <input type="hidden" name="id" value="${u.id}"/>
                                        <button class="delete-btn" type="submit" onclick="return confirm('Xoá user này?')">Xoá</button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
        </body>
        </html>

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