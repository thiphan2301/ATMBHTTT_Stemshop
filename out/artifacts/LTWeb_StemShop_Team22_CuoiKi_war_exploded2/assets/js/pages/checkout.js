document.addEventListener('DOMContentLoaded', () => {
    // ------------chuyển hướng khi đặt hàng thành công------------------
    const btnOder = document.getElementById('btnOder');
    btnOder.addEventListener('click', () => {
        window.location.href = "shop.html"
        alert("Bạn đã đặt hàng thành công")
    })
})