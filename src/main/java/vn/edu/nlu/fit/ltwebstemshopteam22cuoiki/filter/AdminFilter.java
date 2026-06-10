package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest request = (HttpServletRequest) req;
        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");

        // check user khong hop le thi ve trang danng nhap
        if (user == null || !"ADMIN".equals(user.getRole())) {
            ((HttpServletResponse) res)
                    .sendRedirect(request.getContextPath() + "/view/error/error404.jsp");
            return;
        }

        // neu user hop le (la ADMIN) thi cho phep di tiep
        chain.doFilter(req, res);
    }
}