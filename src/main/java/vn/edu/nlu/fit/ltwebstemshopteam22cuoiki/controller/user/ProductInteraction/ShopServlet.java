package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.CategoryDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ProductDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Category;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {

    private static final int ITEMS_PER_PAGE = 15;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ProductDAO productDAO = new ProductDAO();

        // Lấy các tham số từ request
        String[] categoryParams = request.getParameterValues("category");
        String priceRange = request.getParameter("priceRange");
        String keyword = request.getParameter("keyword");
        String sortBy = request.getParameter("sort");
        String pageParam = request.getParameter("page");

        // Chuyển đổi category IDs từ String sang Integer
        Integer[] categoryIds = null;
        if (categoryParams != null && categoryParams.length > 0) {
            categoryIds = new Integer[categoryParams.length];
            for (int i = 0; i < categoryParams.length; i++) {
                try {
                    categoryIds[i] = Integer.parseInt(categoryParams[i]);
                } catch (NumberFormatException e) {
                    categoryIds[i] = null;
                }
            }
        }

        // Chuyển mảng thành List để dễ kiểm tra trong JSP
        List<Integer> selectedCategoryList = new ArrayList<>();
        if (categoryIds != null) {
            for (Integer id : categoryIds) {
                if (id != null) {
                    selectedCategoryList.add(id);
                }
            }
        }
        request.setAttribute("selectedCategoryList", selectedCategoryList);

        // Xử lý phân trang
        int currentPage = 1;
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
                if (currentPage < 1) currentPage = 1;
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }

        // Tính toán offset (vị trí bắt đầu)
        int offset = (currentPage - 1) * ITEMS_PER_PAGE;

        try {
            // Đếm tổng số sản phẩm thỏa mãn điều kiện lọc
            int totalProducts = productDAO.countProductsWithFilters(categoryIds, priceRange, keyword);
            int totalPages = (int) Math.ceil((double) totalProducts / ITEMS_PER_PAGE);

            // Lấy danh sách sản phẩm theo trang
            List<Product> products = productDAO.getProductsWithFilters(
                    categoryIds, priceRange, keyword, sortBy, offset, ITEMS_PER_PAGE
            );

            // Lấy danh sách categories (cho sidebar)
            List<Category> categories = CategoryDAO.getAll();

            // Set attributes cho JSP
            request.setAttribute("products", products);
            request.setAttribute("categories", categories);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("itemsPerPage", ITEMS_PER_PAGE);

            // Giữ lại các filter values để hiển thị trên UI (giúp giữ trạng thái checkbox, input)
            request.setAttribute("selectedCategories", categoryParams);
            request.setAttribute("selectedPriceRange", priceRange);
            request.setAttribute("searchKeyword", keyword);
            request.setAttribute("selectedSort", sortBy != null ? sortBy : "default");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải sản phẩm!");
        }

        //  Forward sang shop.jsp
        request.getRequestDispatcher("/view/shop/shop.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}