// Tự động cập nhật phsi ship khi chọn Tỉnh/Thành phố
// document.addEventListener("DOMContentLoaded", function () {
//     // Lấy thẻ select chọn thành phố
//     const citySelect = document.getElementById("city");
//
//     // Lắng nghe sự kiện khi người dùng đổi Tỉnh/Thành phố
//     if (citySelect) {
//         citySelect.addEventListener("change", function () {
//             // Tự động thêm một input ẩn báo cho Servlet biết đây là hành động cập nhật phí ship
//             const form = document.querySelector(".checkout-form");
//             const hiddenAction = document.createElement("input");
//             hiddenAction.type = "hidden";
//             hiddenAction.name = "action";
//             hiddenAction.value = "updateShipping";
//             form.appendChild(hiddenAction);
//
//             // Submit form
//             form.submit();
//         });
//     }
// });

const GHN_TOKEN = 'c277cf3f-6968-11f1-a973-aee5264794df';
const GHN_SHOP_ID = '200731';

document.addEventListener("DOMContentLoaded", function () {
    fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/province', {
        headers: {'token': GHN_TOKEN}
    })
        .then(response => response.json())
        .then(data => {
            let provinceSelect = document.getElementById('province');
            data.data.forEach(item => {
                let option = document.createElement('option');
                option.value = item.ProvinceID;
                option.text = item.ProvinceName;
                provinceSelect.appendChild(option);
            });

            // 2. TỰ ĐỘNG PHỤC HỒI TỈNH KHI TRANG LOAD LẠI
            let savedProv = sessionStorage.getItem('savedProv');
            if(savedProv) {
                provinceSelect.value = savedProv;
                loadDistrict(savedProv, true); // true = Đang phục hồi, không submit form
            }
        })
        .catch(error => console.error('Lỗi load Tỉnh:', error));
});

// Sự kiện đổi Tỉnh
document.getElementById('province').addEventListener('change', function () {
    sessionStorage.setItem('savedProv', this.value);
    sessionStorage.removeItem('savedDist'); // Đổi tỉnh thì xóa huyện cũ
    sessionStorage.removeItem('savedWard'); // Đổi tỉnh thì xóa xã cũ
    loadDistrict(this.value, false);
});

// Hàm Load Quận/Huyện
function loadDistrict(provinceId, isRestoring) {
    let districtSelect = document.getElementById('district');
    let wardSelect = document.getElementById('ward');

    districtSelect.innerHTML = '<option value="">-- Chọn Quận/Huyện --</option>';
    wardSelect.innerHTML = '<option value="">-- Chọn Phường/Xã --</option>';
    wardSelect.disabled = true;

    if (provinceId) {
        districtSelect.disabled = false;
        fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/district', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'token': GHN_TOKEN
            },
            body: JSON.stringify({"province_id": parseInt(provinceId)})
        })
            .then(response => response.json())
            .then(data => {
                data.data.forEach(item => {
                    let option = document.createElement('option');
                    option.value = item.DistrictID;
                    option.text = item.DistrictName;
                    districtSelect.appendChild(option);
                });

                // Phục hồi Huyện
                if(isRestoring) {
                    let savedDist = sessionStorage.getItem('savedDist');
                    if(savedDist) {
                        districtSelect.value = savedDist;
                        loadWard(savedDist, true);
                    }
                }
            });
    } else {
        districtSelect.disabled = true;
    }
    updateFullAddress();
}

// Sự kiện đổi Huyện
document.getElementById('district').addEventListener('change', function () {
    sessionStorage.setItem('savedDist', this.value);
    sessionStorage.removeItem('savedWard');
    loadWard(this.value, false);
});

// Hàm Load Phường/Xã
function loadWard(districtId, isRestoring) {
    let wardSelect = document.getElementById('ward');
    wardSelect.innerHTML = '<option value="">-- Chọn Phường/Xã --</option>';

    if (districtId) {
        wardSelect.disabled = false;
        fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/master-data/ward?district_id=' + districtId, {
            headers: {'token': GHN_TOKEN}
        })
            .then(response => response.json())
            .then(data => {
                data.data.forEach(item => {
                    let option = document.createElement('option');
                    option.value = item.WardCode;
                    option.text = item.WardName;
                    wardSelect.appendChild(option);
                });

                // Phục hồi Xã
                if(isRestoring) {
                    let savedWard = sessionStorage.getItem('savedWard');
                    if(savedWard) {
                        wardSelect.value = savedWard;
                        updateFullAddress();
                    }
                }
            });
    } else {
        wardSelect.disabled = true;
    }
    updateFullAddress();
}

// 3. SỰ KIỆN QUAN TRỌNG NHẤT: TÍNH PHÍ SHIP KHI NGƯỜI DÙNG BẤM CHỌN XÃ
document.getElementById('ward').addEventListener('change', function() {
    sessionStorage.setItem('savedWard', this.value);
    updateFullAddress();

    let districtId = document.getElementById('district').value;
    let wardCode = this.value;

    if (districtId && wardCode) {
        let payload = {
            "service_type_id": 2, // Giao Hàng Chuẩn
            "to_district_id": parseInt(districtId),
            "to_ward_code": wardCode,
            "weight": 1000 // 1kg
        };

        fetch('https://dev-online-gateway.ghn.vn/shiip/public-api/v2/shipping-order/fee', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'token': GHN_TOKEN,
                'shop_id': GHN_SHOP_ID
            },
            body: JSON.stringify(payload)
        })
            .then(response => response.json())
            .then(result => {
                if(result.code === 200) {
                    let exactFee = result.data.total;
                    let form = document.querySelector(".checkout-form");

                    // Thêm input ẩn tiền ship
                    let hiddenFee = document.createElement("input");
                    hiddenFee.type = "hidden";
                    hiddenFee.name = "ghnShippingFee";
                    hiddenFee.value = exactFee;
                    form.appendChild(hiddenFee);

                    // Thêm hành động updateShipping
                    let hiddenAction = document.createElement("input");
                    hiddenAction.type = "hidden";
                    hiddenAction.name = "action";
                    hiddenAction.value = "updateShipping";
                    form.appendChild(hiddenAction);

                    // Gửi về Servlet để tính lại tiền
                    form.submit();
                } else {
                    alert("Khu vực này hiện không hỗ trợ giao hàng!");
                }
            })
            .catch(error => console.error('Lỗi tính phí:', error));
    }
});
// Gộp Tên Tỉnh, Huyện, Xã lại thành 1 chuỗi để Servlet dễ đọc
function updateFullAddress() {
    let p = document.getElementById('province');
    let d = document.getElementById('district');
    let w = document.getElementById('ward');

    // LƯU MÃ ID GỬI VỀ BACKEND
    document.getElementById('hiddenDistrictId').value = d.value;
    document.getElementById('hiddenWardCode').value = w.value;

    if (p.value && d.value && w.value) {
        let pName = p.options[p.selectedIndex].text;
        let dName = d.options[d.selectedIndex].text;
        let wName = w.options[w.selectedIndex].text;
        document.getElementById('fullAddress').value = wName + ", " + dName + ", " + pName;
    }
}
