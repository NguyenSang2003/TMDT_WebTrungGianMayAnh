
document.addEventListener('DOMContentLoaded', function () {
    const form = document.querySelector('form[action="checkout"]');
    if (!form) return;

    form.addEventListener('submit', function (e) {
        // 1. Lấy danh sách các .rental-date có id chứa dấu "_"
        const cartDateInputs = Array.from(document.querySelectorAll('.rental-date'))
            .filter(input => input.id && input.id.includes('_'));
        let allDatesAreValid = true;

        // 2. Xóa các input ẩn cũ để tránh trùng lặp
        form.querySelectorAll('input[name^="rentStart_"], input[name^="rentEnd_"]').forEach(i => i.remove());

        // 3. Duyệt qua từng input hợp lệ
        cartDateInputs.forEach(input => {
            const parts = input.value.split(' to ');
            const start = parts[0]?.trim();
            const end = parts[1]?.trim() || start; // nếu chỉ chọn 1 ngày => end = start

            const idParts = input.id.split('_');
            if (idParts.length < 2) {
                console.warn(`Input có id không đúng định dạng: ${input.id}`);
                allDatesAreValid = false;
                return;
            }
            const productId = idParts[1];

            if (!start) {
                console.warn(`Chưa chọn ngày cho sản phẩm ${productId}`);
                allDatesAreValid = false;
                return;
            }

            // Tạo 2 input ẩn rentStart và rentEnd
            const startInput = document.createElement('input');
            startInput.type = 'hidden';
            startInput.name = `rentStart_` + String(productId);
            startInput.value = start;
            form.appendChild(startInput);

            const endInput = document.createElement('input');
            endInput.type = 'hidden';
            endInput.name = `rentEnd_` + String(productId);
            endInput.value = end;
            form.appendChild(endInput);
        });

        // 4. Nếu có ít nhất một sản phẩm chưa chọn ngày, chặn submit và cảnh báo
        if (!allDatesAreValid) {
            e.preventDefault();
            alert("Vui lòng chọn đầy đủ thời gian thuê cho tất cả sản phẩm.");
            return false;
        }
    });
});