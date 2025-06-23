
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
    .inactive-row {
        opacity: 0.4;
    }
    .custom-modal {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        width: 600px;
        background-color: #fff;
        border-radius: 12px;
        box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
        z-index: 9999;
        padding: 25px;
        font-family: Arial, sans-serif;
    }

    .custom-modal h2 {
        margin-top: 0;
        color: #3f51b5;
        text-align: center;
    }

    .custom-modal .field {
        margin-bottom: 12px;
        font-size: 15px;
    }

    .custom-modal .field span {
        font-weight: bold;
    }

    .custom-modal img {
        display: block;
        margin: 10px auto;
        max-width: 100%;
        height: auto;
        border-radius: 10px;
        box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
    }

    .custom-modal .close-btn {
        display: block;
        margin: 15px auto 0;
        padding: 8px 16px;
        background-color: #f44336;
        color: white;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-weight: bold;
    }
    .eye-button {
        background: none;
        border: none;
        cursor: pointer;
        font-size: 18px;
    }
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
                <h2 class="main-title">Quản lý sản phẩm</h2>

                <a href="#" onclick="openAddPopup()" style="display: inline-block; margin-bottom: 15px; background-color: #3f51b5; color: white; padding: 8px 16px; border-radius: 6px; text-decoration: none; font-weight: 500;">➕ Thêm sản phẩm</a>

                <table class="user-table" style="border-collapse: collapse; width: 100%; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.1);">
                    <thead>
                    <tr style="background-color: #3f51b5; color: white;">
                        <th style="padding: 12px;">ID</th>
                        <th style="padding: 12px;">Tên sản phẩm</th>
                        <th style="padding: 12px;">Thương hiệu</th>
                        <th style="padding: 12px;">Giá thuê/ngày</th>
                        <th style="padding: 12px;">Hình ảnh</th>
                        <th style="padding: 12px;">Trạng thái</th>
                        <th style="padding: 12px;">Ẩn/Hiện</th>
                        <th style="padding: 12px;">Hành động</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="product" items="${productList}">
                        <tr style="text-align: center;" class="${product.isActive == 0 ? 'inactive-row' : ''}">
                            <td style="padding: 10px;">${product.id}</td>
                            <td>
                                <a href="javascript:void(0);" onclick="showProductDetail(${product.id})">
                                        ${product.name}
                                </a>
                            </td>
                            <td style="padding: 10px;">${product.brand}</td>
                            <td style="padding: 10px;">${product.pricePerDay}</td>
                            <td style="padding: 10px;">
                                <img src="../${product.imageUrl}" width="100" style="border-radius: 6px; box-shadow: 0 0 4px rgba(0,0,0,0.2);">
                            </td>
                            <td style="padding: 10px;">${product.status}</td>
                            <td style="padding: 10px;">
                                <button class="eye-button" onclick="toggleActiveStatus(${product.id}, ${product.isActive})">
                                    <c:choose>
                                        <c:when test="${product.isActive eq 1}">&#128065;</c:when>
                                        <c:otherwise>&#128584;</c:otherwise>
                                    </c:choose>

                                </button>
                            </td>
                            <td style="padding: 10px;">
                                <a href="#"
                                   onclick="openEditPopup(
                                           '${product.id}',
                                           '${product.name}',
                                           '${product.brand}',
                                           '${product.pricePerDay}',
                                           '${product.quantity}',
                                           '${product.status}',
                                           '${product.imageUrl}',
                                           '${product.createdAt}')"
                                   style="color: #1976d2; margin-right: 10px; text-decoration: none; font-weight: 500;">✏️ Sửa</a>
                                <a href="#" onclick="openDeletePopup('${product.id}')" style="background-color: #f44336; color: white; padding: 5px 10px; border-radius: 5px; text-decoration: none; font-weight: 500;">❌ Xoá</a>
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
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
<!-- Modal thêm/sửa sản phẩm -->
<!-- Nền mờ -->
<div id="overlay" class="modal-overlay" onclick="closePopup()"></div>

<!-- Modal thêm/sửa sản phẩm -->
<div id="overlay" class="modal-overlay" onclick="closePopup()"></div>

<div id="productModal" class="modal" style="display:none;">
    <h3 id="modalTitle">Thêm/Sửa sản phẩm</h3>
    <form id="productForm" method="post" action="${pageContext.request.contextPath}/admin/productsManagement">
        <input type="hidden" name="id" id="productId">
        <label>Tên sản phẩm: <input type="text" name="name" id="productName" required style="width:100%"></label><br><br>
        <label>Thương hiệu: <input type="text" name="brand" id="productBrand" required style="width:100%"></label><br><br>
        <label>Giá thuê/ngày:
            <input type="number" step="0.01" name="pricePerDay" id="productPrice" required style="width:100%">
        </label>
        <label>Hình ảnh URL: <input type="text" name="imageUrl" id="productImage" required style="width:100%"></label><br><br>
        <label>Số lượng: <input type="number" name="quantity" id="productQuantity" min="1" style="width:100%"></label><br><br>

        <div id="statusField" style="display: none;">
            <label>Trạng thái:
                <select name="status" id="productStatus" style="width:100%">
                    <option value="con_hang">Còn hàng</option>
                    <option value="het_hang">Hết hàng</option>
                    <option value="dang_cho_thue">Đang cho thuê</option>
                </select>
            </label><br><br>
        </div>

        <label>Loại: <input type="text" name="category" id="modalCategory" required style="width:100%"></label><br><br>
        <label>Phiên bản: <input type="text" name="model" id="modalModel" required style="width:100%"></label><br><br>
        <label>Màu: <input type="text" name="color" id="modalColor" min="1" style="width:100%"></label><br><br>
        <label>Cân nặng: <input type="text" name="weight" id="modalWeight" required style="width:100%"></label><br><br>
        <label>Mô tả: <input type="text" name="description" id="modalDescription" required style="width:100%"></label><br><br>

        <label>Ngày tạo:
            <input type="datetime-local" name="created_at" id="productCreatedAt" required style="width:100%">
        </label><br><br>
        <button type="submit">💾 Lưu</button>
        <button type="button" onclick="closePopup()">❌ Hủy</button>
    </form>
