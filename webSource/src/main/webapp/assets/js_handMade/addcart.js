document.addEventListener("DOMContentLoaded", function () {
    var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
    var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
        return new bootstrap.Tooltip(tooltipTriggerEl);
    });

    const buttons = document.querySelectorAll('.cart-btn');

    buttons.forEach(btn => {
        btn.addEventListener('click', function () {
            const productId = btn.dataset.id;

            fetch('cart', {
                method: 'POST',
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    action: 'add',
                    productId: productId
                })
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error("Lỗi response");
                    }
                    return response.json();
                })
                .then(data => {
                    Swal.fire({
                        title: "Thành công!",
                        text: data.message,
                        icon: "success",
                        showConfirmButton: false,
                        timer: 1030
                    });
                })
                .catch(error => {
                    console.error('Lỗi khi thêm giỏ hàng:', error);
                    Swal.fire({
                        title: "Lỗi!",
                        text: "Không thể thêm sản phẩm. Vui lòng thử lại.",
                        icon: "error"
                    });
                });
        });
    });
});
