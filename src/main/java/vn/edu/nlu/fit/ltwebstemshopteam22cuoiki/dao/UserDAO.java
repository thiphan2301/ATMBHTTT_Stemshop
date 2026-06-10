package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;


import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.GoogleUserDTO;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.User;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.utils.PasswordUtils;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.TimeUnit;

public class UserDAO {
    //Lấy danh sác user
    public List<User> getAllUsers() {
        List<User> Users = new ArrayList<>();
        String sql = "SELECT * FROM users";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = ConnectionDB.getConnection();
            ps = con.prepareStatement(sql);
            rs =  ps.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("ID"));
                u.setFullName(rs.getString("FullName"));
                u.setEmail(rs.getString("Email"));
                u.setUserName(rs.getString("UserName"));
                u.setPhoneNumber(rs.getString("PhoneNumber"));
                u.setRole(rs.getString("Role"));
                u.setStatus(rs.getString("Status"));

                Users.add(u);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return Users;
    }

    // lấy ra 1 user
    public User login(String username, String password) {
        String sql = "SELECT * FROM users WHERE UserName=? AND Password=? AND IsVerified=1";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("ID"));
                u.setUserName(rs.getString("UserName"));
                u.setFullName(rs.getString("FullName"));
                u.setEmail(rs.getString("Email"));
                u.setPhoneNumber(rs.getString("PhoneNumber"));
                u.setRole(rs.getString("Role"));

               u.setGender(rs.getString("gender"));
              u.setBirthday(rs.getDate("birthday"));
              u.setAddress(rs.getString("Address"));
               u.setAvatar(rs.getString("avatar"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    //  -------------------------Đăng ký----------------------
    // Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) throws Exception {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    // Tạo user mới và trả về token (hoặc null nếu thất bại)
    public String createUser(User user) throws Exception {
        String sql = "INSERT INTO users (UserName, Email, Password, VerifyToken, token_expiry) VALUES (?, ?, ?, ?, ?)";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            String hashedPassword = PasswordUtils.hashPassword(user.getPassword());
            String verificationToken = UUID.randomUUID().toString();
            Date expiry = new Date(System.currentTimeMillis() + TimeUnit.HOURS.toMillis(24)); // 24 giờ

            stmt.setString(1, user.getUserName());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, hashedPassword);
            stmt.setString(4, verificationToken);
            stmt.setTimestamp(5, new Timestamp(expiry.getTime()));

            int result = stmt.executeUpdate();
            if (result > 0) {
                return verificationToken;  // Trả về token để gửi email
            }
            return null;
        }
    }

    // Lấy user theo token (để xác thực email)
    public User getUserByVerificationToken(String token) throws Exception {
        String sql = "SELECT * FROM users WHERE VerifyToken = ? AND token_expiry > NOW()";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setUserName(rs.getString("UserName"));
                user.setEmail(rs.getString("Email"));
                user.setVerified(rs.getBoolean("IsVerified"));
                return user;
            }
            return null;
        }
    }

    // Cập nhật token mới cho email
    public boolean updateVerificationToken(String email, String newToken, java.util.Date expiry) throws Exception{
        String sql = "UPDATE users SET VerifyToken = ?, token_expiry = ?, IsVerified = 0 WHERE Email = ?";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, newToken);
            stmt.setTimestamp(2, new Timestamp(expiry.getTime()));
            stmt.setString(3, email);

            return stmt.executeUpdate() > 0;
        }
    }

    // Xác thực email thành công
    public boolean verifyEmail(String token) throws Exception {
        String sql = "UPDATE users SET IsVerified = True, VerifyToken = NULL WHERE VerifyToken = ? AND token_expiry > NOW()";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            return stmt.executeUpdate() > 0;
        }
    }

     // Tìm user theo username hoặc email
    public User findByUsernameOrEmail(String usernameOrEmail) throws Exception {
        String sql = "SELECT * FROM users WHERE UserName = ? OR Email = ?";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, usernameOrEmail);
            stmt.setString(2, usernameOrEmail);

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("ID"));
                user.setUserName(rs.getString("UserName"));
                user.setFullName(rs.getString("FullName"));
                user.setEmail(rs.getString("Email"));
                user.setPassword(rs.getString("Password"));  // Lấy password đã hash
                user.setPhoneNumber(rs.getString("PhoneNumber"));
                user.setRole(rs.getString("Role"));
                user.setStatus(rs.getString("Status"));
                user.setVerified(rs.getBoolean("IsVerified"));
                user.setAvatar(rs.getString("avatar"));
                return user;
            }
            return null;
        }
    }

    // ------------------------------------Quên pass--------------------------------
    // Kiểm tra username và email có khớp với tài khoản không
    public boolean checkUserCredentials(String username, String email) throws Exception {
        String sql = "SELECT id FROM users WHERE UserName = ? AND Email = ?";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    // Lưu token reset mật khẩu vào bảng password_resets
    public boolean saveResetToken(String email, String token) throws Exception {
        // Không cần truyền expiry, để MySQL tự tính UTC_TIMESTAMP + 1 hour
        String sql = "INSERT INTO password_resets (email, token, expiry) VALUES (?, ?, UTC_TIMESTAMP() + INTERVAL 1 HOUR)";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, token);
            return stmt.executeUpdate() > 0;
        }
    }

    // Kiểm tra token có hợp lệ không (tồn tại, chưa hết hạn, chưa dùng)
    public String getEmailByResetToken(String token) throws Exception {
        String sql = "SELECT email FROM password_resets WHERE token = ? AND expiry > UTC_TIMESTAMP() AND used = FALSE";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("email");
            }
            return null;
        }
    }

    // Đánh dấu token đã được sử dụng
    public void markTokenAsUsed(String token) throws Exception {
        String sql = "UPDATE password_resets SET used = TRUE WHERE token = ?";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, token);
            stmt.executeUpdate();
        }
    }

    // Cập nhật mật khẩu mới theo email
    public boolean updatePasswordByEmail(String email, String hashedPassword) throws Exception {
        String sql = "UPDATE users SET Password = ? WHERE Email = ?";

        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hashedPassword);
            stmt.setString(2, email);
            return stmt.executeUpdate() > 0;
        }
    }

    // 2 Phương thức này ở admin - quan ly
    // Sửa
    public void updateUser(User user) {
        String sql = "UPDATE users SET FullName=?, Email=?, PhoneNumber=?, Address=?, Role=?, Status=?, UserName=? WHERE ID=?";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPhoneNumber());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getRole());
            ps.setString(6, user.getStatus());
            ps.setString(7, user.getUserName());
            ps.setInt(8, user.getId());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    //Cập nhật trạng thái tài khoản (ACTIVE/LOCKED)
    public boolean updateUserStatus(int userId, String nextStatus) {
        String sql = "UPDATE users SET Status=? WHERE ID=?";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps= conn.prepareStatement(sql)) {

            ps.setString(1, nextStatus); //ACTIVE hoặc LOCKED
            ps.setInt(2, userId);

            return ps.executeUpdate()>0;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }



    // lấy user bằng id
    public User getUserById(int userId) {
        String sql = "SELECT * FROM users WHERE ID=?";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("ID"));
                u.setFullName(rs.getString("FullName"));
                u.setEmail(rs.getString("Email"));
                u.setPhoneNumber(rs.getString("PhoneNumber"));
                u.setAddress(rs.getString("Address"));
                u.setUserName(rs.getString("UserName"));
                u.setRole(rs.getString("Role"));
                u.setStatus(rs.getString("Status"));
                u.setCreateDate(rs.getDate("CreateAt"));
                u.setAvatar(rs.getString("avatar"));
                u.setVerified(rs.getBoolean("IsVerified"));
                u.setOauthProvider(rs.getString("oauth_provider"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    // check username và email
    public User findByUsernameAndEmail(String username, String email) {
        String sql = "SELECT * FROM users WHERE UserName=? AND Email=?";
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, email);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUserName(rs.getString("username"));
                u.setEmail(rs.getString("email"));
                return u;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    // update profile
    public boolean updateProfile(User user) {
        String sql = "UPDATE users SET FullName = ?, PhoneNumber = ?, gender = ?, birthday = ?, avatar = ?, Address = ? WHERE id=?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getPhoneNumber());
            ps.setString(3, user.getGender());
            ps.setDate(4, user.getBirthday());
            ps.setString(5, user.getAvatar());
            ps.setString(6, user.getAddress());
            ps.setInt(7, user.getId());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


    //lấy số lượng user
    public int countUsers() {
        String sql = "SELECT COUNT(*) FROM users";
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    public User loginWithGoogle(GoogleUserDTO googleUser) {
        User user = getUserByEmail(googleUser.getEmail());

        if (user == null) {
            // Nếu chưa có, INSERT mới (Password để null vì login qua Google)
            String sql = "INSERT INTO users (FullName, Email, Role, Status, avatar, isVerified) VALUES (?, ?, 'USER', 'ACTIVE', ?, 1)";
            try (Connection conn = ConnectionDB.getConnection();
                 PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, googleUser.getName());
                ps.setString(2, googleUser.getEmail());
                ps.setString(3, googleUser.getPicture());
                ps.executeUpdate();
                return getUserByEmail(googleUser.getEmail());
            } catch (Exception e) { e.printStackTrace(); }
        }
        return user;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM users WHERE Email = ?";
        try (Connection conn = ConnectionDB.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setId(rs.getInt("ID"));
                u.setFullName(rs.getString("FullName"));
                u.setEmail(rs.getString("Email"));
                u.setRole(rs.getString("Role"));
                u.setStatus(rs.getString("Status"));
                u.setAvatar(rs.getString("avatar"));
                return u;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }
}