package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.profile;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebServlet("/xac-nhan-email")
public class VerifyEmailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String token = request.getParameter("token");

        if (token == null || token.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/");
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.getUserByVerifyToken(token);

        if (user != null && user.getPendingEmail() != null) {
            // Kiểm tra Token còn hạn không
            if (user.getTokenExpiry().getTime() > System.currentTimeMillis()) {

                // Cập nhật Database
                dao.confirmEmailChange(user.getId(), user.getPendingEmail());

                // Cập nhật lại Session nếu user đang online
                User sessionUser = (User) request.getSession().getAttribute("user");
                if (sessionUser != null && sessionUser.getId() == user.getId()) {
                    sessionUser.setEmail(user.getPendingEmail());
                }

                // Chuyển hướng về trang profile kèm thông báo
                request.getSession().setAttribute("message", "Đổi email thành công!");
                response.sendRedirect(request.getContextPath() + "/profile");

            } else {
                request.getSession().setAttribute("error", "Đường link đã hết hạn, vui lòng thao tác lại trong Hồ sơ.");
                response.sendRedirect(request.getContextPath() + "/profile");
            }
        } else {
            request.getSession().setAttribute("error", "Mã xác nhận không hợp lệ hoặc đã được sử dụng.");
            response.sendRedirect(request.getContextPath() + "/profile");
        }
    }
}