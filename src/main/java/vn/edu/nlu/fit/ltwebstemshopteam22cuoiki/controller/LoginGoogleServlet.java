package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.GoogleUtils;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.GoogleUserDTO;


import java.io.IOException;

@WebServlet("/login-google")
public class LoginGoogleServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String code = request.getParameter("code");

        if (code == null || code.isEmpty()) {
            response.sendRedirect("/view/user/sign-in.jsp");
            return;
        }

        try {
            // 1. Đổi code lấy Access Token
            String accessToken = GoogleUtils.getToken(code);

            // 2. Lấy info từ Google
            GoogleUserDTO googleInfo = GoogleUtils.getUserInfo(accessToken);

            // 3. Xử lý Database (Check/Insert)
            UserDAO dao = new UserDAO();
            User userSystem = dao.loginWithGoogle(googleInfo);

            if (userSystem != null) {
                // 4. Lưu vào Session
                HttpSession session = request.getSession();
                session.setAttribute("user", userSystem);
                response.sendRedirect("index.jsp"); // Về trang chủ
            } else {
                response.sendRedirect("login.jsp?error=auth_failed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=server_error");
        }
    }
}