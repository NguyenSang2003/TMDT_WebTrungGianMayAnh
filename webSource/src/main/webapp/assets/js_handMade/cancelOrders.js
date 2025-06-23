document.addEventListener("DOMContentLoaded", function () {

    // Hủy đơn hàng
    const cancelButtons = document.querySelectorAll('.cancel-order-btn');

    cancelButtons.forEach(btn => {
        btn.addEventListener('click', function () {
            const orderId = btn.dataset.id;

            Swal.fire({
                title: 'Xác nhận hủy?',
                text: 'Bạn có chắc muốn hủy đơn hàng này?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Hủy đơn',
                cancelButtonText: 'Không',
            }).then((result) => {
                if (result.isConfirmed) {
                    fetch('orders', {
                        method: 'POST', headers: {
                            'X-Requested-With': 'XMLHttpRequest', 'Content-Type': 'application/x-www-form-urlencoded'
                        }, body: new URLSearchParams({
                            orderId: orderId
                        })
                    })
                        .then(response => response.json())
                        .then(data => {
                            Swal.fire({
                                icon: data.status === 'success' ? 'success' : 'error',
                                title: data.status === 'success' ? 'Thành công!' : 'Lỗi!',
                                text: data.message,
                                timer: 1500,
                                showConfirmButton: false
                            });

                            if (data.status === 'success') {
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            }
                        })
                        .catch(err => {
                            Swal.fire('Lỗi!', 'Không thể hủy đơn hàng.', 'error');
                            console.error(err);
                        });
                }
            });
        });
    });
});