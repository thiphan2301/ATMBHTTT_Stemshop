package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.test;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;

import java.sql.Connection;

public class TestConnection {
    public static void main(String[] args) {
        try {
            Connection conn = ConnectionDB.getConnection();
            System.out.println("KẾT NỐI MYSQL THÀNH CÔNG!");
            conn.close();
        } catch (Exception e) {
            System.out.println("Lỗi không kết nối được");
        }
    }
}
