package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.ProductInteraction;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ReviewDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Reviews;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebServlet("/add-review")
public class AddReviewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =  request.getSession();
        // check xem người dùng đã đăng nhập chưa, nếu chưa chuyển sang trang đăng nhập luôn
        if(session == null || session.getAttribute("user") == null){
            response.sendRedirect(request.getContextPath() + "/view/user/sign-in.jsp");
            return;
        }
        User user  = (User)session.getAttribute("user");

        try{
            int productId = Integer.parseInt(request.getParameter("productId"));
            String comment  = request.getParameter("comment");
            //không nên chuyển ratting về double vội gì khi dl tưf client gửi qua là String mà
            //nếu người dùng chỉ comment mà không rating thì lúc này nó "" mà mình add kiểu sang double
            //thì sẽ lỗi
            String ratingStr = request.getParameter("rating");
            double rating = 5; //cho mặc định đánh giá 5 sao nếu người dùng chỉ comment
            if(ratingStr != null && !ratingStr.isEmpty()){
                rating = Double.parseDouble(ratingStr);
            }

            Reviews r = new Reviews();
            r.setUserID(user.getId());
            r.setProductID(productId);
            r.setRating(rating);
            r.setComment(comment);

            boolean isSuccess = ReviewDAO.addReview(r);
            if(isSuccess){
                System.out.println("Thêm đánh giá thành công");
            }else{
                System.out.println("Thêm sản phẩm thất bại, kiểm tra lại ReviewDAO");
            }

            //quay lại trang chi tiết sp rồi load lại danh sách review
            response.sendRedirect(request.getContextPath() + "/product-detail?id=" + productId);
        }catch(Exception e){
            e.printStackTrace();
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}