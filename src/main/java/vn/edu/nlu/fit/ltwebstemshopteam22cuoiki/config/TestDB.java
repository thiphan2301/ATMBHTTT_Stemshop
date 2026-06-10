package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config;

public class TestDB {
    public static void main(String[] args) {
        try {
            var conn = ConnectionDB.getConnection();
            System.out.println("Kết nối CSDL thành công!");
            conn.close();
        } catch (Exception e) {
            System.out.println("Kết nối thất bại: " + e.getMessage());
        }
    }
}