<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý đơn thuê</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Bootstrap Icons CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"
	rel="stylesheet">

</head>
<body>
	<div class="d-flex vh-100">
		<div class="d-flex flex-column"
			style="min-width: 280px; background-color: #5C9DF5; color: white">
			<h2 class="text-center fs-6 p-5">EagleCam Selection 365</h2>

			<div class="mb-auto">
				<a href="#" class="bg-transparent border-0 text-white d-block px-4 py-2 fw-bold text-decoration-none">
					<p class="d-flex align-items-center gap-3 m-0">
						<i class="bi bi-person-fill fs-3"></i><span>Quản lý khách hàng</span>
					</p>
				</a> 
				<a href="#" class="bg-transparent border-0 text-white d-block px-4 py-2 fw-bold text-decoration-none">
					<p class="d-flex align-items-center gap-3 m-0">
						<i class="bi bi-person-fill fs-3"></i><span>Quản lý người cho thuê</span>
					</p>
				</a> 
				<a href="#" class="bg-primary border-0 active text-white d-block px-4 py-2 fw-bold text-decoration-none">
					<p class="d-flex align-items-center gap-3 m-0">
						<i class="bi bi-pencil-square fs-3"></i><span>Quản lý người cho thuê</span>
					</p>
				</a> 
				<a href="#" class="bg-transparent border-0 text-white d-block px-4 py-2 fw-bold text-decoration-none">
					<p class="d-flex align-items-center gap-3 m-0">
						<i class="bi bi-archive-fill fs-3"></i><span>Quản lý sản phẩm</span>
					</p>
				</a>
			</div>
		</div>

		<div class="flex-grow-1 p-4 bg-light">
			<div class="d-flex ">
				<div class="flex-grow-1 mt-auto">
					<h3> Quản lý đơn thuê </h3>
					<p class="text-muted">Admin >> Quản lý đơn thuê</p>
				</div>
				<div class="d-flex gap-5 align-items-center">
					<div class="d-flex flex-column gap-2 flex-wrap">
						<input type="text" class="form-control w-auto"
							style="min-width: 350px;"
							placeholder="Tên khách hàng / Tên thuê / Mã hóa đơn">
						<div class="d-flex justify-content-between">
							<input type="date" class="form-control w-auto"> 
							<input type="date" class="form-control w-auto">
						</div>
						<button class="btn btn-primary">Tìm kiếm</button>
					</div>
					<div class="admin-profile text-center" style="margin-right: 2rem">
						<img src="https://vj360.vn/wp-content/uploads/2022/01/may-anh-chup-anh-duong-pho-dep-nhat.jpg"
							 style="width: 120px; height: 120px; border-radius: 50%; object-fit: cover;"
							 alt="Admin" class="mb-2">
						<div>Admin Profile</div>
					</div>
				</div>
			</div>

			<div class="mb-3 d-flex gap-4 flex-wrap">
				<span>Số lượng hóa đơn: <strong>1</strong></span> <span>Tổng
					tiền đã thanh toán: <strong>1.000.000đ</strong>
				</span> <span>Đơn hàng đã hoàn thành: <strong>1</strong></span>
			</div>

			<div class="table-responsive">
				<table class="table table-bordered table-hover bg-white">
					<thead class="table-light">
						<tr>
							<th>STT</th>
							<th>Mã đơn thuê</th>
							<th>Người thuê</th>
							<th>Địa chỉ</th>
							<th>Ngày thuê</th>
							<th>Ngày trả</th>
							<th>Sản phẩm</th>
							<th>Hư hỏng</th>
							<th>Tổng tiền</th>
							<th>Trạng thái</th>
							<th>Chức năng</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>1</td>
							<td>HD01</td>
							<td>Phạm Văn A</td>
							<td>100 đường a, P.Linh Trung</td>
							<td>12/05/2024</td>
							<td>15/05/2024</td>
							<td>Camera 4K</td>
							<td>0</td>
							<td>1,000,000đ</td>
							<td>Hoàn thành</td>
							<td><a href="#">Chi tiết</a> / <a href="#">Hủy</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
