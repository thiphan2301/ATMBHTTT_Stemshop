package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.AppConfig;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.EmailUtils;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.PasswordUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.sql.Date;

@WebServlet("/profile")
@MultipartConfig
public class ProfileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
            return;
        }
        // Kiểm tra nếu là admin, thêm flag
        request.setAttribute("isAdmin", "admin".equalsIgnoreCase(user.getRole()));
        request.setAttribute("user", user);
        request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        String email = request.getParameter("email");
        String phone = request.getParameter("phoneNumber");

        UserDAO dao = new UserDAO();

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/dang-nhap");
            return;
        }

        // Kiểm tra số điện thoại
        if (phone != null && !phone.trim().isEmpty()) {
            // Bắt đầu bằng 0, sau đó là 9 số khác
            if (!phone.matches("^0\\d{9}$")) {
                request.setAttribute("error", "Số điện thoại không hợp lệ");
                request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
                return;
            }
            // check thay đổi sdt
            if (!phone.equals(user.getPhoneNumber())) {
                //Kiểm tra thời gian giới hạn 30 ngày
                if (user.getLastPhoneUpdate() != null) {
                    long timeSinceLastUpdate = System.currentTimeMillis() - user.getLastPhoneUpdate().getTime();
                    long cooldownPeriod = 30L * 24 * 60 * 60 * 1000;

                    if (timeSinceLastUpdate < cooldownPeriod) {
                        long daysLeft = (cooldownPeriod - timeSinceLastUpdate) / (1000 * 60 * 60 * 24);
                        request.setAttribute("error", "Bạn chỉ được đổi số điện thoại 1 lần mỗi 30 ngày. Vui lòng quay lại sau " + daysLeft + " ngày nữa.");
                        request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
                        return;
                    }
                }

                // Check trùng số với người khác
                boolean isExist = dao.checkPhoneExist(phone);
                if (isExist) {
                    request.setAttribute("error", "Số điện thoại này đã được sử dụng bởi một tài khoản khác!");
                    request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
                    return;
                }
            }

        } else {
            request.setAttribute("error", "Số điện thoại không thể để trống");
            request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
            return;
        }

        // Check rỗng và sai định dạng email cơ bản
        if (email == null || email.trim().isEmpty() || !email.matches("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,6}$")) {
            request.setAttribute("error", "Email không hợp lệ");
            request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
            return;
        }
        // Chặn các lỗi gõ phím phổ biến khi nhập email
        if (email.endsWith(".com.com") || email.endsWith(".vn.vn") || email.contains("..")) {
            request.setAttribute("error", "Định dạng đuôi email không hợp lệ (thừa dấu chấm hoặc sai tên miền).");
            request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
            return;
        }

        boolean isEmailChangedPending = false;

        // check thay đổi email
        if (!email.equals(user.getEmail())) {

            // Check xem email mới có ai xài chưa
            if (dao.checkEmailExist(email)) {
                request.setAttribute("error", "Email này đã được đăng ký bởi tài khoản khác!");
                request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
                return;
            }

            // Tạo Token và hạn sử dụng (30 phút)
            String token = java.util.UUID.randomUUID().toString();
            java.sql.Timestamp expireTime = new java.sql.Timestamp(System.currentTimeMillis() + (30 * 60 * 1000));

            // Lưu vào DB (trạng thái chờ)
            dao.savePendingEmail(user.getId(), email, token, expireTime);

            // Gửi email xác nhận
            String appBaseUrl = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath();
            String confirmLink = appBaseUrl + "/xac-nhan-email?token=" + token;
            String mailBody = "<div style='font-family: Arial;'>"
                    + "<h3>Xác nhận thay đổi Email tại STEM Shop</h3>"
                    + "<p>Ai đó (có thể là bạn) vừa yêu cầu đổi email tài khoản sang địa chỉ này.</p>"
                    + "<p>Vui lòng click vào link bên dưới để xác nhận (Link có hiệu lực 30 phút):</p>"
                    + "<a href='" + confirmLink + "' style='background: #ee4d2d; color: white; padding: 10px 15px; text-decoration: none; border-radius: 5px;'>Xác nhận Email Mới</a>"
                    + "</div>";

            EmailUtils.sendHtmlEmail(email, "Xác nhận đổi Email - STEM Shop", mailBody);

            // Đánh dấu là có đổi email
            isEmailChangedPending = true;

        }

        request.setCharacterEncoding("UTF-8");

        // Ghi nhận mốc thời gian nếu số điện thoại có sự thay đổi
        if (!phone.equals(user.getPhoneNumber())) {
            user.setLastPhoneUpdate(new java.sql.Timestamp(System.currentTimeMillis()));
        }

        user.setFullName(request.getParameter("fullName"));
        user.setPhoneNumber(phone);
        user.setGender(request.getParameter("gender"));
        user.setAddress(request.getParameter("address"));

        // set birthday = null nếu nó rỗng tránh lỗi 500
        String birthdayStr = request.getParameter("birthday");
        user.setBirthday((birthdayStr == null || birthdayStr.isEmpty()) ? null : Date.valueOf(birthdayStr));

        // dùng multipart để getPart lấy file ảnh
        Part avatarPart = request.getPart("avatar");
        if (avatarPart != null && avatarPart.getSize() > 0) {
            String fileName = Paths.get(avatarPart.getSubmittedFileName()).getFileName().toString();
            String newFileName = "user_" + user.getId() + "_" + fileName;
            String uploadPath = AppConfig.AVATAR_UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // Tự động tạo thư mục nếu chưa có
            }
            avatarPart.write(uploadPath + File.separator + newFileName);
            user.setAvatar(newFileName); // lưu tên file vào DB
        }

        // Gọi lệnh update DB 1 lần duy nhất cho toàn bộ (SĐT, Tên, Avatar...)
        boolean updated = dao.updateProfile(user);

        if (updated) {
            session.setAttribute("user", user);

            // gộp cả 2 trường hợp
            if (isEmailChangedPending) {
                request.setAttribute("message", "Cập nhật hồ sơ thành công! Vui lòng kiểm tra hộp thư (" + email + ") để xác nhận email mới.");
            } else {
                request.setAttribute("message", "Cập nhật hồ sơ thành công");
            }
        } else {
            request.setAttribute("error", "Cập nhật hồ sơ thất bại");
        }

        request.getRequestDispatcher("/view/user/profile.jsp").forward(request, response);
    }
}