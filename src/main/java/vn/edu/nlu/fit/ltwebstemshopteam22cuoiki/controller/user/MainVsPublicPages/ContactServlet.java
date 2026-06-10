//package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.MainVsPublicPages;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ContactDao;
//import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Contact;
//import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.EmailUtils;
//
//import java.io.IOException;
//
//@WebServlet("/contact")
//public class ContactServlet extends HttpServlet {
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//
//    }
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        request.setCharacterEncoding("UTF-8");
//
//        Contact c = new Contact();
//        c.setFullName(request.getParameter("fullName"));
//        c.setEmail(request.getParameter("email"));
//        c.setSubject(request.getParameter("subject"));
//        c.setMessage(request.getParameter("message"));
//
//        // check validate
//        String fullName = request.getParameter("fullName");
//        String email = request.getParameter("email");
//        String subject = request.getParameter("subject");
//        String message = request.getParameter("message");
//        if (fullName == null || fullName.trim().isEmpty()) {
//            request.setAttribute("error", "Vui lòng nhập họ tên");
//        } else if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[A-Za-z]{2,6}$")) {
//            request.setAttribute("error", "Email không hợp lệ");
//        } else if (message == null || message.trim().length() < 10) {
//            request.setAttribute("error", "Nội dung phải ít nhất 10 ký tự");
//        }
//
//        if (request.getAttribute("error") != null) {
//            request.getRequestDispatcher("/view/main/contact.jsp").forward(request, response);
//            return;
//        }
//
//        ContactDao dao = new ContactDao();
//        boolean success = dao.insert(c);
//
//        if (success) {
//            // gửi mail xác nhận
//            EmailUtils.sendContactSuccessEmail(
//                    c.getEmail(),
//                    c.getFullName(),
//                    c.getSubject()
//            );
//
//            request.setAttribute("message",
//                    "Gửi liên hệ thành công! Chúng tôi sẽ phản hồi sớm nhất.");
//        } else {
//            request.setAttribute("error", "Gửi liên hệ thất bại!");
//        }
//
//        request.getRequestDispatcher("/view/main/contact.jsp").forward(request, response);
//    }
//}
