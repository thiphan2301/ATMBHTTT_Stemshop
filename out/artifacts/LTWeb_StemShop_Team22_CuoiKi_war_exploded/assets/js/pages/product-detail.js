//import { listProduct } from './data.js';

// hàm chuyển hướng sang trang giỏ hàng khi click vào button "Thêm vào giỏ hàng"
// 1. Tìm tất cả các nút có class '.add-to-cart'
const addToCartButtons = document.querySelectorAll('.add-to-cart');

// 2. Duyệt qua từng nút và gắn sự kiện
addToCartButtons.forEach(button => {
    button.addEventListener('click', (event) => {
        // Ngăn sự kiện nổi bọt nếu nút này nằm trong thẻ sản phẩm có click chuyển trang
        event.stopPropagation();

        // Chuyển hướng đến trang giỏ hàng
        window.location.href = "cart.html";
    });
});


