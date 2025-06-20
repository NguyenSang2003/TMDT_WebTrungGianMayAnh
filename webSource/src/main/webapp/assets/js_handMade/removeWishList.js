document.addEventListener("DOMContentLoaded", function () {
    const buttons = document.querySelectorAll(".btn-remove-wishlist");

    buttons.forEach(btn => {
        btn.addEventListener("click", function () {
            const productId = this.dataset.productId;

            Swal.fire({
                title: "Bạn có chắc muốn xóa?",
                text: "Sản phẩm sẽ bị xóa khỏi danh sách yêu thích.",
                icon: "warning",
                showCancelButton: true,
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                confirmButtonText: "Xóa",
                cancelButtonText: "Hủy"
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch("wishlist?productId=" + productId, {
                        method: "DELETE"
                    })
                        .then(response => {
                            if (response.status === 401) {
                                // Chưa đăng nhập, session hết hạn
                                Swal.fire({
                                    icon: "warning",
                                    title: "Phiên đăng nhập đã hết",
                                    text: "Vui lòng đăng nhập lại.",
                                    confirmButtonText: "Đăng nhập"
                                }).then(() => {
                                    window.location.href = "login.jsp";
                                });
                                return;
                            }

                            if (response.ok) {
                                Swal.fire({
                                    icon: "success",
                                    title: "Đã xóa!",
                                    text: "Sản phẩm đã được xóa khỏi yêu thích.",
                                    timer: 1500,
                                    showConfirmButton: false
                                }).then(() => {
                                    window.location.reload(); // Tải lại để cập nhật
                                });
                            } else {
                                Swal.fire("Lỗi!", "Xóa sản phẩm thất bại.", "error");
                            }
                        });

                }
            });
        });
    });
});