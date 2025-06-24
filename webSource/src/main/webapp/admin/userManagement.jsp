
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
    <link rel="stylesheet" href="../adminAssets/css/useradmin.css">
</head>
<style>
    .faded-row {
        opacity: 0.4;
        transition: opacity 0.3s ease;
    }
</style>

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
                            <a class="active" href="/admin/users"><span class="icon user-3" aria-hidden="true"></span>Quản lý khách hàng </a>
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
        <!-- Main content for User Management -->
        <main class="main users chart-page" id="skip-target">
            <div class="container">
                <h2 class="main-title">Quản lý Khách Hàng</h2>

                <a href="#" onclick="openAddPopup()" style="display: inline-block; margin-bottom: 15px; background-color: #3f51b5; color: white; padding: 8px 16px; border-radius: 6px; text-decoration: none; font-weight: 500;">➕ Thêm người dùng</a>
                <form method="get" action="${pageContext.request.contextPath}/admin/users" class="filter-form">
                    <input type="text" name="keyword" class="filter-input" placeholder="🔍 Tên hoặc email..." value="${searchKeyword}" />

                    <select name="role" class="filter-select">
                        <option value="">-- Vai trò --</option>
                        <option value="admin" ${selectedRole == 'admin' ? 'selected' : ''}>Admin</option>
                        <option value="khach_thue" ${selectedRole == 'khach_thue' ? 'selected' : ''}>Khách thuê</option>
                        <option value="nguoi_cho_thue" ${selectedRole == 'nguoi_cho_thue' ? 'selected' : ''}>Người cho thuê</option>
                    </select>

                    <select name="active" class="filter-select">
                        <option value="">-- Trạng thái --</option>
                        <option value="true" ${selectedActive == 'true' ? 'selected' : ''}>Hoạt động</option>
                        <option value="false" ${selectedActive == 'false' ? 'selected' : ''}>Vô hiệu</option>
                    </select>

                    <button type="submit" class="filter-btn">Lọc</button>
                    <a href="${pageContext.request.contextPath}/admin/users" class="clear-btn">Xóa bộ lọc</a>
                </form>



                <table class="user-table" style="border-collapse: collapse; width: 100%; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
                    <thead>
                    <tr style="background-color: #3f51b5; color: white;">
                        <th style="padding: 12px;">ID</th>
                        <th style="padding: 12px;">Username</th>
                        <th style="padding: 12px;">Email</th>
                        <th style="padding: 12px;">Role</th>
                        <th style="padding: 12px;">Xác Thực Email</th>
                        <th style="padding: 12px;">Active</th>
                        <th style="padding: 12px;">Created At</th>
                        <th style="padding: 12px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="user" items="${userList}">
                        <tr id="userRow_${user.id}" class="${!user.active ? 'faded-row' : ''}">
                        <td style="padding: 10px;">${user.id}</td>
                            <td>
    <span style="color:blue; cursor:pointer; text-decoration:underline;"
          onclick="showUserProfile(${user.id})">${user.username}</span>
                            </td>


                            <td style="padding: 10px;">${user.email}</td>
                            <td>
                                <select onchange="changeRole(${user.id}, this.value)">
                                    <option value="USER" ${user.role == 'khach_thue' ? 'selected' : ''}>khach_thue</option>
                                    <option value="ADMIN" ${user.role == 'nguoi_cho_thue' ? 'selected' : ''}>nguoi_cho_thue</option>
                                    <option value="STAFF" ${user.role == 'admin' ? 'selected' : ''}>admin</option>
                                </select>
                            </td>

                            <td style="padding: 10px;">${user.verifyEmail}</td>
                            <td style="padding: 10px;">
                                <button id="toggleIcon_${user.id}"
                                        onclick="toggleUserActive(${user.id}, ${user.active ? 1 : 0})"
                                        style="border:none; background:none; cursor:pointer;"
                                        title="${user.active ? 'Ẩn tài khoản' : 'Hiện tài khoản'}">
                                    <c:choose>
                                        <c:when test="${user.active}">
                                            👁️
                                        </c:when>
                                        <c:otherwise>
                                            🙈
                                        </c:otherwise>
                                    </c:choose>
                                </button>
                            </td>
                            </td>
                            <td style="padding: 10px;">${user.createdAt}</td>
                            <td style="padding: 10px;">
                                <a href="#" onclick="openEditPopup('${user.id}', '${user.username}', '${user.email}', '${user.role}', '${user.verifyEmail}', '${user.active}')" style="color: #1976d2; margin-right: 10px; text-decoration: none; font-weight: 500;">✏️ Sửa</a>
                                <form action="${pageContext.request.contextPath}/admin/users" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                                    <input type="hidden" name="id" value="${user.id}" />
                                    <input type="hidden" name="action" value="delete" />
                                    <button type="submit" style="background-color: #f44336; color: white; padding: 5px 10px; border-radius: 5px; border: none; font-weight: 500;">❌ Xóa</button>
                                </form>

                            </td>
                        </tr>
                    </c:forEach>
                    <script>
                            const contextPath = '<%= request.getContextPath() %>';

                            function changeUserRole(userId, newRole) {
                            fetch(`${contextPath}/admin/change-role`, {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                                body: `id=${userId}&role=${encodeURIComponent(newRole)}`
                            })
                                .then(response => response.json())
                                .then(data => {
                                    if (data.success) {
                                        alert("✅ Vai trò đã được cập nhật.");
                                        location.reload(); // Tùy chọn reload lại danh sách
                                    } else {
                                        alert("❌ Cập nhật thất bại.");
                                    }
                                })
                                .catch(error => {
                                    console.error("Lỗi:", error);
                                    alert("Lỗi kết nối.");
                                });
                        }
                    </script>

