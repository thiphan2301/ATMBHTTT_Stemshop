package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.EmailUtils;

import java.io.IOException;
import java.util.Date;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

@WebServlet("/quen-mat-khau")
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/view/user/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String email = request.getParameter("email");

        String message = null;
        String error = null;

        // Validate input
        if (username == null || username.trim().isEmpty()) {
            error = "Vui lòng nhập tên đăng nhập";
        } else if (email == null || email.trim().isEmpty()) {
            error = "Vui lòng nhập email";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/view/user/forgot-password.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra username và email có khớp không
            boolean valid = userDAO.checkUserCredentials(username.trim(), email.trim());

            // QUAN TRỌNG: Dù đúng hay sai, đều hiển thị thông báo giống nhau (bảo mật)
            if (valid) {
                // Tạo token mới
                String token = UUID.randomUUID().toString();
                // Lưu token vào database
                boolean saved = userDAO.saveResetToken(email.trim(), token);

                if (saved) {
                    // Gửi email reset mật khẩu
                    boolean emailSent = EmailUtils.sendResetPasswordEmail(email.trim(), username.trim(), token);

                    if (emailSent) {
                        message = "Link đặt lại mật khẩu đã được gửi đến email của bạn (có hiệu lực 1 giờ).";
                    } else {
                        message = "Không thể gửi email. Vui lòng thử lại sau.";
                    }
                } else {
                    message = "Link đặt lại mật khẩu đã được gửi đến email của bạn (có hiệu lực 1 giờ).";
                }
            } else {
                // Thông báo giống nhau để không lộ thông tin
                message = "Link đặt lại mật khẩu đã được gửi đến email của bạn (có hiệu lực 1 giờ).";
            }

            request.setAttribute("message", message);
            request.getRequestDispatcher("/view/user/forgot-password.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            error = "Lỗi hệ thống, vui lòng thử lại sau.";
            request.setAttribute("error", error);
            request.getRequestDispatcher("/view/user/forgot-password.jsp").forward(request, response);
        }
    }
}