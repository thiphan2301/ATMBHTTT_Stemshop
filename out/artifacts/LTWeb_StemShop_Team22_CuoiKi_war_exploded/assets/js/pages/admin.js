document.addEventListener("DOMContentLoaded", () => {

    // -------------------------
    // MENU SWITCH PAGE
    // -------------------------
    const menuItems = document.querySelectorAll(".admin-menu__item");
    const pages = document.querySelectorAll(".admin-page");
    const pageTitle = document.getElementById("pageTitle");

    // menuItems.forEach(item => {
    //     item.addEventListener("click", () => {
    //         menuItems.forEach(i => i.classList.remove("active"));
    //         item.classList.add("active");
    //
    //         const pageName = item.getAttribute("data-page");
    //         pages.forEach(p => p.classList.remove("admin-page--active"));
    //         document.getElementById(pageName).classList.add("admin-page--active");
    //
    //         pageTitle.innerText = item.innerText.trim();
    //     });
    // });
    menuItems.forEach(item => {
        item.addEventListener('click', function() {
            // Bước 1: Duyệt qua tất cả, xóa class active hiện có
            menuItems.forEach(i => i.classList.remove('active'));

            // Bước 2: Thêm class active vào chính item vừa được click (this)
            this.classList.add('active');
        });
    });

    // -------------------------
    // AVATAR DROPDOWN
    // -------------------------
    const avatar = document.querySelector(".admin-avatar");
    const dropdown = document.querySelector(".admin-dropdown");

    avatar.addEventListener("click", () => {
        dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
    });

    document.addEventListener("click", (e) => {
        if (!avatar.contains(e.target) && !dropdown.contains(e.target)) {
            dropdown.style.display = "none";
        }
    });

    // -------------------------
    // POPUP BÀI VIẾT
    // -------------------------
    const postForm = document.getElementById("postForm");
    const productForm = document.getElementById("productForm");
    const eventForm = document.getElementById("eventForm");
    const materialForm = document.getElementById("materialForm");

    document.getElementById("openPostForm").onclick = () => postForm.style.display = "flex";
    document.getElementById("closePostForm").onclick = () => postForm.style.display = "none";

    document.getElementById("openAddProduct")?.addEventListener('click', () => productForm.style.display = "flex");
    document.getElementById("closeProductForm")?.addEventListener('click', () => productForm.style.display = "none");

    document.getElementById("openAddEvent")?.addEventListener('click', () => eventForm.style.display = "flex");
    document.getElementById("closeEventForm")?.addEventListener('click', () => eventForm.style.display = "none");

    document.getElementById("openAddMaterial")?.addEventListener('click', () => materialForm.style.display = "flex");
    document.getElementById("closeMaterialForm")?.addEventListener('click', () => materialForm.style.display = "none");

    // -------------------------
    // TAG INPUT
    // -------------------------
    let tags = [];
    const tagInput = document.getElementById("tagInput");
    const tagList = document.getElementById("tagList");

    tagInput.addEventListener("keydown", function (e) {
        if (e.key === "Enter" && this.value.trim() !== "") {
            e.preventDefault();
            const text = this.value.trim();
            if (!tags.includes(text)) tags.push(text);
            renderTags();
            this.value = "";
        }
    });

    window.removeTag = function (text) {
        tags = tags.filter(t => t !== text);
        renderTags();
    };

    function renderTags() {
        tagList.innerHTML = tags
            .map(t => `<span class="chip">${t} <i onclick="removeTag('${t}')">x</i></span>`)
            .join("");
    }

    // -------------------------
    // IMAGE PREVIEW
    // -------------------------
    document.getElementById("postImage").addEventListener("change", function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = e => {
                const img = document.getElementById("previewImage");
                img.src = e.target.result;
                img.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    });

    document.getElementById("productImage")?.addEventListener("change", function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = e => {
                const img = document.getElementById("previewProductImage");
                img.src = e.target.result;
                img.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    });

    document.getElementById("eventImage")?.addEventListener("change", function () {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = e => {
                const img = document.getElementById("previewEventImage");
                img.src = e.target.result;
                img.style.display = "block";
            };
            reader.readAsDataURL(file);
        }
    });

    // -------------------------
    // SAVE POST (demo)
    // -------------------------
    document.getElementById("savePost").onclick = function () {
        const title = document.getElementById("postTitle").value;
        const date = document.getElementById("postDate").value;

        if (!title || !date) {
            alert('Vui lòng nhập đầy đủ tiêu đề và ngày!');
            return;
        }

        const blogImages = [
            'STEM trong đời sống.jpg',
            'Hướng dẫn chọn kit STEM phù hợp.jpg',
            'Lợi ích học STEM sớm cho trẻ em.jpg'
        ];
        const randomImage = blogImages[Math.floor(Math.random() * blogImages.length)];
        
        const tbody = document.getElementById("postsTable");
        const newId = tbody.rows.length + 1;

        const row = `
            <tr>
                <td>${newId}</td>
                <td><img src="../../assets/images/blog/${randomImage}" alt="Blog"></td>
                <td>${title}</td>
                <td>${tags.map(t => `<span class='tag'>${t}</span>`).join(" ") || '<span class="tag">Chung</span>'}</td>
                <td>${date}</td>
                <td>
                    <button class="btn-small edit">Sửa</button>
                    <button class="btn-small delete">Xoá</button>
                </td>
            </tr>
        `;

        tbody.insertAdjacentHTML('beforeend', row);
        
        postForm.style.display = "none";
        tags = [];
        renderTags();
        document.getElementById("postTitle").value = "";
        document.getElementById("postDate").value = "";
        document.getElementById("postImage").value = "";
        document.getElementById("previewImage").style.display = "none";
        alert("Đã thêm bài viết mới!");
    };

    // -------------------------
    // SAVE PRODUCT
    // -------------------------
    document.getElementById("saveProduct")?.addEventListener('click', function() {
        const name = document.getElementById("productName").value;
        const category = document.getElementById("productCategory").value;
        const price = document.getElementById("productPrice").value;

        if (!name || !category || !price) {
            alert('Vui lòng nhập đầy đủ thông tin!');
            return;
        }

        const productImages = [
            'Robot lập trình Scratch.png',
            'Kit STEM Arduino cơ bản.png',
            'Bộ lắp ráp cơ khí cho trẻ em.png'
        ];
        const randomImage = productImages[Math.floor(Math.random() * productImages.length)];

        const tbody = document.getElementById("productsTable");
        const newId = tbody.rows.length + 1;

        const row = `
            <tr>
                <td>${newId}</td>
                <td><img src="../../assets/images/products/${randomImage}" alt="${name}"></td>
                <td>${name}</td>
                <td>${category}</td>
                <td>${parseInt(price).toLocaleString('vi-VN')}đ</td>
                <td>
                    <button class="btn-small edit">Sửa</button>
                    <button class="btn-small delete">Xoá</button>
                </td>
            </tr>
        `;

        tbody.insertAdjacentHTML('beforeend', row);

        productForm.style.display = "none";
        document.getElementById("productName").value = "";
        document.getElementById("productCategory").value = "";
        document.getElementById("productPrice").value = "";
        document.getElementById("productImage").value = "";
        document.getElementById("previewProductImage").style.display = "none";
        alert('Đã thêm sản phẩm mới!');
    });

    // -------------------------
    // SAVE EVENT
    // -------------------------
    document.getElementById("saveEvent")?.addEventListener('click', function() {
        const name = document.getElementById("eventName").value;
        const date = document.getElementById("eventDate").value;
        const location = document.getElementById("eventLocation").value;

        if (!name || !date || !location) {
            alert('Vui lòng nhập đầy đủ thông tin!');
            return;
        }

        const eventImages = ['robot-mini.jpg', 'science-fun.jpg', 'electric.jpg', 'engineer.jpg', 'math.jpg', 'space.jpg'];
        const randomImage = eventImages[Math.floor(Math.random() * eventImages.length)];

        const tbody = document.getElementById("eventsTable");
        const newId = tbody.rows.length + 1;

        const row = `
            <tr>
                <td>${newId}</td>
                <td><img src="../../assets/images/workshop/${randomImage}" alt="${name}"></td>
                <td>${name}</td>
                <td>${date}</td>
                <td>${location}</td>
                <td>
                    <button class="btn-small edit">Sửa</button>
                    <button class="btn-small delete">Xoá</button>
                </td>
            </tr>
        `;

        tbody.insertAdjacentHTML('beforeend', row);

        eventForm.style.display = "none";
        document.getElementById("eventName").value = "";
        document.getElementById("eventDate").value = "";
        document.getElementById("eventLocation").value = "";
        document.getElementById("eventImage").value = "";
        document.getElementById("previewEventImage").style.display = "none";
        alert('Đã thêm sự kiện mới!');
    });

    // -------------------------
    // SEARCH FILTER
    // -------------------------
    function addSearchFilter(inputId, tableId) {
        const input = document.getElementById(inputId);
        const table = document.getElementById(tableId);

        input.addEventListener('keyup', function () {
            const filter = this.value.toLowerCase();
            Array.from(table.rows).forEach(row => {
                const text = row.textContent.toLowerCase();
                row.style.display = text.includes(filter) ? '' : 'none';
            });
        });
    }

    addSearchFilter('searchProduct', 'productsTable');
    addSearchFilter('searchOrder', 'ordersTable');
    addSearchFilter('searchUser', 'usersTable');
    addSearchFilter('searchPost', 'postsTable');

    // -------------------------
    // XÓA HÀNG (DELETE ROW)
    // -------------------------
    document.addEventListener('click', function(e) {
        if (e.target.classList.contains('delete')) {
            if (confirm('Bạn có chắc muốn xóa mục này?')) {
                const row = e.target.closest('tr');
                row.remove();
                alert('Đã xóa!');
            }
        }
    });
});
