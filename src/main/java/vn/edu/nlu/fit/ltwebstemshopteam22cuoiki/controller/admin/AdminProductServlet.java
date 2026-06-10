package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/admin-products")
public class AdminProductServlet extends HttpServlet {

    private ProductDAO productDAO;

    @Override
    public void init() {
        productDAO = new ProductDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");

        List<Product> products;
        if (search != null && !search.trim().isEmpty()) {
            products = productDAO.searchByName(search);
        } else {
            products = productDAO.getAllWithBrand();
        }

        request.setAttribute("products", products);
        request.getRequestDispatcher("/view/admin/admin-products.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            productDAO.deleteById(id);
        }

        response.sendRedirect(request.getContextPath() + "/admin/admin-products");
    }
}