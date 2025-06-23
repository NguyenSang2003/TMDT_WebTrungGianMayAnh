// Xác nhận khi xóa từng sản phẩm
document.querySelectorAll('.remove-item-btn').forEach(function (btn) {
    btn.addEventListener('click', function () {
        Swal.fire({
            title: 'Xóa sản phẩm?',
            text: 'Bạn có chắc chắn muốn xóa sản phẩm này khỏi giỏ hàng không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Có, xóa đi!',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                btn.closest('form').submit();
            }
        });
    });
});

// Xác nhận khi xóa toàn bộ giỏ hàng
const clearCartBtn = document.getElementById('clear-cart-btn');
if (clearCartBtn) {
    clearCartBtn.addEventListener('click', function () {
        Swal.fire({
            title: 'Xóa tất cả sản phẩm?',
            text: 'Bạn có chắc chắn muốn xóa toàn bộ sản phẩm trong giỏ hàng không?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonText: 'Có, xóa tất cả!',
            cancelButtonText: 'Hủy'
        }).then((result) => {
            if (result.isConfirmed) {
                document.getElementById('clear-cart-form').submit();
            }
        });
    });
}