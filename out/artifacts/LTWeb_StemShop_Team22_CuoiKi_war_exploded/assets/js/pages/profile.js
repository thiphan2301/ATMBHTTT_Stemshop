 
    document.addEventListener("DOMContentLoaded", () => {
    // Lấy thông tin user từ LocalStorage (sau khi đăng nhập)
    const userInfo = JSON.parse(localStorage.getItem("userInfo"));
    // xử lý ẩn hiện 2 trạng thái chưa và đã đăng nhập
    const headerLogin = document.querySelector(".header__user-login");
    const headerLogged = document.querySelector(".header__user-logged");

    if (userInfo) {
        headerLogin && (headerLogin.style.display = "none");
        headerLogged && (headerLogged.style.display = "flex");
        // hiển thị tên user
        const nameText = document.querySelector(".user-short-name");
        if (nameText) nameText.textContent = userInfo.name;
    } else {
        headerLogin && (headerLogin.style.display = "flex");
        headerLogged && (headerLogged.style.display = "none");
    }
});

// Xử lý Logout
  const logoutBtn = document.getElementById("logoutBtn");
  if (logoutBtn) {
      logoutBtn.addEventListener("click", (e) => {
        e.preventDefault();
        localStorage.removeItem("userInfo");
        window.location.href = "/src/pages/user/sign-in.html";
      });
}


    document.addEventListener("DOMContentLoaded", () => {
    const user = JSON.parse(localStorage.getItem("userInfo"));

    // Nếu chưa login → đẩy về trang đăng nhập
    if (!user) {
        window.location.href = "/src/pages/user/sign-in.html";
    }
});
