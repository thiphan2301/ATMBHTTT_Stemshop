<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
  <title>Hồ sơ của tôi | STEAM SHOP</title>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/profile.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
  <style>
    /* ==== CSS TOÀN CỤC CHO PROFILE ==== */
    :root {
      --primary: #ee4d2d;
      --primary-hover: #d73a1c;
      --text-main: #333;
      --text-muted: #757575;
      --bg-body: #f5f5f5;
      --border-color: #e0e0e0;
      --radius: 8px;
    }

    body { background-color: var(--bg-body); }

    .breadcrumb {
      background-color: transparent;
      padding: 15px 0;
      font-size: 14px;
      color: var(--text-muted);
      max-width: 1100px;
      margin: 0 auto;
    }
    .breadcrumb a { color: var(--text-main); text-decoration: none; transition: 0.2s; }
    .breadcrumb a:hover { color: var(--primary); }
    .breadcrumb span { margin: 0 10px; color: #ccc; }

    /* Khung Profile Chính */
    .profile-container {
      max-width: 1100px;
      margin: 0 auto 50px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.05);
      overflow: hidden;
    }

    .profile-header {
      padding: 25px 30px;
      border-bottom: 1px solid var(--border-color);
    }
    .profile-header h2 { margin: 0; font-size: 22px; color: var(--text-main); font-weight: 600; }
    .profile-header p { margin: 8px 0 0; color: var(--text-muted); font-size: 14px; }

    /* Alert Thông Báo */
    .alert-box {
      padding: 12px 20px; margin: 20px 30px 0;
      border-radius: var(--radius); font-weight: 500; font-size: 14.5px;
      display: flex; align-items: center; gap: 10px;
    }
    .alert-box.success { background: #e8f5e9; color: #2e7d32; border: 1px solid #c8e6c9; }
    .alert-box.error { background: #ffebee; color: #c62828; border: 1px solid #ffcdd2; }

    /* Bố cục Form */
    .profile-body {
      display: flex;
      padding: 30px;
      gap: 50px;
    }

    /* --- Cột Trái (Inputs) --- */
    .profile-form { flex: 2; }
    .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    .form-group.full-width { grid-column: span 2; }

    .form-group label {
      display: block; margin-bottom: 8px; font-weight: 500;
      color: #555; font-size: 14.5px;
    }

    .form-control {
      width: 100%; padding: 12px 15px; border: 1px solid #ccc;
      border-radius: var(--radius); font-size: 15px; transition: all 0.3s;
      outline: none; color: var(--text-main); font-family: inherit;
    }
    .form-control:focus { border-color: var(--primary); box-shadow: 0 0 0 3px rgba(238, 77, 45, 0.1); }
    .form-control[readonly] { background: #f9f9f9; color: #999; cursor: not-allowed; border-color: #eee; }

    /* Nút Giới Tính (Radio Pills) */
    .gender-options { display: flex; gap: 15px; }
    .gender-options label {
      cursor: pointer; padding: 10px 20px; border: 1px solid #ccc;
      border-radius: 20px; font-size: 14px; color: #555;
      transition: all 0.2s; user-select: none; margin: 0;
    }
    .gender-options input[type="radio"] { display: none; }
    .gender-options input[type="radio"]:checked + label {
      background: var(--primary); color: #fff; border-color: var(--primary);
    }

    /* Nút bấm chung */
    .btn {
      padding: 12px 28px; border: none; border-radius: var(--radius);
      font-size: 15px; font-weight: 600; cursor: pointer; transition: 0.3s;
      display: inline-flex; align-items: center; gap: 8px;
    }
    .btn-primary { background: var(--primary); color: #fff; box-shadow: 0 4px 6px rgba(238, 77, 45, 0.2); }
    .btn-primary:hover { background: var(--primary-hover); transform: translateY(-1px); }
    .btn-outline { border: 1px solid #ccc; background: #fff; color: #555; }
    .btn-outline:hover { background: #f5f5f5; border-color: #999; }

    /* --- Cột Phải (Avatar) --- */
    .profile-avatar-sec {
      flex: 1; display: flex; flex-direction: column;
      align-items: center; border-left: 1px solid #eee; padding-left: 30px;
    }
    .avatar-wrapper { position: relative; margin-bottom: 20px; }
    .avatar-img {
      width: 140px; height: 140px; border-radius: 50%;
      object-fit: cover; border: 3px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1);
    }
    .avatar-btn {
      position: absolute; bottom: 5px; right: 5px; width: 38px; height: 38px;
      background: #fff; color: #555; border: 1px solid #ddd; border-radius: 50%;
      display: flex; align-items: center; justify-content: center;
      cursor: pointer; font-size: 16px; box-shadow: 0 2px 5px rgba(0,0,0,0.1);
      transition: 0.2s;
    }
    .avatar-btn:hover { background: var(--primary); color: #fff; border-color: var(--primary); }
    .avatar-desc { text-align: center; color: var(--text-muted); font-size: 13.5px; line-height: 1.6; }

    /* --- KHU VỰC ĐỔI MẬT KHẨU --- */
    .password-section {
      margin: 0 30px 30px; padding: 25px;
      background: #fafafa; border: 1px solid #eee; border-radius: var(--radius);
      display: none; /* Ẩn mặc định */
      animation: fadeInDown 0.3s ease forwards;
    }
    @keyframes fadeInDown {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
    }
    .password-section h3 { margin: 0 0 20px; font-size: 18px; color: #333; display: flex; align-items: center; gap: 8px;}

    /* Responsive */
    @media (max-width: 768px) {
      .profile-body { flex-direction: column-reverse; gap: 30px; padding: 20px; }
      .form-grid { grid-template-columns: 1fr; }
      .form-group.full-width { grid-column: span 1; }
      .profile-avatar-sec { border-left: none; padding-left: 0; border-bottom: 1px solid #eee; padding-bottom: 30px; }
    }
    .address-grid {
      display: grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 15px;
    }
    @media (max-width: 768px) {
      .address-grid { grid-template-columns: 1fr; gap: 10px; }
    }
  </style>
</head>
<body>

<%@ include file="/WEB-INF/components/header.jsp" %>

<div class="breadcrumb">
  <a href="${pageContext.request.contextPath}/"><i class="fa-solid fa-house"></i> Trang Chủ</a>
  <span>/</span>
  <strong>Hồ sơ của tôi</strong>
</div>

<div class="profile-container">
  <div class="profile-header">
    <h2>Hồ Sơ Của Tôi</h2>
    <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p>
  </div>

  <c:if test="${not empty message}">
    <div class="alert-box success"><i class="fa-solid fa-circle-check"></i> ${message}</div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert-box error"><i class="fa-solid fa-circle-exclamation"></i> ${error}</div>
  </c:if>
  <c:if test="${not empty error1}">
    <div class="alert-box error"><i class="fa-solid fa-triangle-exclamation"></i> Lỗi đổi mật khẩu: ${error1}</div>
  </c:if>

  <div class="profile-body">
      <form id="profile-form" class="profile-form" method="post" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data">
      <div class="form-grid">

        <div class="form-group">
          <label>Tên đăng nhập</label>
          <input type="text" class="form-control" value="${user.userName}" readonly title="Không thể thay đổi tên đăng nhập">
        </div>

        <div class="form-group">
          <label>Họ và Tên</label>
          <input type="text" name="fullName" class="form-control" value="${user.fullName}" placeholder="Nhập họ và tên">
        </div>

        <div class="form-group">
          <label>Email</label>
          <input type="email" name="email" class="form-control" value="${user.email}" placeholder="example@gmail.com">
        </div>

        <div class="form-group">
          <label>Số điện thoại</label>
          <input type="tel" name="phoneNumber" class="form-control" value="${user.phoneNumber}"
                 placeholder="Nhập số điện thoại"
                 required
                 pattern="^0\d{9}$"
                 title="Số điện thoại gồm 10 số và bắt đầu bằng số 0">
        </div>

        <div class="form-group full-width">
          <label>Giới tính</label>
          <div class="gender-options">
            <input type="radio" id="gender-male" name="gender" value="NAM" ${user.gender == 'NAM' ? 'checked' : ''}>
            <label for="gender-male">Nam</label>

            <input type="radio" id="gender-female" name="gender" value="NU" ${user.gender == 'NU' ? 'checked' : ''}>
            <label for="gender-female">Nữ</label>

            <input type="radio" id="gender-other" name="gender" value="KHAC" ${user.gender == 'KHAC' ? 'checked' : ''}>
            <label for="gender-other">Khác</label>
          </div>
        </div>

        <div class="form-group">
          <label>Ngày sinh</label>
          <input type="date" name="birthday" class="form-control" value="${user.birthday}">
        </div>

        <div class="form-group full-width">
          <label>Địa chỉ nhận hàng</label>

          <div class="address-grid">
            <select id="province" class="form-control">
              <option value="">Chọn Tỉnh/Thành phố</option>
            </select>
            <select id="district" class="form-control" disabled>
              <option value="">Chọn Quận/Huyện</option>
            </select>
            <select id="ward" class="form-control" disabled>
              <option value="">Chọn Phường/Xã</option>
            </select>
          </div>

          <input type="text" id="street" class="form-control" style="margin-top: 15px;" placeholder="Nhập số nhà, tên đường...">

          <input type="hidden" name="address" id="fullAddress" value="${user.address}">

          <small style="color: #888; display: block; margin-top: 8px;">
            Địa chỉ hiện tại: <strong>${user.address}</strong>
          </small>
        </div>
      </div>

      <div style="margin-top: 30px; display: flex; gap: 15px; align-items: center;">
        <button type="submit" class="btn btn-primary"><i class="fa-solid fa-floppy-disk"></i> Lưu Thay Đổi</button>
        <button type="button" class="btn btn-outline" onclick="togglePasswordBox()"><i class="fa-solid fa-key"></i> Đổi Mật Khẩu</button>
      </div>
    </form>

    <div class="profile-avatar-sec">
        <div class="avatar-wrapper">
            <c:choose>
                <%-- Nếu chưa có ảnh thì hiện ảnh mặc định --%>
                <c:when test="${empty user.avatar}">
                    <img id="avatarPreview" src="${pageContext.request.contextPath}/assets/images/user/user-male-circle.jpg" class="avatar-img" alt="Avatar">
                </c:when>

                <%-- Nếu đăng nhập Google (link có chữ http) --%>
                <c:when test="${user.avatar.startsWith('http')}">
                    <img id="avatarPreview" src="${user.avatar}" class="avatar-img" alt="Avatar">
                </c:when>

                <%-- Nếu là ảnh tự upload --%>
                <c:otherwise>
                    <img id="avatarPreview" src="${pageContext.request.contextPath}/avatar/${user.avatar}" class="avatar-img" alt="Avatar">
                </c:otherwise>
            </c:choose>

            <label for="avatarInput" class="avatar-btn" title="Chọn ảnh mới">
                <i class="fa-solid fa-camera"></i>
            </label>
        </div>
    </div>
  </div>

  <input type="file" id="avatarInput" form="profile-form" name="avatar" accept="image/png, image/jpeg" style="display: none;">

  <div class="password-section" id="passwordBox" style="display: ${not empty error1 ? 'block' : 'none'};">
    <h3><i class="fa-solid fa-shield-halved" style="color: var(--primary);"></i> Cập Nhật Mật Khẩu</h3>
    <form action="${pageContext.request.contextPath}/change-password" method="post">
      <div class="form-grid">
        <div class="form-group full-width">
          <label>Mật khẩu hiện tại</label>
          <input type="password" name="oldPassword" class="form-control" placeholder="Nhập mật khẩu cũ" required>
        </div>
        <div class="form-group">
          <label>Mật khẩu mới</label>
          <input type="password" name="newPassword" class="form-control" placeholder="Mật khẩu mới" required>
        </div>
        <div class="form-group">
          <label>Xác nhận mật khẩu mới</label>
          <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
        </div>
      </div>
      <div style="margin-top: 20px;">
        <button type="submit" class="btn btn-primary">Xác nhận đổi mật khẩu</button>
      </div>
    </form>
  </div>

</div>

<%@ include file="/WEB-INF/components/footer.jsp" %>

<script>
  // 1. Logic ẩn/hiện form đổi pass mượt mà (Không làm ẩn nút Lưu nữa)
  function togglePasswordBox() {
    const box = document.getElementById("passwordBox");
    if (box.style.display === "none" || box.style.display === "") {
      box.style.display = "block";
      // Tự động cuộn xuống form đổi pass
      box.scrollIntoView({ behavior: 'smooth', block: 'center' });
    } else {
      box.style.display = "none";
    }
  }

  // 2. Logic hiện ảnh Avatar ngay khi chọn file
  document.getElementById("avatarInput").addEventListener("change", function (e) {
    const file = e.target.files[0];
    if (file) {
      // Validate sơ bộ dung lượng (1MB = 1048576 bytes)
      if (file.size > 1048576) {
        alert("Dung lượng file quá lớn. Vui lòng chọn file dưới 1MB.");
        this.value = ''; // Reset file
        return;
      }
      const reader = new FileReader();
      reader.onload = function () {
        document.getElementById("avatarPreview").src = reader.result;
      };
      reader.readAsDataURL(file);
    }
  });

  // Code liên kết thuộc tính form
  // Vì thẻ <input type="file"> bị kéo ra khỏi form nên ta dùng javascript ghép vào hoặc để nó bên trong form.
  // Trong HTML ở trên mình đã giải quyết bằng cách bọc form chuẩn chỉ, <input file> sẽ kích hoạt bình thường.
  document.querySelector('.profile-form').appendChild(document.getElementById('avatarInput'));
</script>

<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/pages/API%20_dia_chi.js"></script>

</body>
</html>