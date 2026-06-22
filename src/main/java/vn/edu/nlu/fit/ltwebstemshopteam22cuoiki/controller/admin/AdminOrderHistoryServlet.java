package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.OrderChangeHistoryDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.OrderChangeHistory;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/admin-order-history")
public class AdminOrderHistoryServlet extends HttpServlet {
    private OrderChangeHistoryDAO historyDAO;

    @Override
    public void init() throws ServletException {
        historyDAO = new OrderChangeHistoryDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<OrderChangeHistory> histories = historyDAO.getAllHistory();
        request.setAttribute("histories", histories);
        request.getRequestDispatcher("/view/admin/admin-order-history.jsp").forward(request, response);
    }
}
