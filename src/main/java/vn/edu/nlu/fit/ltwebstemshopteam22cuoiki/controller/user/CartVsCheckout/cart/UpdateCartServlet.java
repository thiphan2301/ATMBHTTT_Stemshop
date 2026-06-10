package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.CartVsCheckout.cart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Cart;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.CartItem;

import java.io.IOException;

@WebServlet("/update-cart")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int productId = Integer.parseInt(request.getParameter("id"));
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        Cart cart = (Cart) session.getAttribute("cart");

        if (cart != null) {
            CartItem item = cart.getItems()
                    .stream()
                    .filter(i -> i.getProduct().getId() == productId)
                    .findFirst()
                    .orElse(null);

            if (item != null) {
                if ("inc".equals(action)) {
                    cart.update(productId, item.getQuantity() + 1);
                } else if ("dec".equals(action)) {
                    cart.update(productId, item.getQuantity() - 1);
                }
            }
        }

        response.setStatus(HttpServletResponse.SC_OK);
    }
}