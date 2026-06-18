package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;

@WebServlet("/admin/admin-user-edit")
public class AdminUserEditServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() throws ServletException{
        userDAO= new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException{
        try{
            String paramId= request.getParameter("id");
            if(paramId == null || paramId.isEmpty()){
                response.sendRedirect(request.getContextPath()+ "/admin/admin-user");
                return;
            }

            int id= Integer.parseInt(paramId);
            User userToEdit= userDAO.getUserByIdForAdUserEdit(id);

            if (userToEdit == null){
                response.sendRedirect(request.getContextPath()+ "/admin/admin-user");
                return;
            }
            // Lấy thông tin đã lưu chuyển qua trang edit user
            request.setAttribute("userToEdit", userToEdit);
            request.getRequestDispatcher("/view/admin/admin-user-edit.jsp").forward(request, response);
        } catch (Exception e){
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi tải dữ liệu user");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        try {
            // Lấy thông tin từ form
            int id= Integer.parseInt(request.getParameter("id"));
            String fullName= request.getParameter("fullName");
            String userName= request.getParameter("userName");
            String email= request.getParameter("email");
            String phoneNumber= request.getParameter("phoneNumber");
            String address= request.getParameter("address");
            String role= request.getParameter("role");
            String status= request.getParameter("status");
            boolean isVerified= Boolean.parseBoolean(request.getParameter("isVerified"));
            String oauthProvider= request.getParameter("oauthProvider");

            // Lưu tạm vào user để khi trang tải lại không bị mất thông tin đã nhập
            User user= new User();
            user.setId(id);
            user.setFullName(fullName);
            user.setUserName(userName);
            user.setEmail(email);
            user.setPhoneNumber(phoneNumber);
            user.setAddress(address);
            user.setRole(role);
            user.setStatus(status);
            user.setVerified(isVerified);
            user.setOauthProvider(oauthProvider);

            String errorMsg= null;

            // Kiểm tra thông tin chỉnh sửa có hợp lệ không (ko cần check username vì login gg ko có username)
            if (fullName == null || fullName.trim().isEmpty()){
                errorMsg= "Họ tên không được thể trống!";
            } else if (phoneNumber != null && !phoneNumber.trim().isEmpty() && !phoneNumber.matches("^0\\d{9}$")) {
                errorMsg= "Số điện thoại phải bắt đầu bằng 0 và có 10 chữ số!";
            } else if (userDAO.isDuplicateUserOrEmail(userName, email, id)) {
                errorMsg= "Tên đăng nhập hoặc email đã trùng với người dùng khác!";
            }

            // Không đóng form khi có lỗi
            if (errorMsg != null){
                request.setAttribute("error", errorMsg);
                request.setAttribute("userToEdit", user);
                request.getRequestDispatcher("/view/admin/admin-user-edit.jsp").forward(request, response);
                return;
            }

            boolean isUpdate= userDAO.adminUserEdit(user);
            // Khi update thành công sẽ trở về admin-user và thông báo thành công
            if (isUpdate){
                HttpSession session= request.getSession();
                session.setAttribute("successMessage", "Cập nhật thông tin thành công!");
                response.sendRedirect((request.getContextPath()+ "/admin/admin-user"));
            } else {
                request.setAttribute("error", "Lỗi cập nhật hệ thống!");
                request.setAttribute("userToEdit", user);
                request.getRequestDispatcher("/view/admin/admin-user-edit.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
