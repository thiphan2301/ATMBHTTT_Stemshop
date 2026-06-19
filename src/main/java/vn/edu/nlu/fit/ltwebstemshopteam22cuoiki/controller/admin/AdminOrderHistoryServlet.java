package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.OrderHistoryLogger;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.OrderHistoryLogger.OrderHistoryEntry;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/admin-order-history")
public class AdminOrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<OrderHistoryEntry> history = OrderHistoryLogger.readHistory();
        request.setAttribute("history", history);
        request.getRequestDispatcher("/view/admin/admin-order-history.jsp").forward(request, response);
    }
}
