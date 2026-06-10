document.addEventListener("DOMContentLoaded", () => {

    // 1. HÀM HỖ TRỢ: ĐỊNH DẠNG TIỀN (Ví dụ: 1779000 -> 1.779.000 Đ)
    function formatMoney(amount) {
        return amount.toLocaleString('vi-VN') + ' Đ';
    }

    //hàm cập nhật tổng tiền
    function updateGrandTotal() {
        let total = 0;
        
        // lấy tất cả các sp trong giỏ hàng
        const allProductRows = document.querySelectorAll('.cart-containers-');
        
        // duyệt qua từng dòng
        allProductRows.forEach(row => {
            // Lấy phần tử giá tiền của dòng đó
            const priceElem = row.querySelector('.product-line-price');
            // Lấy giá trị text (VD: "1.779.000 Đ")
            const priceText = priceElem.textContent;
            // Chuyển text thành số (bỏ dấu '.', chữ 'Đ' và khoảng trắng)
            const numericPrice = parseInt(priceText.replace(/\./g, '').replace('Đ', '').trim());
            
            // Cộng dồn vào tổng
            total += numericPrice;
        });

        // Lấy thẻ span chứa tổng tiền
        const totalElement = document.getElementById('total-price');
        
        // Hiển thị tổng tiền mới đã được định dạng
        if (totalElement) {
            totalElement.textContent = formatMoney(total);
        }
    }

    // 2. lấy ra các sp trong giỏ hàng
    const productRows = document.querySelectorAll('.cart-containers-');

    // 3. duyệt qua từng sp và gán event 'click' cho 2 icon tăng, giảm 
    productRows.forEach(row => {
        // lấy các element 
        const decreaseBtn = row.querySelector('.decrease-btn');
        const increaseBtn = row.querySelector('.increase-btn');
        const quantityElem = row.querySelector('.quantity-value');
        const priceElem = row.querySelector('.product-line-price');
        const deleteBtn = row.querySelector('.delete-btn');
        const unitPrice = parseInt(priceElem.getAttribute('data-unit-price'));

        // --- XỬ LÝ NÚT GIẢM (-) ---
        if (decreaseBtn) {
            decreaseBtn.addEventListener('click', () => {
                let currentQty = parseInt(quantityElem.textContent);
                if (currentQty > 1) {
                    currentQty--;
                    quantityElem.textContent = currentQty;
                    priceElem.textContent = formatMoney(currentQty * unitPrice);
                    
                    // GỌI HÀM CẬP NHẬT TỔNG TIỀN
                    updateGrandTotal();
                }
            });
        }

        // --- XỬ LÝ NÚT TĂNG (+) ---
        if (increaseBtn) {
            increaseBtn.addEventListener('click', () => {
                let currentQty = parseInt(quantityElem.textContent);
                currentQty++;
                quantityElem.textContent = currentQty;
                priceElem.textContent = formatMoney(currentQty * unitPrice);

                // 
                updateGrandTotal();
            });
        }

        // --- XỬ LÝ NÚT XÓA (Thùng rác) ---
        if (deleteBtn) {
            deleteBtn.addEventListener('click', () => {
                row.remove();
                
                //
                updateGrandTotal();
            });
        }
    });
    
    // CHẠY 1 LẦN KHI MỚI TẢI TRANG
    // Để đảm bảo tổng tiền được tính đúng ngay từ đầu (phòng trường hợp HTML bị sai)
    updateGrandTotal();

});

function addToCart(productId) {
    fetch(`${contextPath}/add-to-cart?id=` + productId)
        .then(() => updateCartCount());
}
function updateCartCount() {
    fetch(`${contextPath}/cart-count`)
        .then(res => res.json())
        .then(data => {
            const badge = document.getElementById("cart-count");
            if (badge) {
                badge.innerText = data.count;
            }
        });
}
function updateQuantity(productId, action) {
    fetch(`${contextPath}/update-cart?id=${productId}&action=${action}`)
        .then(() => {
            updateCartCount();   // cập nhật số trên icon giỏ hàng
            location.reload();   // reload lại cart.jsp (nếu muốn)
        });
}
function toggleWishlist(productId, icon) {
    fetch(`${contextPath}/toggle-wishlist?id=` + productId)
        .then(res => {
            if (res.status === 401) {
                window.location.href = contextPath + "/view/user/sign-in.jsp";
                return;
            }
            updateWishlistCount();
            icon.classList.toggle("active-heart");
        });
}

function updateWishlistCount() {
    fetch(`${contextPath}/wishlist-count`)
        .then(res => res.json())
        .then(data => {
            const badge = document.getElementById("wishlist-count");
            if (badge) {
                badge.innerText = data.count;
            }
        });
}
function removeFromWishlist(productId) {
    fetch(`${contextPath}/toggle-wishlist?id=` + productId)
        .then(res => {
            if (!res.ok) return;

            // XÓA LUÔN DÒNG SẢN PHẨM
            const row = document.getElementById("wishlist-item-" + productId);
            if (row) row.remove();

            // CẬP NHẬT SỐ LƯỢNG ICON TIM
            updateWishlistCount();

            // Nếu không còn sản phẩm nào → hiện text
            const remain = document.querySelectorAll(".wishlist-item");
            if (remain.length === 0) {
                location.reload(); // đơn giản nhất
            }
        });
}