package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.admin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/admin-user")
public class UserManagementServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Lấy danh sách
            List<User> users = userDAO.getAllUsers();
            request.setAttribute("users", users);

            request.getRequestDispatcher("/view/admin/admin-user.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Có lỗi");
        }
        
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            //Thao tác update (admin)
            if ("update".equals(action)) {
                // Lấy thông tin từ form
                User user = new User();
                user.setId(Integer.parseInt(request.getParameter("id")));
                user.setFullName(request.getParameter("fullName"));
                user.setEmail(request.getParameter("email"));
                user.setPhoneNumber(request.getParameter("phoneNumber"));
                user.setAddress(request.getParameter("address"));
                user.setRole(request.getParameter("role"));
                user.setStatus(request.getParameter("status"));
                user.setUserName(request.getParameter("userName"));

                userDAO.updateUser(user);
            }else if ("editUser".equals(action)) { // thao tác cập nhật tk người dùng (amdin)
                // Sửa: Nhận ID và cập nhật trực tiếp quyền/trạng thái qua DAO
                String paramId = request.getParameter("id");
                int id = Integer.parseInt(paramId);

                User user = new User();
                user.setId(id);
                user.setRole(request.getParameter("role"));
                user.setStatus(request.getParameter("active"));

                // Gọi DAO để cập nhật
                userDAO.updateUser(user);

            } else if ("updateUserStatus".equals(action)) { // thao tác đổi trạng người dùng ACTIVE hoặc BLOCK (admin)
                String paramId = request.getParameter("id");
                String currentStatus = request.getParameter("status");

                if (paramId!=null && currentStatus!= null){
                    int id= Integer.parseInt(paramId);

                    // Dùng nextStatus để điều khiển đảo nhau của 2 trạng thái
                    String nextStatus= "ACTIVE".equalsIgnoreCase(currentStatus)? "LOCKED": "ACTIVE";
                    userDAO.updateUserStatus(id, nextStatus);
                }
            } else if ("adminEditUser".equalsIgnoreCase(action)) {  //thao tác admin chỉnh sửa thông tin người dùng
                String paramId= request.getParameter("id");
                int id= Integer.parseInt(paramId);

                // Admin có thể chỉnh sửa gồm:
                // Họ tên, Username, Email, Số điện thoại, Địa chỉ, Vai trò, Trạng thái
                User user= new User();
                user.setFullName(request.getParameter("fullName"));
                user.setUserName(request.getParameter("userName"));
                user.setEmail(request.getParameter("email"));
                user.setAddress(request.getParameter("address"));
                user.setPhoneNumber(request.getParameter("phoneNumber"));
                user.setRole(request.getParameter("role"));
                user.setStatus(request.getParameter("status"));

                userDAO.adminEditUser(user);
            }
            response.sendRedirect(request.getContextPath() + "/admin/admin-user");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Có lỗi ");
        }
    }


}
