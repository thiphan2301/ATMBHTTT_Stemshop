package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ReviewDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Reviews;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/admin-product-detail")
public class AdminProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/admin-products");
            return;
        }

        try {
            int productId = Integer.parseInt(idParam);

            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.findByIdWithImage(productId);

            if (product != null) {
                // ---> GỌI HÀM NÀY ĐỂ LẤY DATA TỒN KHO & LÔ HÀNG <---
                productDAO.setInventoryAndBatchDetails(product);

                List<Reviews> reviews = ReviewDAO.getByProductId(productId);
                double avgRating = ReviewDAO.getAverageRating(productId);
                int totalReviews = ReviewDAO.getTotalReviews(productId);

                request.setAttribute("product", product);
                request.setAttribute("reviews", reviews);
                request.setAttribute("avgRating", avgRating);
                request.setAttribute("totalReviews", totalReviews);

                request.getRequestDispatcher("/view/admin/admin-product-detail.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/admin-products");
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/admin/admin-products");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi hệ thống khi tải chi tiết");
        }
    }
}