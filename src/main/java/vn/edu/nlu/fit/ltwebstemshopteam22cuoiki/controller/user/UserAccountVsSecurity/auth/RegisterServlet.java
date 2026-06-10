package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.EmailUtils;

import java.io.IOException;
import java.util.regex.Pattern;


@WebServlet("/dang-ky")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    // kiểm tra mật khẩu: ít nhất 6 ký tự, có chữ hoa, chữ thường, số
    private static final String PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,}$";
    private static final Pattern passwordRegex = Pattern.compile(PASSWORD_PATTERN);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/user/sign-up.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        String error = null;

        // Kiểm tra thiếu thông tin
        if (username == null || username.trim().isEmpty()) {
            error = "Vui lòng nhập tên người dùng";
        } else if (email == null || email.trim().isEmpty()) {
            error = "Vui lòng nhập email";
        } else if (password == null || password.isEmpty()) {
            error = "Vui lòng nhập mật khẩu";
        } else if (confirmPassword == null || confirmPassword.isEmpty()) {
            error = "Vui lòng xác nhận mật khẩu";
        }
        // Kiểm tra mật khẩu khớp
        else if (!password.equals(confirmPassword)) {
            error = "Mật khẩu xác nhận không khớp";
        }
        // Kiểm tra độ mạnh mật khẩu
        else if (!passwordRegex.matcher(password).matches()) {
            error = "Mật khẩu phải dài ít nhất 6 ký tự, bao gồm chữ hoa, chữ thường và số";
        }
        // Kiểm tra email đã tồn tại
        else {
            try {
                if (userDAO.isEmailExists(email)) {
                    error = "Email này đã được đăng ký";
                }
            } catch (Exception e) {
                e.printStackTrace();
                error = "Lỗi hệ thống, vui lòng thử lại sau";
            }
        }

        // Nếu có lỗi, quay lại form
        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("username", username);
            request.setAttribute("email", email);
            request.getRequestDispatcher("/view/user/sign-up.jsp").forward(request, response);
            return;
        }

        // Tạo user mới
        try {
            User newUser = new User();
            newUser.setUserName(username);
            newUser.setEmail(email);
            newUser.setPassword(password);

            String verificationToken = userDAO.createUser(newUser);  // Trả về token

            if (verificationToken != null) {
                // Gửi email xác thực
                boolean emailSent = EmailUtils.sendVerificationEmail(email, verificationToken);

                if (emailSent) {
                    request.setAttribute("success", "Đăng ký thành công! Vui lòng kiểm tra email để xác thực tài khoản.");
                } else {
                    request.setAttribute("warning", "Đăng ký thành công nhưng không gửi được email xác thực.");
                }
            } else {
                request.setAttribute("error", "Đăng ký thất bại, vui lòng thử lại");
                request.getRequestDispatcher("/view/user/sign-up.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("/view/user/sign-up.jsp").forward(request, response);
        }
    }
}