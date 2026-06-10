package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

public class ProductImage {
    private int id;
    private int productid;
    private String imageUrl;

    public ProductImage() {
    }

    public ProductImage(int id, int productid, String imageUrl) {
        this.id = id;
        this.productid = productid;
        this.imageUrl = imageUrl;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProductid() {
        return productid;
    }

    public void setProductid(int productid) {
        this.productid = productid;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}
