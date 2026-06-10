// === Hàm tải và chèn file HTML (header/footer) ===
async function loadComponent(id, filePath) {
  const container = document.getElementById(id);
  if (container) {
    try {
      const response = await fetch(filePath);
      if (!response.ok) throw new Error("Không tìm thấy file: " + filePath);
      const html = await response.text();
      container.innerHTML = html;

      // Sau khi header hoặc footer load xong
      if (id === "header") {
        highlightActiveLink(); // đánh dấu link active
        scrollToHash();        // cuộn đến section có id nếu có hash (#)
      }
    } catch (error) {
      console.error("Không thể tải file:", filePath, error);
    }
  }
}

// === Khi trang load xong ===
document.addEventListener("DOMContentLoaded", () => {
  let basePath = "";

  if (window.location.pathname.includes("/pages/")) {
    basePath = "../../"; // đang ở trong pages => đi ra 2 cấp
  } else {
    basePath = "src/"; // đang ở index.html
  }

  loadComponent("header", `${basePath}components/header.html`);
  loadComponent("footer", `${basePath}components/footer.html`);
});

// === Hàm đánh dấu menu đang active ===
// function highlightActiveLink() {
//   const currentPath = window.location.pathname.split("/").pop() || "index.html";

//   document.querySelectorAll(".nav__item a").forEach(a => {
//     a.classList.remove("active");

//     const linkPath = a.getAttribute("href").split("/").pop();
//     if (linkPath === currentPath) {
//       a.classList.add("active");
//     }
//   });
// }
function highlightActiveLink() {
  const currentPath = window.location.pathname.replace(/\\/g, "/");

  // Xóa tất cả class active cũ
  document.querySelectorAll(".nav__item a").forEach(a => a.classList.remove("active"));

  // Tìm link con khớp nhất với URL hiện tại
  let matchedLink = null;
  document.querySelectorAll(".nav__item a").forEach(a => {
    const href = a.getAttribute("href");
    if (currentPath.endsWith(href) || currentPath.includes(href.replace("/index.html", ""))) {
      matchedLink = a;
    }
  });

  // Nếu tìm được link phù hợp
  if (matchedLink) {
    matchedLink.classList.add("active");

    // Nếu link con nằm trong dropdown -> active luôn thằng cha
    const parentDropdown = matchedLink.closest(".dropdown");
    if (parentDropdown) {
      const parentLink = parentDropdown.querySelector(":scope > a");
      if (parentLink) parentLink.classList.add("active");
    }
  }
}

// Gọi highlightActiveLink ngay sau khi load header
async function loadComponent(id, filePath) {
  const container = document.getElementById(id);
  if (container) {
    try {
      const response = await fetch(filePath);
      if (!response.ok) throw new Error("Không tìm thấy file: " + filePath);
      const html = await response.text();
      container.innerHTML = html;

      if (id === "header") {
        highlightActiveLink();
      }
    } catch (error) {
      console.error("Không thể tải file:", filePath, error);
    }
  }
}

document.addEventListener("DOMContentLoaded", () => {
  let basePath = window.location.pathname.includes("/pages/") ? "../../" : "src/";
  loadComponent("header", `${basePath}components/header.html`);
  loadComponent("footer", `${basePath}components/footer.html`);
});

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