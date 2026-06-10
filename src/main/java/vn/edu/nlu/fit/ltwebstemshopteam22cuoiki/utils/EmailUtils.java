package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

import java.io.InputStream;
import java.util.Properties;

public class EmailUtils {

    private static Properties emailConfig = new Properties();

    // Load cấu hình email từ file
    static {
        try (InputStream input = EmailUtils.class.getClassLoader()
                .getResourceAsStream("email.properties")) {
            if (input == null) {
                System.err.println("Không tìm thấy file email.properties");
            } else {
                emailConfig.load(input);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * Gửi email xác thực tài khoản
     * @param toEmail Email người nhận
     * @param token Token xác thực (UUID)
     */
    public static boolean sendVerificationEmail(String toEmail, String token) {
        try {
            // Cấu hình SMTP
            Properties props = new Properties();
            props.put("mail.smtp.host", emailConfig.getProperty("mail.smtp.host"));
            props.put("mail.smtp.port", emailConfig.getProperty("mail.smtp.port"));
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            // Tạo session với xác thực
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            emailConfig.getProperty("mail.from"),
                            emailConfig.getProperty("mail.password")
                    );
                }
            });

            // Tạo email
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailConfig.getProperty("mail.from")));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Xác thực tài khoản StemShop");

            // Nội dung HTML
            String baseUrl = emailConfig.getProperty("app.base.url");
            String verifyLink = baseUrl + "/xac-thuc?token=" + token;

            String htmlContent = """
                <!DOCTYPE html>
                <html>
                <head><meta charset='UTF-8'></head>
                <body style='font-family: Arial, sans-serif;'>
                    <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>
                        <h2 style='color: #2c3e50;'>Xác thực tài khoản StemShop</h2>
                        <p>Chào mừng bạn đến với StemShop!</p>
                        <p>Vui lòng click vào link bên dưới để kích hoạt tài khoản của bạn:</p>
                        <p><a href='%s' style='display: inline-block; padding: 10px 20px; background: #3498db; color: white; text-decoration: none; border-radius: 5px;'>Xác thực tài khoản</a></p>
                        <p>Hoặc copy link này vào trình duyệt:<br>%s</p>
                        <p>Link có hiệu lực trong vòng 24 giờ.</p>
                        <hr>
                        <p style='color: #7f8c8d; font-size: 12px;'>Nếu bạn không đăng ký tài khoản, vui lòng bỏ qua email này.</p>
                    </div>
                </body>
                </html>
                """.formatted(verifyLink, verifyLink);

            message.setContent(htmlContent, "text/html; charset=UTF-8");

            // Gửi email
            Transport.send(message);
            System.out.println("Email xác thực đã gửi đến: " + toEmail);
            return true;

        } catch (Exception e) {
            System.err.println("Lỗi gửi email: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Gửi email xác nhận liên hệ thành công đến người dùng
     * @param toEmail Email người nhận
     * @param fullName Tên người dùng
     * @param subject Chủ đề liên hệ
     */
    public static boolean sendContactSuccessEmail(String toEmail, String fullName, String subject) {
        try {
            // Cấu hình SMTP
            Properties props = new Properties();
            props.put("mail.smtp.host", emailConfig.getProperty("mail.smtp.host"));
            props.put("mail.smtp.port", emailConfig.getProperty("mail.smtp.port"));
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            emailConfig.getProperty("mail.from"),
                            emailConfig.getProperty("mail.password")
                    );
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailConfig.getProperty("mail.from")));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Xác nhận liên hệ - StemShop");

            String htmlContent = """
            <!DOCTYPE html>
            <html>
            <head><meta charset='UTF-8'></head>
            <body style='font-family: Arial, sans-serif;'>
                <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>
                    <h2 style='color: #2c3e50;'>Xác nhận liên hệ</h2>
                    <p>Chào <strong>%s</strong>,</p>
                    <p>Cảm ơn bạn đã liên hệ với StemShop.</p>
                    <p>Chúng tôi đã nhận được câu hỏi của bạn với chủ đề: <strong>%s</strong></p>
                    <p>Chúng tôi sẽ phản hồi trong thời gian sớm nhất (24-48h).</p>
                    <hr>
                    <p style='color: #7f8c8d; font-size: 12px;'>Đây là email tự động, vui lòng không trả lời.</p>
                </div>
            </body>
            </html>
            """.formatted(fullName, subject);

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);

            System.out.println("Email xác nhận liên hệ đã gửi đến: " + toEmail);
            return true;

        } catch (Exception e) {
            System.err.println("Lỗi gửi email xác nhận: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Gửi email đặt lại mật khẩu
     * @param toEmail Email người nhận
     * @param username Tên người dùng
     * @param token Token đặt lại mật khẩu
     */
    public static boolean sendResetPasswordEmail(String toEmail, String username, String token) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", emailConfig.getProperty("mail.smtp.host"));
            props.put("mail.smtp.port", emailConfig.getProperty("mail.smtp.port"));
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");

            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            emailConfig.getProperty("mail.from"),
                            emailConfig.getProperty("mail.password")
                    );
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(emailConfig.getProperty("mail.from")));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(toEmail));
            message.setSubject("Đặt lại mật khẩu - StemShop");

            String baseUrl = emailConfig.getProperty("app.base.url");
            String resetLink = baseUrl + "/dat-lai-mat-khau?token=" + token;

            String htmlContent = """
            <!DOCTYPE html>
            <html>
            <head><meta charset='UTF-8'></head>
            <body style='font-family: Arial, sans-serif;'>
                <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>
                    <h2 style='color: #2c3e50;'>Đặt lại mật khẩu</h2>
                    <p>Xin chào <strong>%s</strong>,</p>
                    <p>Chúng tôi nhận được yêu cầu đặt lại mật khẩu cho tài khoản của bạn.</p>
                    <p>Vui lòng click vào link bên dưới để tạo mật khẩu mới:</p>
                    <p><a href='%s' style='display: inline-block; padding: 10px 20px; background: #e67e22; color: white; text-decoration: none; border-radius: 5px;'>Đặt lại mật khẩu</a></p>
                    <p>Hoặc copy link này vào trình duyệt:<br>%s</p>
                    <p><strong>Link có hiệu lực trong vòng 1 giờ.</strong></p>
                    <hr>
                    <p style='color: #7f8c8d; font-size: 12px;'>Nếu bạn không yêu cầu đặt lại mật khẩu, vui lòng bỏ qua email này.</p>
                </div>
            </body>
            </html>
            """.formatted(username, resetLink, resetLink);

            message.setContent(htmlContent, "text/html; charset=UTF-8");
            Transport.send(message);

            System.out.println("Email đặt lại mật khẩu đã gửi đến: " + toEmail);
            return true;

        } catch (Exception e) {
            System.err.println("Lỗi gửi email reset mật khẩu: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

}