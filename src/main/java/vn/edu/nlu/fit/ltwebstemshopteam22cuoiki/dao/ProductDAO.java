package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.dao;

import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.config.ConnectionDB;
import vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    public List<Product> getAll() {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, b.BrandName, " +
                "(SELECT ImageURL FROM product_image WHERE ProductID = p.ID AND is_main = 1 LIMIT 1) AS image_url " +
                "FROM products p LEFT JOIN brands b ON p.BrandID = b.ID " +
                "WHERE p.status = 1";
        try (
                Connection con = ConnectionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();
        ) {
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setCategoriesID(rs.getInt("CategoryID"));
                p.setBrandID(rs.getInt("BrandID"));
                p.setBrandName(rs.getString("BrandName"));
                p.setProductName(rs.getString("ProductName"));
                p.setDescription(rs.getString("Description"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setImageUrl(rs.getString("image_url"));

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public Product findByIdWithImage(int id) {
        Product p = null;

        // Lấy thông tin cơ bản và ảnh chính
        String sqlProduct = "SELECT p.*, b.BrandName, " +
                "(SELECT ImageURL FROM product_image WHERE ProductID = p.ID AND is_main = 1 LIMIT 1) AS image_url " +
                "FROM products p LEFT JOIN brands b ON p.BrandID = b.ID " +
                "WHERE p.ID = ?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sqlProduct)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                p = new Product();
                p.setId(rs.getInt("ID"));
                p.setCategoriesID(rs.getInt("CategoryID"));
                p.setBrandID(rs.getInt("BrandID"));
                p.setBrandName(rs.getString("BrandName"));
                p.setProductName(rs.getString("ProductName"));
                p.setDescription(rs.getString("Description"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));

                String img = rs.getString("image_url");
                p.setImageUrl(img != null ? img : "assets/images/no-image.png");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Lấy các ảnh phụ (is_main = 0)
        if (p != null) {
            String sqlImages = "SELECT ImageURL FROM product_image WHERE ProductID = ? AND is_main = 0";
            try (Connection con = ConnectionDB.getConnection();
                 PreparedStatement ps = con.prepareStatement(sqlImages)) {

                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                List<String> subs = new ArrayList<>();

                while (rs.next()) {
                    subs.add(rs.getString("ImageURL"));
                }
                p.setSubImages(subs); // Gắn danh sách ảnh phụ vào đối tượng Product

            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return p;
    }

    // hàm lấy thông tin của một sản phẩm theo id
    public Product findById(int id) {
        String sql = "SELECT * FROM products WHERE ID = ?";
        try (
                Connection con = ConnectionDB.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setCategoriesID(rs.getInt("CategoryID"));
                p.setBrandID(rs.getInt("BrandID"));
                p.setProductName(rs.getString("ProductName"));
                p.setDescription(rs.getString("Description"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                return p;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    // Xóa sản phẩm
    public boolean deleteProduct(int id) {
        String sql = "DELETE FROM products WHERE ID=?";
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Cập nhật sản phẩm
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET ProductName=?, Description=?, Price=?, Quantity=?, CategoryID=?, BrandID=? WHERE ID=?";
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setInt(5, product.getCategoriesID());
            ps.setInt(6, product.getBrandID());
            ps.setInt(7, product.getId());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }


     // Thêm sản phẩm mới, sau đó sẽ trả về id
    public int addProduct(Product product) {
        String sql = "INSERT INTO products (ProductName, Description, Price, Quantity, CategoryID, BrandID) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setInt(5, product.getCategoriesID());
            ps.setInt(6, product.getBrandID());
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {

                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    // Lấy toàn bộ sản phẩm và thương hiệu
    public List<Product> getAllWithBrand() {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT p.*, b.BrandName, "+
                "(SELECT pi.ImageURL FROM product_image pi WHERE pi.ProductID = p.ID ORDER BY pi.ID ASC LIMIT 1) AS imageUrl "+
                "FROM products p "+
                "JOIN brands b ON p.BrandID = b.ID "+
                "WHERE p.status = 1 "+
                "ORDER BY p.ID DESC";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageUrl(rs.getString("imageUrl"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    // Tìm sản phẩm theo tên
    public List<Product> searchByName(String keyword) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.*, b.BrandName, "+
        "(SELECT ImageURL FROM product_image WHERE ProductID = p.ID LIMIT 1) AS imageUrl "+
        "FROM products p "+
        "JOIN brands b ON p.BrandID = b.ID "+
        "WHERE p.ProductName LIKE ?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getDouble("Price"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageUrl(rs.getString("imageUrl"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Xóa sản phẩm (chỉ ẩn nó đi, default là 1 nghĩa là sp vẫn còn đang đươcj bán, set lại 0 nghĩa là sp ko còn bán nữa)
    public void deleteById(int id) {
        String sql = "UPDATE products SET status = 0 WHERE ID = ?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // thêm mới 1 sp
    // Thêm sản phẩm mới và trả về ID vừa insert
    public int insertProduct(Product product) {
        String sql = "INSERT INTO products " +
                "(ProductName, Description, Price, Quantity, CategoryID, BrandID, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, 1)";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setDouble(3, product.getPrice());
            ps.setInt(4, product.getQuantity());
            ps.setInt(5, product.getCategoriesID());
            ps.setInt(6, product.getBrandID());

            ps.executeUpdate();

            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // productId vừa tạo
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    // Đếm tổng số sản phẩm
    public int countProducts() {
        String sql = "SELECT COUNT(*) FROM products";
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) return rs.getInt(1);

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy sản phẩm theo trang
    public List<Product> getProductsByPage(int offset, int limit) {
        List<Product> list = new ArrayList<>();

        String sql ="SELECT p.ID, p.ProductName, p.Price, p.CategoryID, p.BrandID, "+
                "(SELECT ImageURL FROM product_image WHERE ProductID = p.ID LIMIT 1) AS image_url "+
                "FROM products p "+
                "WHERE p.status = 1 "+
                "ORDER BY p.ID "+
                "LIMIT ? OFFSET ?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, limit);
            ps.setInt(2, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getDouble("Price"));
                p.setCategoriesID(rs.getInt("CategoryID"));
                p.setBrandID(rs.getInt("BrandID"));
                p.setImageUrl(rs.getString("image_url"));

                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    //  CÁC PHƯƠNG THỨC MỚI CHO LỌC, TÌM KIẾM, SẮP XẾP, PHÂN TRANG

    //Đếm tổng số sản phẩm thỏa mãn điều kiện lọc
    public int countProductsWithFilters(Integer[] categoryIds, String priceRange, String keyword) {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM products p WHERE p.status = 1");
        List<Object> params = new ArrayList<>();

        // Thêm điều kiện lọc danh mục
        if (categoryIds != null && categoryIds.length > 0) {
            sql.append(" AND p.CategoryID IN (");
            for (int i = 0; i < categoryIds.length; i++) {
                sql.append("?");
                if (i < categoryIds.length - 1) sql.append(",");
            }
            sql.append(")");
            for (Integer id : categoryIds) {
                params.add(id);
            }
        }

        // Thêm điều kiện lọc giá
        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "duoi200":
                    sql.append(" AND p.Price < 200000");
                    break;
                case "200-1tr":
                    sql.append(" AND p.Price BETWEEN 200000 AND 1000000");
                    break;
                case "1tr-2tr":
                    sql.append(" AND p.Price BETWEEN 1000000 AND 2000000");
                    break;
                case "2tr-4tr":
                    sql.append(" AND p.Price BETWEEN 2000000 AND 4000000");
                    break;
                case "tren4tr":
                    sql.append(" AND p.Price > 4000000");
                    break;
            }
        }

        // Thêm điều kiện tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND LOWER(p.ProductName) LIKE LOWER(?)");
            params.add("%" + keyword.trim() + "%");
        }

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

     //Lấy danh sách sản phẩm có phân trang, lọc, tìm kiếm, sắp xếp

    public List<Product> getProductsWithFilters(Integer[] categoryIds, String priceRange,
                                                String keyword, String sortBy,
                                                int offset, int limit) {
        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();

        sql.append("SELECT p.ID, p.ProductName, p.Price, p.CategoryID, p.BrandID, p.Description, p.Quantity, ");
        sql.append("b.BrandName, ");
        sql.append("(SELECT ImageURL FROM product_image WHERE ProductID = p.ID AND is_main = 1 LIMIT 1) AS image_url ");
        sql.append("FROM products p ");
        sql.append("LEFT JOIN brands b ON p.BrandID = b.ID ");
        sql.append("WHERE p.status = 1");

        List<Object> params = new ArrayList<>();

        // Lọc danh mục
        if (categoryIds != null && categoryIds.length > 0) {
            sql.append(" AND p.CategoryID IN (");
            for (int i = 0; i < categoryIds.length; i++) {
                sql.append("?");
                if (i < categoryIds.length - 1) sql.append(",");
            }
            sql.append(")");
            for (Integer id : categoryIds) {
                params.add(id);
            }
        }

        // Lọc giá
        if (priceRange != null && !priceRange.isEmpty()) {
            switch (priceRange) {
                case "duoi200":
                    sql.append(" AND p.Price < 200000");
                    break;
                case "200-1tr":
                    sql.append(" AND p.Price BETWEEN 200000 AND 1000000");
                    break;
                case "1tr-2tr":
                    sql.append(" AND p.Price BETWEEN 1000000 AND 2000000");
                    break;
                case "2tr-4tr":
                    sql.append(" AND p.Price BETWEEN 2000000 AND 4000000");
                    break;
                case "tren4tr":
                    sql.append(" AND p.Price > 4000000");
                    break;
            }
        }

        // Tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND LOWER(p.ProductName) LIKE LOWER(?)");
            params.add("%" + keyword.trim() + "%");
        }

        // Sắp xếp
        if (sortBy != null && !sortBy.isEmpty()) {
            switch (sortBy) {
                case "az":
                    sql.append(" ORDER BY p.ProductName ASC");
                    break;
                case "za":
                    sql.append(" ORDER BY p.ProductName DESC");
                    break;
                case "price-asc":
                    sql.append(" ORDER BY p.Price ASC");
                    break;
                case "price-desc":
                    sql.append(" ORDER BY p.Price DESC");
                    break;
                default:
                    sql.append(" ORDER BY p.ID DESC");
            }
        } else {
            sql.append(" ORDER BY p.ID DESC");
        }

        // Phân trang
        sql.append(" LIMIT ? OFFSET ?");
        params.add(limit);
        params.add(offset);

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getDouble("Price"));
                p.setCategoriesID(rs.getInt("CategoryID"));
                p.setBrandID(rs.getInt("BrandID"));
                p.setBrandName(rs.getString("BrandName"));
                p.setDescription(rs.getString("Description"));
                p.setQuantity(rs.getInt("Quantity"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    //Lấy danh sách sản phẩm cho shop (có filter, sort, phân trang) - Phương thức tiện lợi hơn

    public List<Product> getShopProducts(Integer[] categoryIds, String priceRange,
                                         String keyword, String sortBy,
                                         int page, int itemsPerPage) {
        int offset = (page - 1) * itemsPerPage;
        return getProductsWithFilters(categoryIds, priceRange, keyword, sortBy, offset, itemsPerPage);
    }

    //Lấy danh sách sản phẩm theo category ID (có phân trang)
    public List<Product> getProductsByCategory(int categoryId, int offset, int limit) {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT p.ID, p.ProductName, p.Price, p.CategoryID, p.BrandID, " +
                "b.BrandName, " +
                "(SELECT ImageURL FROM product_image WHERE ProductID = p.ID AND is_main = 1 LIMIT 1) AS image_url " +
                "FROM products p " +
                "LEFT JOIN brands b ON p.BrandID = b.ID " +
                "WHERE p.status = 1 AND p.CategoryID = ? " +
                "ORDER BY p.ID DESC " +
                "LIMIT ? OFFSET ?";

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, limit);
            ps.setInt(3, offset);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getDouble("Price"));
                p.setCategoriesID(rs.getInt("CategoryID"));
                p.setBrandID(rs.getInt("BrandID"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    //Đếm sản phẩm theo category
    public int countProductsByCategory(int categoryId) {
        String sql = "SELECT COUNT(*) FROM products p WHERE p.status = 1 AND p.CategoryID = ?";
        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    //Lọc sản phẩm theo nhiều category (có phân trang)
    public List<Product> getProductsByMultipleCategories(Integer[] categoryIds, int offset, int limit) {
        if (categoryIds == null || categoryIds.length == 0) {
            return getProductsByPage(offset, limit);
        }

        List<Product> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT p.ID, p.ProductName, p.Price, p.CategoryID, p.BrandID, ");
        sql.append("b.BrandName, ");
        sql.append("(SELECT ImageURL FROM product_image WHERE ProductID = p.ID AND is_main = 1 LIMIT 1) AS image_url ");
        sql.append("FROM products p ");
        sql.append("LEFT JOIN brands b ON p.BrandID = b.ID ");
        sql.append("WHERE p.status = 1 AND p.CategoryID IN (");

        for (int i = 0; i < categoryIds.length; i++) {
            sql.append("?");
            if (i < categoryIds.length - 1) sql.append(",");
        }
        sql.append(") ORDER BY p.ID DESC LIMIT ? OFFSET ?");

        try (Connection con = ConnectionDB.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {

            for (int i = 0; i < categoryIds.length; i++) {
                ps.setInt(i + 1, categoryIds[i]);
            }
            ps.setInt(categoryIds.length + 1, limit);
            ps.setInt(categoryIds.length + 2, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product();
                p.setId(rs.getInt("ID"));
                p.setProductName(rs.getString("ProductName"));
                p.setPrice(rs.getDouble("Price"));
                p.setCategoriesID(rs.getInt("CategoryID"));
                p.setBrandID(rs.getInt("BrandID"));
                p.setBrandName(rs.getString("BrandName"));
                p.setImageUrl(rs.getString("image_url"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
