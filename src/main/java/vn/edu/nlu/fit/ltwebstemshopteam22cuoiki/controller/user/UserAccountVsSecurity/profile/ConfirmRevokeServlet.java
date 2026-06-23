package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserKeyDAO;

import java.io.IOException;

@WebServlet("/confirm-revoke")
public class ConfirmRevokeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String token = req.getParameter("token");
        HttpSession session = req.getSession();

        if(token == null || token.isEmpty()) {
            session.setAttribute("errorPublicKey", "Đường dẫn xác nhận không hợp lệ!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        UserKeyDAO userKeyDAO = new UserKeyDAO();
        try {
            boolean ok = userKeyDAO.revokeActiveKey(token);
            if (ok) {
                session.setAttribute("message", "Khóa bảo mật của bạn đã được THU HỒI thành công!");
                session.setAttribute("errorPublicKey", "show");
            } else {
                session.setAttribute("errorPublicKey", "Liên kết xác nhận không hợp lệ hoặc đã hết hạn trước đó.");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
