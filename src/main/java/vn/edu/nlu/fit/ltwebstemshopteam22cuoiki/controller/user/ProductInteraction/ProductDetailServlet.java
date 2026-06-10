package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductImageDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ReviewDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.ProductImage;

import java.io.IOException;
import java.util.List;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        ProductDAO productDAO = new ProductDAO();
        ProductImageDAO imageDAO = new ProductImageDAO();

        Product product = productDAO.findByIdWithImage(id);
        List<ProductImage> images = imageDAO.findByProductId(id);

        request.setAttribute("product", product);
        request.setAttribute("images", images);

        //
        ReviewDAO reviewDAO = new ReviewDAO();

        double avgRating = reviewDAO.getAverageRating(id);

        request.setAttribute("avgRating", avgRating);


        request.getRequestDispatcher("/view/shop/product-detail.jsp")
                .forward(request, response);
    }
}
