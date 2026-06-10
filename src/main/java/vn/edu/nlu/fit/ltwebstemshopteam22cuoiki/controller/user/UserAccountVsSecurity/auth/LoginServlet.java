package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.auth;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.PasswordUtils;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.GoogleUtils;

import java.io.IOException;

@WebServlet("/dang-nhap")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String googleLoginUrl = GoogleUtils.getGoogleAuthUrl();
        request.setAttribute("googleLoginUrl", googleLoginUrl);
        request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        String error = null;

        // Kiểm tra nhập liệu
        if (username == null || username.trim().isEmpty()) {
            error = "Vui lòng nhập tên đăng nhập";
        } else if (password == null || password.isEmpty()) {
            error = "Vui lòng nhập mật khẩu";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
            return;
        }

        try {
            User user = userDAO.findByUsernameOrEmail(username.trim());

            if (user == null) {
                error = "Sai tên đăng nhập hoặc mật khẩu";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
                return;
            }

            // Sau khi tìm thấy user, trước khi kiểm tra mật khẩu
            if (!user.isVerified()) {
                error = "Tài khoản chưa được xác thực. Vui lòng kiểm tra email để xác thực.";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
                return;
            }

            // Kiểm tra mật khẩu (dùng BCrypt)
            if (!PasswordUtils.verifyPassword(password, user.getPassword())) {
                error = "Sai tên đăng nhập/email hoặc mật khẩu";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
                return;
            }

            // Chặn đăng nhập nếu tài khoản bị khóa
            if(user.getStatus() != null && "LOCKED".equalsIgnoreCase(user.getStatus())){
                error = "Tài khoản của bạn hiện đã bị khóa. Vui lòng liên hệ hỗ trợ để biết thêm chi tiết.";
                request.setAttribute("error", error);
                request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
                return;

            }

            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUserName());
            session.setAttribute("role", user.getRole());

            // Chuyển hướng về trang chủ hoặc trang trước đó
            String redirectUrl = (String) session.getAttribute("redirectAfterLogin");
            if (redirectUrl != null) {
                session.removeAttribute("redirectAfterLogin");
                response.sendRedirect(redirectUrl);
            } else {
                response.sendRedirect(request.getContextPath() + "/");
            }

        } catch (Exception e) {
            e.printStackTrace();
            error = "Lỗi hệ thống, vui lòng thử lại sau";
            request.setAttribute("error", error);
            request.getRequestDispatcher("/view/user/sign-in.jsp").forward(request, response);
        }
    }
}