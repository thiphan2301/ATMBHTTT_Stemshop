package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {
    // Mã hóa
    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    // Kiểm tra mật khẩu
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        if (hashedPassword == null || hashedPassword.isEmpty()) {
            return false;
        }
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}