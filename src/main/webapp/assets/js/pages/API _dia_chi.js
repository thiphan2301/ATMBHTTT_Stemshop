
    const host = "https://provinces.open-api.vn/api/";

    // Gọi API lấy danh sách Tỉnh/Thành
    fetch(host + "?depth=1")
    .then(response => response.json())
    .then(data => {
    let html = '<option value="">Chọn Tỉnh/Thành phố</option>';
    data.forEach(element => {
    html += `<option data-id="${element.code}" value="${element.name}">${element.name}</option>`;
});
    document.getElementById("province").innerHTML = html;
});

    // Khi chọn Tỉnh/Thành -> Load Quận/Huyện
    document.getElementById("province").addEventListener("change", function() {
    const provinceCode = this.options[this.selectedIndex].getAttribute('data-id');
    const districtSelect = document.getElementById("district");
    const wardSelect = document.getElementById("ward");

    wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
    wardSelect.disabled = true;

    if (!provinceCode) {
    districtSelect.innerHTML = '<option value="">Chọn Quận/Huyện</option>';
    districtSelect.disabled = true;
    return;
}

    fetch(host + "p/" + provinceCode + "?depth=2")
    .then(response => response.json())
    .then(data => {
    let html = '<option value="">Chọn Quận/Huyện</option>';
    data.districts.forEach(element => {
    html += `<option data-id="${element.code}" value="${element.name}">${element.name}</option>`;
});
    districtSelect.innerHTML = html;
    districtSelect.disabled = false;
});
    updateFullAddress();
});

    // Khi chọn Quận/Huyện -> Load Phường/Xã
    document.getElementById("district").addEventListener("change", function() {
    const districtCode = this.options[this.selectedIndex].getAttribute('data-id');
    const wardSelect = document.getElementById("ward");

    if (!districtCode) {
    wardSelect.innerHTML = '<option value="">Chọn Phường/Xã</option>';
    wardSelect.disabled = true;
    return;
}

    fetch(host + "d/" + districtCode + "?depth=2")
    .then(response => response.json())
    .then(data => {
    let html = '<option value="">Chọn Phường/Xã</option>';
    data.wards.forEach(element => {
    html += `<option data-id="${element.code}" value="${element.name}">${element.name}</option>`;
});
    wardSelect.innerHTML = html;
    wardSelect.disabled = false;
});
    updateFullAddress();
});

    // Khi chọn Phường/Xã hoặc nhập số nhà -> Gộp lại thành địa chỉ hoàn chỉnh
    document.getElementById("ward").addEventListener("change", updateFullAddress);
    document.getElementById("street").addEventListener("input", updateFullAddress);

    function updateFullAddress() {
    const province = document.getElementById("province").value;
    const district = document.getElementById("district").value;
    const ward = document.getElementById("ward").value;
    const street = document.getElementById("street").value;

    let finalAddress = [];
    if (street) finalAddress.push(street);
    if (ward) finalAddress.push(ward);
    if (district) finalAddress.push(district);
    if (province) finalAddress.push(province);

    // Nạp vào input ẩn để gửi về Server lưu vào Database
    document.getElementById("fullAddress").value = finalAddress.join(", ");
}