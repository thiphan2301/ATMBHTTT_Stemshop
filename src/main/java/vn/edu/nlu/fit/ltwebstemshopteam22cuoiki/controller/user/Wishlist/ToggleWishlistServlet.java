package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.Wishlist;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.WishlistDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebServlet("/toggle-wishlist")
public class ToggleWishlistServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null) {
            resp.setStatus(401);
            return;
        }

        int productId = Integer.parseInt(req.getParameter("id"));
        WishlistDAO dao = new WishlistDAO();

        if (dao.exists(user.getId(), productId)) {
            dao.delete(user.getId(), productId);
        } else {
            dao.insert(user.getId(), productId);
        }

        resp.setStatus(HttpServletResponse.SC_OK);
    }
}

