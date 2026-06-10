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
import java.util.UUID;
import java.util.Date;
import java.util.concurrent.TimeUnit;
import java.sql.Timestamp;

@WebServlet("/gui-lai-xac-thuc")
public class ResendVerifyServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập email");
            request.getRequestDispatcher("/verify-status.jsp").forward(request, response);
            return;
        }

        try {
            // Kiểm tra email có tồn tại không
            if (!userDAO.isEmailExists(email)) {
                request.setAttribute("error", "Email không tồn tại trong hệ thống");
                request.getRequestDispatcher("/verify-status.jsp").forward(request, response);
                return;
            }

            // Tạo token mới
            String newToken = UUID.randomUUID().toString();
            Date newExpiry = new Date(System.currentTimeMillis() + TimeUnit.HOURS.toMillis(24));

            // Cập nhật token mới vào database
            boolean updated = userDAO.updateVerificationToken(email, newToken, newExpiry);

            if (updated) {
                // Gửi lại email
                boolean emailSent = EmailUtils.sendVerificationEmail(email, newToken);

                if (emailSent) {
                    request.setAttribute("success", "Đã gửi lại link xác thực. Vui lòng kiểm tra email.");
                } else {
                    request.setAttribute("error", "Gửi email thất bại, vui lòng thử lại sau.");
                }
            } else {
                request.setAttribute("error", "Cập nhật token thất bại, vui lòng thử lại.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
        }

        request.getRequestDispatcher("/verify-status.jsp").forward(request, response);
    }
}