package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

public class Category {
    private int id;
    private String categoryName;

    public Category() {}

    public Category(int id, String categoryName) {
        this.id = id;
        this.categoryName = categoryName;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
}