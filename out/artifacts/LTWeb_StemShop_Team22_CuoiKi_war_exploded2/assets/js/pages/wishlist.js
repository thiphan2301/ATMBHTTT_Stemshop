
document.addEventListener("DOMContentLoaded", () => {
    //lấy ra các sp trong danh sách yêu thích
    const listWishList = document.querySelectorAll('.wishlist-container__card');
    
    // ------------chức năng remove sp ra khỏi danh sách yêu thích---------------
    //duyệt qua từng sp
    listWishList.forEach(row => {
        const remove = row.querySelector('.trash');
        if(remove) {
            remove.addEventListener('click', () =>{
                row.remove();
            })
        }
        // ----------------chức năng  chuyển sang trang giỏ hàng---------------
        //btnAddtoCart
        const btnAddToCart = row.querySelector('.btn-addToCart');
        if(btnAddToCart){
            btnAddToCart.addEventListener('click', () =>{
                window.location.href = "cart.html";
            })
        }
    } )
})

function toggleWishlist(productId, btn) {
    const icon = btn.querySelector("i");

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

// load số wishlist khi mở trang
document.addEventListener("DOMContentLoaded", () => {
    updateWishlistCount();
});