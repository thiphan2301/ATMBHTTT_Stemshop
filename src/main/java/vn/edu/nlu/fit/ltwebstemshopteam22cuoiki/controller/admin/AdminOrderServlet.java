package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Order;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/admin-orders")
public class AdminOrderServlet extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() {
        orderDAO = new OrderDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Order> orders = orderDAO.getAllOrdersForAdmin();
        request.setAttribute("orders", orders);

        request.getRequestDispatcher("/view/admin/admin-orders.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        String action = request.getParameter("action");

        if ("confirm".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "SHIPPING");
        } else if ("cancel".equals(action)) {
            orderDAO.updateOrderStatus(orderId, "CANCELLED");
        }

        response.sendRedirect(request.getContextPath() + "/admin/admin-orders");
    }
}