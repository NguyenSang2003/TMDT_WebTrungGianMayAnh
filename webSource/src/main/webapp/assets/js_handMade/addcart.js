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
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: new URLSearchParams({
                    action: 'add',
                    productId: productId
                })
            })
                .then(response => {
                    if (response.redirected) {
                        // Nếu server redirect sang trang cart, ta có thể chuyển trang
                        window.location.href = response.url;
                    } else {
                        alert('Đã thêm sản phẩm vào giỏ hàng!');
                    }
                })
                .catch(error => {
                    console.error('Lỗi khi thêm giỏ hàng:', error);
                    alert('Có lỗi xảy ra khi thêm giỏ hàng.');
                });
        });
    });
});