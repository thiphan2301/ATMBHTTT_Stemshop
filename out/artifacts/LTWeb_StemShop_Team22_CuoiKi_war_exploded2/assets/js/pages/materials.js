//Tương tác danh mcu5
const categoryLinks = document.querySelectorAll(".sidebar__list li a");
const items = document.querySelectorAll(".material__item");

categoryLinks.forEach(link => {
    link.addEventListener("click", function(e) {
        e.preventDefault();

        // active UI
        categoryLinks.forEach(l => l.classList.remove("active"));
        this.classList.add("active");

        const category = this.textContent.trim();

        items.forEach(item => {
            // Nếu chọn TẤT CẢ
            if (category === "Tất cả") {
                item.style.display = "block";
                return;
            }

            // Các danh mục khớp
            const itemCat = item.dataset.category;

            if (
                (category === "Arduino" && itemCat === "arduino") ||
                (category === "Module" && itemCat === "module") ||
                (category === "Rio" && itemCat === "rio") ||
                (category === "XBot" && itemCat === "xbot") ||
                (category === "YoLo:Bit" && itemCat === "yolobit")
            ) {
                item.style.display = "block";
            } else {
                item.style.display = "none";
            }
        });
    });
});

//Tương tác lượt view
// DATA VIEW BAN ĐẦU (GIÁ TRỊ THẬT)

const defaultViews = {
    p1: 1200,
    p2: 980,
    p3: 2100,
    p4: 650,
    p5: 1800,
    p6: 700,
    p7: 1400,
    p8: 900,
    p9: 2800
};


//  LẤY VIEW TỪ LOCALSTORAGE (NẾU CÓ)

let viewData = JSON.parse(localStorage.getItem("materialViews")) || defaultViews;


//  HIỂN THỊ VIEW LÊN LIST CHÍNH

document.querySelectorAll(".material__item").forEach(item => {
    const id = item.dataset.id;
    const viewSpan = item.querySelector(".views");

    // Nếu chưa có id trong viewData → gán view mặc định
    if (!viewData[id]) {
        viewData[id] = defaultViews[id] || 0;
    }

    // Hiển thị view
    viewSpan.textContent = viewData[id];

    // Khi click → tăng view
    item.addEventListener("click", () => {
        viewData[id]++;

        // Lưu lại
        localStorage.setItem("materialViews", JSON.stringify(viewData));
    });
});


//  RENDER WORKSHOP HOT GẦN ĐÂY

function renderHotWorkshops() {
    const hotItems = document.querySelectorAll(".recent");

    if (!hotItems.length) return;

    // Sort theo view giảm dần
    const sorted = Object.entries(viewData)
        .sort((a, b) => b[1] - a[1]) 
        .slice(0, hotItems.length);

    sorted.forEach((item, index) => {
        const id = item[0];
        const view = item[1];

        const mainItem = document.querySelector(`.material__item[data-id="${id}"]`);
        if (!mainItem) return;

        const imgSrc = mainItem.querySelector("img").src;
        const title = mainItem.querySelector("h3").textContent;

        const hot = hotItems[index];

        hot.querySelector("img").src = imgSrc;
        hot.querySelector(".recent__info p").textContent = title;
        hot.querySelector(".recent__info span").innerHTML =
            `<i class="fa-regular fa-eye"></i> ${view}`;
    });
}

renderHotWorkshops();



//LƯU VIEW LẠI KHI RENDER XONG (CHỐNG RESET)

localStorage.setItem("materialViews", JSON.stringify(viewData));

