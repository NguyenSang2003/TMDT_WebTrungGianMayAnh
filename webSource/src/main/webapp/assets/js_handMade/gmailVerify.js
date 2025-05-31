window.onload = function () {
    const resendButton = document.getElementById("btnResendCode");
    const countdownDisplay = document.getElementById("countdown");

    if (resendButton) {
        resendButton.disabled = false;

        resendButton.addEventListener("click", function () {
            resendButton.disabled = true;
            resendButton.innerText = "Đang gửi...";

            fetch("resendVerification", {
                method: "POST"
            })
                .then(response => {
                    return response.text().then(text => {
                        console.log("Raw response:", text); // Log JSON/raw text
                        return JSON.parse(text); // chuyển lại về object nếu đúng JSON
                    });
                })
                .then(data => {
                    // Hiện swal
                    swal({
                        title: data.status === "success" ? "Thành công!" : "Thất bại!",
                        text: data.message,
                        icon: data.status === "success" ? "success" : "error",
                        button: "OK",
                    });

                    if (data.status === "success") {
                        startCountdown(90);
                    } else {
                        // Nếu gửi thất bại vẫn cho thử lại
                        resendButton.innerText = "Gửi lại mã xác minh";
                        resendButton.disabled = false;
                    }
                })
                .catch(error => {
                    console.error("Lỗi gửi mã xác minh:", error);
                    swal("Lỗi!", "Không thể gửi mã xác minh. Vui lòng thử lại sau.", "error");
                    resendButton.innerText = "Gửi lại mã xác minh";
                    resendButton.disabled = false;
                });
        });
    }

    function startCountdown(seconds) {
        let remaining = seconds;

        resendButton.innerText = `Chờ ${remaining}s`;
        countdownDisplay.innerText = `Vui lòng chờ ${remaining} giây trước khi gửi lại.`;

        const interval = setInterval(() => {
            remaining--;
            resendButton.innerText = `Chờ ${remaining}s`;
            countdownDisplay.innerText = `Vui lòng chờ ${remaining} giây trước khi gửi lại.`;

            if (remaining <= 0) {
                clearInterval(interval);
                resendButton.innerText = "Gửi mã xác minh";
                countdownDisplay.innerText = "";
                resendButton.disabled = false;
            }
        }, 1000);
    }

};