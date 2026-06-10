// ============================
// LẤY ID BÀI HIỆN TẠI
// ============================
const urlParams = new URLSearchParams(window.location.search);
const currentMaterialId = urlParams.get("id") || "p1";


// ============================
// DATA MATERIAL
// ============================
const materialData = [
    { id: "p1", title: "Chế Độ Deep Sleep trên ESP32", category: "arduino", img: BASE_URL + "/assets/images/workshop/materials/p1.png" },
    { id: "p2", title: "Hướng Dẫn sử dụng nhiều màn hình I2C", category: "module", img: "https://ohstem.vn/wp-content/uploads/2024/02/huong-dan-lap-trinh-nhieu-man-hinh-i2c-voi-yolo-uno-ohstem-avt.png" },
    { id: "p3", title: "Làm robot tránh vật cản", category: "xbot", img: "https://ohstem.vn/wp-content/uploads/2021/09/Robot-ne-vat-can.jpg" },
    { id: "p4", title: "ESP32 Giao Tiếp I2C", category: "arduino", img: "https://ohstem.vn/wp-content/uploads/2021/02/B46.png" },
    { id: "p5", title: "Lập trình LED đổi màu", category: "xbot", img: "https://ohstem.vn/wp-content/uploads/2021/09/lap-trinh-LED-doi-mau.jpg" },
    { id: "p6", title: "Đàn piano điện", category: "yolobit", img: "https://ohstem.vn/wp-content/uploads/2023/10/piano-dien-1.jpg" },
    { id: "p7", title: "Lập trình Encoder với Yolo:Bit", category: "module", img: "https://ohstem.vn/wp-content/uploads/2022/11/lap-trinh-encoder-de-dieu-khien-quat.jpg" },
    { id: "p8", title: "Bạn sống ở đâu?", category: "rio", img: "https://ohstem.vn/wp-content/uploads/2024/10/ban-song-o-dau-5.png" },
    { id: "p9", title: "Rio đi tìm thú lạc", category: "rio", img: "https://ohstem.vn/wp-content/uploads/2024/10/Rio-di-tim-thu-lac-6.png" }
];


// ============================
// TÌM BÀI HIỆN TẠI (CHỐNG NULL)
// ============================
const currentMaterial = materialData.find(m => m.id === currentMaterialId);

if (!currentMaterial) {
    console.error("Không tìm thấy bài hiện tại:", currentMaterialId);
}


// ============================
// RENDER BÀI LIÊN QUAN
// ============================
const relatedList = document.getElementById("relatedList");

if (relatedList && currentMaterial) {

    const relatedItems = materialData
        .filter(m => m.id !== currentMaterialId)
        .slice(0, 3);

    relatedList.innerHTML = relatedItems.map(item => `
        <a class="related-item" href="${BASE_URL}/materials-detail?id=${item.id}">
            <img src="${item.img}">
            <div>
                <h4>${item.title}</h4>
                <span>
                    <i class="fa-regular fa-eye"></i> ${getViews(item.id)}
                </span>
            </div>
        </a>
    `).join("");
}


// ============================
// LẤY VIEW TỪ LOCALSTORAGE
// ============================
function getViews(id) {
    const savedViews = JSON.parse(localStorage.getItem("materialViews")) || {};
    return savedViews[id] || 0;
}