<script>
                    function toggleUserActive(userId, currentStatus) {
                            const newStatus = currentStatus === 1 ? 0 : 1;

                            fetch('${pageContext.request.contextPath}/admin/toggleUserActive?id=' + userId + '&status=' + newStatus, {
                                method: 'POST'
                            }).then(response => {
                                if (response.ok) {
                                    // Cập nhật icon và dòng bị mờ ngay trên giao diện
                                    const iconBtn = document.getElementById("toggleIcon_" + userId);
                                    const row = document.getElementById("userRow_" + userId);

                                    if (newStatus === 0) {
                                        iconBtn.innerHTML = "🙈"; // Ẩn
                                        iconBtn.title = "Hiện tài khoản";
                                        row.classList.add("faded-row");
                                    } else {
                                        iconBtn.innerHTML = "👁️"; // Hiện
                                        iconBtn.title = "Ẩn tài khoản";
                                        row.classList.remove("faded-row");
                                    }

                                    // Cập nhật trạng thái onclick
                                    iconBtn.setAttribute("onclick", `toggleUserActive(${userId}, ${newStatus})`);
                                } else {
                                    alert("Không thể cập nhật trạng thái!");
                                }
                            });
                        }
                    </script>


                    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
                    <script>
                        function confirmDelete(userId) {
                            Swal.fire({
                                title: 'Bạn chắc chắn muốn xóa?',
                                text: "Tài khoản sẽ bị xóa vĩnh viễn!",
                                icon: 'warning',
                                showCancelButton: true,
                                confirmButtonColor: '#d33',
                                cancelButtonColor: '#3085d6',
                                confirmButtonText: 'Vâng, xóa!',
                                cancelButtonText: 'Hủy'
                            }).then((result) => {
                                if (result.isConfirmed) {
                                    const form = document.createElement("form");
                                    form.method = "POST";
                                    form.action = "${pageContext.request.contextPath}/admin/users";

                                    const idInput = document.createElement("input");
                                    idInput.type = "hidden";
                                    idInput.name = "id";
                                    idInput.value = userId;

                                    const actionInput = document.createElement("input");
                                    actionInput.type = "hidden";
                                    actionInput.name = "action";
                                    actionInput.value = "delete";

                                    form.appendChild(idInput);
                                    form.appendChild(actionInput);
                                    document.body.appendChild(form);
                                    form.submit();
                                }
                            });
                        }
                    </script>


                    </tbody>
                </table>

            </div>
        </main>

        <!-- Modal thêm/sửa user -->
        <div id="userModal" class="modal" style="display:none;">
            <h3 id="modalTitle">Thêm/Sửa người dùng</h3>
            <form id="userForm" method="post" action="${pageContext.request.contextPath}/admin/users">
                <input type="hidden" name="id" id="userId">
                <input type="hidden" name="action" id="userAction">
                <label>Username: <input type="text" name="username" id="username" required style="width:100%"></label><br><br>
                <label>Email: <input type="email" name="email" id="email" required style="width:100%"></label><br><br>
                <label>Role:
                    <select name="role" id="role" style="width:100%">
                        <option value="khachthue">khach_thue</option>
                        <option value="nguoichothue">nguoi_cho_thue</option>
                        <option value="admin">admin</option>
                    </select>
                </label><br><br>
                <label>Xác Thực Email: <input type="checkbox" name="isVerifyEmail" id="verifyEmail"></label><br><br>
                <label>Active: <input type="checkbox" name="isActive" id="isActive"></label><br><br>
                <button type="submit">💾 Lưu</button>
                <button type="button" onclick="closePopup()">❌ Hủy</button>
            </form>
        </div>

        <!-- Modal hiển thị chi tiết User Profile -->
        <div id="userProfileModal" class="custom-modal" style="display:none; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%);
     width:500px; background:#fff; padding:20px; border-radius:10px; box-shadow:0 5px 15px rgba(0,0,0,0.3); z-index:9999;">
            <div style="display:flex; justify-content:space-between; align-items:center;">
                <h2>Chi tiết hồ sơ người dùng</h2>
                <button onclick="closeModal()" style="font-size:18px; background:none; border:none; cursor:pointer;">×</button>
            </div>
            <hr>
            <div id="profileContent"></div>
        </div>

        <!-- Overlay (mờ nền) -->
        <div id="overlay" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
     background-color:rgba(0,0,0,0.5); z-index:9998;"></div>


        <script>
            function openAddPopup() {
                document.getElementById("modalTitle").innerText = "➕ Thêm người dùng";
                document.getElementById("userForm").reset();
                document.getElementById("userId").value = "";
                document.getElementById("userAction").value = "add";
                document.getElementById("userModal").style.display = "block";
            }

            function openEditPopup(id, username, email, role, verifyEmail, isActive) {
                document.getElementById("modalTitle").innerText = "✏️ Sửa người dùng";
                document.getElementById("userId").value = id;
                document.getElementById("username").value = username;
                document.getElementById("email").value = email;
                document.getElementById("role").value = role;
                document.getElementById("verifyEmail").checked = (verifyEmail === 'true');
                document.getElementById("isActive").checked = (isActive === 'true');
                document.getElementById("userAction").value = "update";
                document.getElementById("userModal").style.display = "block";
            }

            function closePopup() {
                document.getElementById("userModal").style.display = "none";
            }
            </script>
            <script>
                function showUserProfile(userId) {
                fetch(`/admin/user-profile?id=` + userId)
                    .then(res => res.json())
                    .then(data => {
                        const container = document.getElementById("profileContent");

                        const img1 = data.idCardImageUrl
                            ? `<img src="${data.idCardImageUrl}" alt="CMND" width="200">`
                            : 'Chưa có';

                        const img2 = data.idCardWithUserImageUrl
                            ? `<img src="${data.idCardWithUserImageUrl}" alt="CMND kèm người" width="200">`
                            : 'Chưa có';

                        container.innerHTML = `
                <p><strong>Họ tên:</strong> ${data.fullName || 'Không rõ'}</p>
                <p><strong>Số CMND:</strong> ${data.idCardNumber || 'Không rõ'}</p>
                <p><strong>Địa chỉ:</strong> ${data.address || 'Không rõ'}</p>
                <p><strong>Số điện thoại:</strong> ${data.phoneNumber || 'Không rõ'}</p>
                <p><strong>Ngày sinh:</strong> ${data.dateOfBirth || 'Không rõ'}</p>
                <p><strong>Xác thực danh tính:</strong> ${data.verifiedIdentity ? 'Đã xác minh' : 'Chưa xác minh'}</p>
                <p><strong>Ảnh CMND:</strong><br>${img1}</p>
                <p><strong>Ảnh CMND kèm người:</strong><br>${img2}</p>
            `;

                        document.getElementById("userProfileModal").style.display = "block";
                    })
                    .catch(err => {
                        console.error("Lỗi khi gọi API:", err);
                        document.getElementById("profileContent").innerHTML = `<p style="color:red;">Không thể tải dữ liệu.</p>`;
                        document.getElementById("userProfileModal").style.display = "block";
                    });
            }

                function closeModal() {
                document.getElementById("userProfileModal").style.display = "none";
            }

        </script>

    </div>
</div>
</html>