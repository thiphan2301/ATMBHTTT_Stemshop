package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class ConnectionDB {
    //private static final String URL = "jdbc:mysql://mysql:3306/mystemshop?useSSL=false&serverTimezone=UTC";
    private static final String URL = "jdbc:mysql://localhost:3306/mystemshop?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    //private static final String PASSWORD = "StemShop@2026!Secure";
    private static final String PASSWORD = "";


    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
