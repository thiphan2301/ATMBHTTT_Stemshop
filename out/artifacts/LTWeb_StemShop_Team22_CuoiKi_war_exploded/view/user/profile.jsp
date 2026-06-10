<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<html>
<head>
  <title>Hồ sơ của tôi</title>
  <meta charset="UTF-8">

  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/pages/profile.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css"/>
</head>
<body>
<style>
  .profile {
    background: #fff;
    padding: 30px;
    margin: 30px auto;
    border-radius: 4px;
  }

  .profile h2 {
    font-size: 20px;
    margin-bottom: 5px;
  }

  .profile p {
    color: #777;
    margin-bottom: 25px;
  }

  .profile__form {
    display: flex;
    gap: 40px;
  }

  .profile__left {
    flex: 2;
  }

  .profile__right {
    flex: 1;
    text-align: center;
  }

  .form-group {
    margin-bottom: 18px;
  }

  .form-group label {
    display: block;
    margin-bottom: 6px;
    color: #555;
  }

  .form-group input[type="text"],
  .form-group input[type="date"],
  .form-group input[type="password"] {
    width: 100%;
    padding: 8px 10px;
    border: 1px solid #ddd;
    border-radius: 4px;
  }

  .form-group input[readonly] {
    background: #f5f5f5;
  }

  .profile__avatar {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    object-fit: cover;
    margin-bottom: 15px;
    border: 1px solid #eee;
  }
  .avatar-wrapper {
    position: relative;
    display: inline-block;
  }

  .avatar-icon {
    position: absolute;
    bottom: 5px;
    right: 5px;
    width: 36px;
    height: 36px;
    background: #ee4d2d;
    color: #fff;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    font-size: 16px;
    box-shadow: 0 2px 6px rgba(0,0,0,0.2);
  }

  .avatar-icon:hover {
    opacity: 0.9;
  }

  .profile__right input[type="file"] {
    margin-top: 10px;
  }

  .btn {
    background: #ee4d2d;
    color: #fff;
    padding: 10px 25px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  .btn:hover {
    opacity: 0.9;
  }

  /*====ĐỔI MẬT KHẨU====*/
  .password-box {
    margin-top: 20px;
    padding: 20px;
    border: 1px solid #eee;
    border-radius: 4px;
    background: #fafafa;
  }


  .password-box h3 {
    margin-bottom: 15px;
  }

  .alert {
    margin-bottom: 15px;
    color: red;
  }
  .alert.success {
    color: green;
  }
  .back {
    background-color: #f6f5f4;
    font-size: 13px;
    padding: 10px;
  }
  .back a,
  .back span{
    text-decoration: none;
    color: #a1a0a0;
    margin-left: 20px;
  }

</style>
<%@ include file="/WEB-INF/components/header.jsp" %>
<div class="back">
  <a href="${pageContext.request.contextPath}/">Trang Chủ</a>
  <span>/</span>
  <a href="#">Profile</a>
</div>

<div class="profile container">
  <h2>Hồ Sơ Của Tôi</h2>
  <p>Quản lý thông tin hồ sơ để bảo mật tài khoản</p>


  <c:if test="${not empty message}">
    <p class="alert success" style="color:blue">${message}</p>
  </c:if>
  <c:if test="${not empty error}">
    <p class="alert" style="color:red">${error}</p>
  </c:if>

  <form  class="profile__form" method="post" action="${pageContext.request.contextPath}/profile" enctype="multipart/form-data">

    <!-- LEFT -->
    <div class="profile__left">

      <div class="form-group">
        <label>Tên đăng nhập</label>
        <input type="text" value="${user.userName}" readonly>
      </div>

      <div class="form-group">
        <label>Tên</label>
        <input type="text" name="fullName" value="${user.fullName}">
      </div>

      <div class="form-group">
        <label>Email</label>
        <input type="text" name="email" value="${user.email}">
      </div>

      <div class="form-group">
        <label>Số điện thoại</label>
        <input type="text" name="phoneNumber" value="${user.phoneNumber}">
      </div>

      <div class="form-group">
        <label>Giới tính</label>
        <label><input type="radio" name="gender" value="NAM"
        ${user.gender == 'NAM' ? 'checked' : ''}> Nam</label>
        <label><input type="radio" name="gender" value="NU"
        ${user.gender == 'NU' ? 'checked' : ''}> Nữ</label>
        <label><input type="radio" name="gender" value="KHAC"
        ${user.gender == 'KHAC' ? 'checked' : ''}> Khác</label>
      </div>

      <div class="form-group">
        <label>Ngày sinh</label>
        <input type="date" name="birthday" value="${user.birthday}">
      </div>

      <div class="form-group">
        <label>Địa chỉ</label>
        <input type="text" name="address" value="${user.address}">
      </div>

      <div class="form-group">
        <button type="button" class="btn" onclick="togglePasswordBox()">Đổi mật khẩu</button>
      </div>

      <button type="submit" class="btn btn--primary" id="saveBtn">Lưu</button>
    </div>

    <!-- RIGHT -->
    <div class="profile__right">
      <div class="avatar-wrapper">
        <img src="${pageContext.request.contextPath}/avatar/${empty user.avatar ? 'default.png' : user.avatar}" class="profile__avatar">

        <label for="avatarInput" class="avatar-icon">
          <i class="fa-solid fa-camera"></i>
        </label>

        <input type="file" id="avatarInput" name="avatar" hidden>
      </div>

      <p>Dung lượng file tối đa 1MB<br>Định dạng: JPEG, PNG</p>
    </div>

  </form>
  <!-- form đổi mật khẩu-->
  <div class="password-box" id="passwordBox" style="display: ${empty error ? 'none' : 'block'};">
    <form action="${pageContext.request.contextPath}/change-password" method="post">
      <c:if test="${not empty error1}">
        <p class="alert" style="color:red">${error1}</p>
      </c:if>
      <div class="form-group">
        <label>Mật khẩu hiện tại</label>
        <input type="password" name="oldPassword" >
      </div>

      <div class="form-group">
        <label>Mật khẩu mới</label>
        <input type="password" name="newPassword" >
      </div>

      <div class="form-group">
        <label>Xác nhận mật khẩu mới</label>
        <input type="password" name="confirmPassword" >
      </div>

      <button class="btn">Xác nhận đổi mật khẩu</button>
    </form>
  </div>

</div>

<%@ include file="/WEB-INF/components/footer.jsp" %>
<!-- Ẩn hiện box đổi pass -->
<script>
  function togglePasswordBox() {
  const box = document.getElementById("passwordBox");
    const saveBtn = document.getElementById("saveBtn");

    if (box.style.display === "none" || box.style.display === "") {
      box.style.display = "block";
      saveBtn.style.display = "none";
    } else {
      box.style.display = "none";
      saveBtn.style.display = "inline-block";
    }
}
</script>

<!-- Hiện ảnh chọn trước lưu -->
<script>
  document.getElementById("avatarInput").addEventListener("change", function (e) {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function () {
        document.querySelector(".profile__avatar").src = reader.result;
      };
      reader.readAsDataURL(file);
    }
  });
</script>

<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>
</body>
</html>
