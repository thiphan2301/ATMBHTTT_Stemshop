package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

// tự động đọc đường dẫn từ file system.properties lên khi web vừa khởi động
public class AppConfig {
    public static String AVATAR_UPLOAD_DIR;

    static {
        try (InputStream input = AppConfig.class.getClassLoader().getResourceAsStream("system.properties")) {
            Properties prop = new Properties();
            if (input != null) {
                prop.load(input);
                AVATAR_UPLOAD_DIR = prop.getProperty("upload.avatar.dir");
                System.out.println("DEBUG: Thư mục lưu Avatar đang dùng là: " + AVATAR_UPLOAD_DIR);
            }
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}