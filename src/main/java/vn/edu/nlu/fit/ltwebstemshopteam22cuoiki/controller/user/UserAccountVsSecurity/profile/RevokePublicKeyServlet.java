package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserKeyDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebServlet("/revoke-key")
public class RevokePublicKeyServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { //check login
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }

        UserKeyDAO userKeyDAO = new UserKeyDAO();
        try {
            boolean isRevoke = userKeyDAO.revokeActiveKey(user.getId());
            if(isRevoke) {
                session.setAttribute("message", "Thu hồi khóa thành công");
                session.setAttribute("errorPublicKey", "show");
            } else {
                session.setAttribute("errorPublicKey", "Không tìm thấy khóa nào để thu hồi hoặc đã xảy ra lỗi.");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}
