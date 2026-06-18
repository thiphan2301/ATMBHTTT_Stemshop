package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ImportHistory {

    private Integer importId;
    private Integer productId;
    private Integer batchId;
    private Integer quantity;
    private BigDecimal importPrice;
    private LocalDateTime importDate;
    private String note;

    // ==========================================
    // CONSTRUCTORS
    // ==========================================
    public ImportHistory() {
    }

    public ImportHistory(Integer importId, Integer productId, Integer batchId, 
                         Integer quantity, BigDecimal importPrice, LocalDateTime importDate, 
                         String note) {
        this.importId = importId;
        this.productId = productId;
        this.batchId = batchId;
        this.quantity = quantity;
        this.importPrice = importPrice;
        this.importDate = importDate;
        this.note = note;
    }

    // ==========================================
    // GETTERS & SETTERS
    // ==========================================
    public Integer getImportId() { return importId; }
    public void setImportId(Integer importId) { this.importId = importId; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public Integer getBatchId() { return batchId; }
    public void setBatchId(Integer batchId) { this.batchId = batchId; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }

    public BigDecimal getImportPrice() { return importPrice; }
    public void setImportPrice(BigDecimal importPrice) { this.importPrice = importPrice; }

    public LocalDateTime getImportDate() { return importDate; }
    public void setImportDate(LocalDateTime importDate) { this.importDate = importDate; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}