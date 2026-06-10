package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.PasswordUtils;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/dat-lai-mat-khau")
public class ResetPasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    private static final String PASSWORD_PATTERN = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d).{6,}$";
    private static final Pattern passwordRegex = Pattern.compile(PASSWORD_PATTERN);

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");

        if (token == null || token.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/quen-mat-khau");
            return;
        }

        try {
            // Kiểm tra token hợp lệ
            String email = userDAO.getEmailByResetToken(token);

            if (email == null) {
                request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
                request.getRequestDispatcher("/view/user/forgot-password.jsp").forward(request, response);
                return;
            }

            // Token hợp lệ, hiển thị form đặt lại mật khẩu
            request.setAttribute("token", token);
            request.getRequestDispatcher("/view/user/reset-password.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/quen-mat-khau");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        String error = null;

        // Validate input
        if (token == null || token.trim().isEmpty()) {
            error = "Token không hợp lệ";
        } else if (newPassword == null || newPassword.isEmpty()) {
            error = "Vui lòng nhập mật khẩu mới";
        } else if (confirmPassword == null || confirmPassword.isEmpty()) {
            error = "Vui lòng xác nhận mật khẩu";
        } else if (!newPassword.equals(confirmPassword)) {
            error = "Mật khẩu xác nhận không khớp";
        } else if (!passwordRegex.matcher(newPassword).matches()) {
            error = "Mật khẩu phải dài ít nhất 6 ký tự, bao gồm chữ hoa, chữ thường và số";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("token", token);
            request.getRequestDispatcher("/view/user/reset-password.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra token còn hợp lệ không
            String email = userDAO.getEmailByResetToken(token);

            if (email == null) {
                request.setAttribute("error", "Link đặt lại mật khẩu không hợp lệ hoặc đã hết hạn.");
                request.getRequestDispatcher("/view/user/forgot-password.jsp").forward(request, response);
                return;
            }

            // Mã hóa mật khẩu mới
            String hashedPassword = PasswordUtils.hashPassword(newPassword);

            // Cập nhật mật khẩu mới
            boolean updated = userDAO.updatePasswordByEmail(email, hashedPassword);

            if (updated) {
                // Đánh dấu token đã dùng
                userDAO.markTokenAsUsed(token);

                request.setAttribute("success", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Đặt lại mật khẩu thất bại, vui lòng thử lại.");
                request.setAttribute("token", token);
                request.getRequestDispatcher("/view/user/reset-password.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống, vui lòng thử lại sau.");
            request.setAttribute("token", token);
            request.getRequestDispatcher("/view/user/reset-password.jsp").forward(request, response);
        }
    }
}