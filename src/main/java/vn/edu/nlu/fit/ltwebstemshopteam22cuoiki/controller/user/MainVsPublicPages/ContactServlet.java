package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.MainVsPublicPages;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.ContactDao;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Contact;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.EmailUtils;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/view/main/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        // Lấy dl từ form
        String fullName = request.getParameter("fullName");
        String customerEmail = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // nội dung email gửi cho Admin
        String adminEmail = "stemshop.system@gmail.com";
        String emailTitle = "[Liên hệ từ Khách hàng] " + subject;
        String emailBody = "<div style='font-family: Arial; line-height: 1.6;'>"
                + "<h2 style='color: #E91E63;'>Có một liên hệ mới từ STEM Shop</h2>"
                + "<p><strong>Họ và tên:</strong> " + fullName + "</p>"
                + "<p><strong>Email:</strong> " + customerEmail + "</p>"
                + "<p><strong>Chủ đề:</strong> " + subject + "</p>"
                + "<hr>"
                + "<p><strong>Nội dung tin nhắn:</strong></p>"
                + "<p style='background: #f9f9f9; padding: 15px; border-radius: 5px;'>" + message.replace("\n", "<br>") + "</p>"
                + "</div>";

        try {
            // gửi mail
            boolean isSent = EmailUtils.sendHtmlEmail(adminEmail, emailTitle, emailBody);

            if (isSent) {
                request.setAttribute("message", "Cảm ơn bạn! Tin nhắn đã được gửi thành công. Chúng tôi sẽ phản hồi sớm nhất.");
            } else {
                request.setAttribute("error", "Hệ thống đang bận. Vui lòng thử lại sau.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi gửi tin nhắn.");
        }

        request.getRequestDispatcher("/view/main/contact.jsp").forward(request, response);
    }
}
