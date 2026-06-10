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

// // -------------back to top-----------------
// const backToTopBtn = document.querySelector('.back-to-top');
//
// //lắng nghe sựu kiện cuộn chuột và gọi function để xử lý sự kiện đó
// window.onscroll = function () {
//     scrollFunction();
// }
//
// function scrollFunction() {
//     if(document.documentElement.scrollTop > 300){
//         backToTopBtn.style.display = "block";
//     } else {
//         backToTopBtn.style.display = "none";
//     }
// }
//
// backToTopBtn.addEventListener('click', () =>{
//     window.scrollTo({
//         top: 0,
//         behavior: "smooth"
//     });
// });

// mua ngay
function buyNow(productId){
    window.location.href = "/BuyNowServlet?productId=" + productId;
}