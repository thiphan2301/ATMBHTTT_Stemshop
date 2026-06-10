package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;

import java.io.IOException;

@WebServlet("/xac-thuc")
public class VerifyEmailServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String message = null;
        String status = null;

        if (token == null || token.trim().isEmpty()) {
            message = "Link xác thực không hợp lệ";
            status = "error";
        } else {
            try {
                // Kiểm tra token và xác thực
                boolean verified = userDAO.verifyEmail(token);

                if (verified) {
                    message = "Xác thực thành công! Tài khoản của bạn đã được kích hoạt.";
                    status = "success";
                } else {
                    message = "Link xác thực không hợp lệ hoặc đã hết hạn.";
                    status = "expired";
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "Lỗi hệ thống, vui lòng thử lại sau.";
                status = "error";
            }
        }

        request.setAttribute("message", message);
        request.setAttribute("status", status);
        request.getRequestDispatcher("/view/user/verify-status.jsp").forward(request, response);
    }
}