</div>

<!-- Modal xoá -->
<div id="deleteModal" class="modal" style="display:none;">
    <p>Bạn có chắc muốn xoá sản phẩm này không?</p>
    <form method="post" action="${pageContext.request.contextPath}/admin/deleteProduct">
        <input type="hidden" name="id" id="deleteProductId">
        <button type="submit">🗑️ Xoá</button>
        <button type="button" onclick="closePopup()">❌ Hủy</button>
    </form>
</div>
<!-- Modal chi tiết sản phẩm -->
<div id="productDetailModal" class="custom-modal">
    <h2 id="modalName">Tên sản phẩm</h2>
    <div class="field"><span>Thương hiệu:</span> <span id="modalBrand"></span></div>
    <div class="field"><span>Mô tả:</span> <span id="modalDescription"></span></div>
    <div class="field"><span>Giá thuê/ngày:</span> <span id="modalPrice"></span></div>
    <div class="field"><span>Trạng thái:</span> <span id="modalStatus"></span></div>
    <div class="field"><span>Model:</span> <span id="modalModel"></span></div>
    <div class="field"><span>Phân loại:</span> <span id="modalCategory"></span></div>
    <div class="field"><span>Màu sắc:</span> <span id="modalColor"></span></div>
    <div class="field"><span>Phụ kiện kèm theo:</span> <span id="modalAccessories"></span></div>
    <div class="field"><span>Trọng lượng:</span> <span id="modalWeight"></span> kg</div>
    <div class="field"><span>Tình trạng:</span> <span id="modalCondition"></span></div>
    <div class="field"><span>Ngày tạo:</span> <span id="modalCreatedAt"></span></div>
    <img id="modalImage" src="" alt="Ảnh sản phẩm">
    <button class="close-btn" onclick="closeModal()">Đóng</button>
</div>

<script>
    function openAddPopup() {
        document.getElementById("modalTitle").innerText = "➕ Thêm sản phẩm";
        document.getElementById("productForm").reset();
        document.getElementById("productId").value = "";
        document.getElementById("productModal").style.display = "block";
        document.getElementById("statusField").style.display = "none";
    }

    function openEditPopup(id, name, brand, pricePerDay,quantity, status, imageUrl,category,model,color,weight,description, createdAt) {
        document.getElementById("modalTitle").innerText = "✏️ Sửa sản phẩm";
        document.getElementById("productId").value = id;
        document.getElementById("productName").value = name;
        document.getElementById("productBrand").value = brand;
        document.getElementById("productPrice").value = pricePerDay;
        document.getElementById("productQuantity").value = quantity; // nhớ thêm biến quantity vào hàm
        document.getElementById("productImage").value = imageUrl;
        document.getElementById("modalCategory").value = category;
        document.getElementById("modalModel").value = model;
        document.getElementById("modalColor").value = color;
        document.getElementById("modalWeight").value = weight;
        document.getElementById("modalDescription").value = description;

        document.getElementById("statusField").style.display = "block";
        document.getElementById("productStatus").value = status;

        if (createdAt) {
            // Format createdAt thành yyyy-MM-ddTHH:mm cho datetime-local
            const ts = new Date(createdAt);
            const iso = ts.toISOString().slice(0, 16);
            document.getElementById("productCreatedAt").value = iso;
        }

        document.getElementById("productModal").style.display = "block";
    }

    function openDeletePopup(id) {
        document.getElementById("deleteProductId").value = id;
        document.getElementById("deleteModal").style.display = "block";
    }

    function closePopup() {
        document.getElementById("productModal").style.display = "none";
        document.getElementById("deleteModal").style.display = "none";
    }
</script>
<script>
    function toggleActiveStatus(productId, currentStatus) {
        const newStatus = currentStatus === 1 ? 0 : 1;
        fetch('${pageContext.request.contextPath}/admin/toggleActive?id=' + productId + '&status=' + newStatus, {
            method: 'POST'
        })
            .then(response => {
                if (response.ok) {
                    location.reload();
                } else {
                    alert("Không thể cập nhật trạng thái hiển thị!");
                }
            });
    }
</script>
<script>
    function showProductDetail(productId) {
        fetch('/admin/product-detail?id=' + productId)
            .then(res => res.json())
            .then(data => {
                const modal = document.getElementById("productDetailModal");
                document.getElementById("modalName").textContent = data.name;
                document.getElementById("modalBrand").textContent = data.brand;
                document.getElementById("modalDescription").textContent = data.description;
                document.getElementById("modalPrice").textContent = data.pricePerDay;
                document.getElementById("modalStatus").textContent = data.status;
                document.getElementById("modalModel").textContent = data.model || "Không rõ";
                document.getElementById("modalCategory").textContent = data.category;
                document.getElementById("modalColor").textContent = data.color;
                document.getElementById("modalAccessories").textContent = data.accessories || "Không có";
                document.getElementById("modalWeight").textContent = data.weight ? data.weight + " kg" : "N/A";
                document.getElementById("modalCondition").textContent = data.productCondition;
                document.getElementById("modalCreatedAt").textContent = new Date(data.createdAt).toLocaleString();
                document.getElementById("modalImage").src = '../' + data.imageUrl;

                modal.style.display = "block";
            });
    }

    function closeModal() {
        document.getElementById("productDetailModal").style.display = "none";
    }

</script>

</html>