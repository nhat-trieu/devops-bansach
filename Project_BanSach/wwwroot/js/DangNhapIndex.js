var result;
var check;

function DangKy() {
    var sdt = $("#sdt").val();
    var matkhau = $("#pass").val();
    console.log("Đăng ký:", sdt, matkhau);

    const data = {
        sdt: sdt,
        matkhau: matkhau
    };

    request(
        "/DangNhap/DangKy",
        'POST',
        data,
        function (response) {
            console.log("Response từ DangKy:", response);

            if (response.success) {
                try {
                    result = JSON.parse(response.data);
                    console.log("Kết quả:", result);
                } catch (e) {
                    alert("Lỗi xử lý dữ liệu trả về: " + e);
                    return;
                }

                if (result != 0) {
                    alert('Đăng ký thành công!');
                    sessionStorage.setItem("sdt", sdt);
                    sessionStorage.setItem("matkhau", matkhau);
                    location.href = 'https://localhost:7282';
                } else {
                    alert('Tài khoản đã tồn tại. Vui lòng kiểm tra lại!');
                }
            } else {
                alert("Lỗi đăng ký: " + JSON.stringify(response));
            }
        }
    );
}

function DangNhap() {
    var sdt = $("#sdt").val();
    var matkhau = $("#pass").val();
    console.log("Đăng nhập:", sdt, matkhau);

    const data = {
        sdt: sdt,
        matkhau: matkhau
    };

    request(
        "/DangNhap/DangNhap",
        'POST',
        data,
        function (response) {
            console.log("Response từ DangNhap:", response);

            if (response.success) {
                try {
                    check = JSON.parse(response.data);
                    console.log("Check:", check);
                } catch (e) {
                    alert("Lỗi xử lý dữ liệu trả về: " + e);
                    return;
                }

                if (check != 0) {
                    alert('Đăng nhập thành công!');
                    sessionStorage.setItem("sdt", sdt);
                    sessionStorage.setItem("matkhau", matkhau);
                    location.href = 'https://localhost:7282';
                } else {
                    alert('Sai tài khoản hoặc mật khẩu.');
                }
            } else {
                alert("Lỗi đăng nhập: " + JSON.stringify(response));
            }
        }
    );
}
