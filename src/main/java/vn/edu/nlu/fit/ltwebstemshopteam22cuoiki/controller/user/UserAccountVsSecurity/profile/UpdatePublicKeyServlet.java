package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.controller.user.UserAccountVsSecurity.profile;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao.UserKeyDAO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Scanner;

@WebServlet("/update-public-key")
@MultipartConfig(fileSizeThreshold = 1024 * 10, maxFileSize = 1024 * 50, maxRequestSize = 1024 * 100)
public class UpdatePublicKeyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) { //check login
            resp.sendRedirect(req.getContextPath() + "/dang-nhap");
            return;
        }
        //Ngăn không cho thêm key khi đã có
        UserKeyDAO userKeyDAO = new UserKeyDAO();
        if (userKeyDAO.hasActiveKey(user.getId())) {
            session.setAttribute("errorPublicKey", "Phải thu hồi khóa hiện tại trước!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }
        String publicKey = "";
        try {
            Part filePart = req.getPart("publicKeyFile");
            if (filePart != null && filePart.getSize() > 0) {
                InputStream is = filePart.getInputStream();
                try (Scanner sc = new Scanner(is, StandardCharsets.UTF_8)) {
                    // Đọc toàn bộ nội dung file thành string
                    publicKey = sc.useDelimiter("\\A").hasNext() ? sc.next() : "";
                }
            } else {
                publicKey = req.getParameter("publicKeyText");
            }
            if (publicKey != null) publicKey = publicKey.trim();

        } catch (Exception e) {
            session.setAttribute("errorPublicKey", "show");
            session.setAttribute("error", "Lỗi không thể đọc file đính kèm");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        if(publicKey == null || publicKey.isEmpty()) {
            session.setAttribute("errorPublicKey", "show");
            session.setAttribute("error", "Lỗi để trống key! ");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        if(userKeyDAO.isKeyAlreadyExist(user.getId(), publicKey)) {
            session.setAttribute("errorPublicKey", "show");
            session.setAttribute("error", "Khóa này đã từng được bạn sử dụng!");
            resp.sendRedirect(req.getContextPath() + "/profile");
            return;
        }

        try {
            boolean success = userKeyDAO.insertNewKey(user.getId(), publicKey);
            if(success) {
                session.setAttribute("message", "Cập nhật public key thành công");
            } else {
                session.setAttribute("errorPublicKey", "Lỗi hệ thống, hãy thử lại");
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        resp.sendRedirect(req.getContextPath() + "/profile");
    }
}
