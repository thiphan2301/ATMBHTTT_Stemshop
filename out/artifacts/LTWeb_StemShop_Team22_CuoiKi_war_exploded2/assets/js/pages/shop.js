// -------------------------kiểu xem (view type) ----------------------
const type1 = document.getElementById('head__type1');
const type2 = document.getElementById('head__type2');
const type3 = document.getElementById('head__type3');

const bodyCard = document.querySelector('.list-product__body__card');

const classType1 = 'list-product__body__card';
const classType2 = 'list-product__body__card__type2';
const classType3 = 'list-product__body__card__type3';

type1.addEventListener('click', () => {
    type1.style.backgroundColor = '#FF6C80';
    type2.style.backgroundColor = '#E9E8E7';
    type3.style.backgroundColor = '#E9E8E7';

    if (bodyCard.className === classType2) {
        bodyCard.classList.replace(classType2, classType1)
    } else if (bodyCard.className === classType3) {
        bodyCard.classList.replace(classType3, classType1)
    }
});
type2.addEventListener('click', () => {
    type2.style.backgroundColor = '#FF6C80';
    type1.style.backgroundColor = '#E9E8E7';
    type3.style.backgroundColor = '#E9E8E7';

    if (bodyCard.className === classType1) {
        bodyCard.classList.replace(classType1, classType2)
    } else if (bodyCard.className === classType3) {
        bodyCard.classList.replace(classType3, classType2)
    }
});
type3.addEventListener('click', () => {
    type3.style.backgroundColor = '#FF6C80';
    type1.style.backgroundColor = '#E9E8E7';
    type2.style.backgroundColor = '#E9E8E7';

    if (bodyCard.className === classType1) {
        bodyCard.classList.replace(classType1, classType3)
    } else if (bodyCard.className === classType2) {
        bodyCard.classList.replace(classType2, classType3)
    }
});


// ------------------chuyển trang productdetail----------------------
document.addEventListener("DOMContentLoaded", () => {
    // 1. TÌM TẤT CẢ CÁC THẺ SẢN PHẨM
    const productCards = document.querySelectorAll('.list-product__body__card__container');

    // 2. DUYỆT QUA TỪNG THẺ VÀ GẮN SỰ KIỆN CLICK
    productCards.forEach(card => {
        card.addEventListener('click', function () {
            // Lấy đường dẫn từ thuộc tính data-url mà bạn đã viết trong HTML
            const url = this.getAttribute('data-url');

            // Nếu có đường dẫn thì chuyển trang
            if (url) {
                window.location.href = url;
            } else {
                // Thông báo nếu sản phẩm chưa có trang demo (tùy chọn)
                //alert("Sản phẩm này đang cập nhật nội dung!");
            }
        });
    });
});

// ===================== DATA =====================
const productCards = document.querySelectorAll('.list-product__body__card__container');
const categoryCheckboxes = document.querySelectorAll('.checkbox-category');
const priceCheckboxes = document.querySelectorAll('.checkbox-price');
const searchInput = document.getElementById('search-product');

// ===================== EVENTS =====================
categoryCheckboxes.forEach(cb => cb.addEventListener('change', applyFilters));
priceCheckboxes.forEach(cb => cb.addEventListener('change', applyFilters));

searchInput.addEventListener('input', applyFilters);

// ===================== CORE FILTER =====================
function applyFilters() {
    const selectedCategories = Array.from(categoryCheckboxes)
        .filter(cb => cb.checked)
        .map(cb => cb.value);

    const selectedPrices = Array.from(priceCheckboxes)
        .filter(cb => cb.checked)
        .map(cb => cb.value);

    const keyword = searchInput.value.toLowerCase();

    productCards.forEach(card => {
        const categoryId = card.dataset.category;
        const price = parseInt(card.dataset.price);
        const name = card.dataset.name; // bạn đã có data-name

        let matchCategory =
            selectedCategories.length === 0 ||
            selectedCategories.includes(categoryId);

        let matchPrice =
            selectedPrices.length === 0 ||
            selectedPrices.some(range =>
                (range === "duoi200" && price < 200000) ||
                (range === "200-1tr" && price >= 200000 && price <= 1000000) ||
                (range === "1tr-2tr" && price > 1000000 && price <= 2000000) ||
                (range === "2tr-4tr" && price > 2000000 && price <= 4000000) ||
                (range === "tren4tr" && price > 4000000)
            );

        let matchSearch =
            keyword === "" || name.includes(keyword);

        card.style.display =
            matchCategory && matchPrice && matchSearch
                ? "block"
                : "none";
    });
}

// --------------SẮP XẾP SĂN PHẨM-----------------------
const sortSelect = document.getElementById("sort-select");
const productContainer = document.querySelector(".list-product__body__card");

if (sortSelect) {
    sortSelect.addEventListener("change", () => {
        const type = sortSelect.value;

        // Lấy danh sách sản phẩm hiện tại
        const items = Array.from(
            productContainer.querySelectorAll(".list-product__body__card__container")
        );

        let sortedItems = [...items];

        switch (type) {
            case "az":
                sortedItems.sort((a, b) =>
                    a.dataset.name.localeCompare(b.dataset.name)
                );
                break;

            case "za":
                sortedItems.sort((a, b) =>
                    b.dataset.name.localeCompare(a.dataset.name)
                );
                break;

            case "price-asc":
                sortedItems.sort((a, b) =>
                    parseInt(a.dataset.price) - parseInt(b.dataset.price)
                );
                break;

            case "price-desc":
                sortedItems.sort((a, b) =>
                    parseInt(b.dataset.price) - parseInt(a.dataset.price)
                );
                break;

            default:
                // Mặc định => reload trang để lấy thứ tự ban đầu từ server (DB)
                window.location.reload();
                return;
        }

        // Xóa và append lại
        productContainer.innerHTML = "";
        sortedItems.forEach(item => productContainer.appendChild(item));
    });
}

// -------------back to top-----------------
const backToTopBtn = document.querySelector('.back-to-top');

//lắng nghe sựu kiện cuộn chuột và gọi function để xử lý sự kiện đó
window.onscroll = function () {
    scrollFunction();
}

function scrollFunction() {
    if(document.documentElement.scrollTop > 300){
        backToTopBtn.style.display = "block";
    } else {
        backToTopBtn.style.display = "none";
    }
}

backToTopBtn.addEventListener('click', () =>{
    window.scrollTo({
        top: 0,
        behavior: "smooth"
    });
});