package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.CartVsCheckout.checkout;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Cart;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebServlet(name = "BuyNowServlet", value = "/BuyNowServlet")
public class BuyNowServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            //check user đã login chưa
            User user = (User) session.getAttribute("user");
            if(user == null){
              response.sendRedirect("/dang-nhap");
            }

            //lấy cart hiện tại hoặc tạo mới nếu null
            Cart cart = (Cart) session.getAttribute("cart");
            if(cart == null){
                cart = new Cart();
                session.setAttribute("cart", cart);
            }

            //thêm vào giỏ hàng, chỉ thêm ngầm để thanh toán (không cần đi qua trang giỏ hàng)

            //lấy ra ProductId từ URL
            String productIdStr = request.getParameter("productId");
            if (productIdStr == null || productIdStr.trim().isEmpty()) {
                System.out.println("Sản phẩm không tồn tại");
            }
            int productId = Integer.parseInt(productIdStr);
            // từ ProductId lấy ra sp tương ứng
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findByIdWithImage(productId);
            //thêm sp vừa lấy ra vào giỏ hàng
            cart.add(product);
            //chuyển thằng đến thanh toán
            response.sendRedirect(request.getContextPath()+"/checkout");

        }catch(Exception e){
            e.printStackTrace();
        }
    }
}