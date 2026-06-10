package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebFilter("/*")
public class UserFilter implements Filter {
    private UserDAO userDAO;
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession(false);

        String path = request.getRequestURI().substring(request.getContextPath().length());

        if (path.startsWith("/assets") || path.startsWith("/css/") || path.startsWith("/js/")) {
            chain.doFilter(req, res);
            return;
        }

        if (session != null && session.getAttribute("user") != null) {
            User currentUser = (User) session.getAttribute("user");
            User freshUser = userDAO.getUserById(currentUser.getId());

            if (freshUser != null && "LOCKED".equalsIgnoreCase(freshUser.getStatus())) {
                // Hủy session của tài khoản bị khóa
                session.invalidate();

                // Tạo session mới để gửi thông báo cho người dùng
                HttpSession newSession= request.getSession(true);
                newSession.setAttribute("lockError", "Tài khoản của bạn đã bị khóa. Vui lòng liên hệ hỗ trợ để biết thêm chi tiết.");

                // Chuyển hướng về trang chủ
                response.sendRedirect(request.getContextPath()+ "/");
                return;
            }
        }
        chain.doFilter(req, res);
    }
}
