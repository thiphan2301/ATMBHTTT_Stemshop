package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.Wishlist;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.WishlistDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebServlet("/wishlist-count")
public class WishlistCountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        int count = 0;
        if (user != null) {
            count = new WishlistDAO().countByUser(user.getId());
        }

        resp.setContentType("application/json");
        resp.getWriter().write("{\"count\": " + count + "}");
    }
}