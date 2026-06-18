package vn.edu.nlu.fit.ltwebstemshopteam22cuoiki.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class ProductBatch {

    private Integer batchId;
    private Integer productId;
    private BigDecimal importPrice;
    private Integer initialQuantity;
    private Integer usableQuantity;
    private LocalDateTime importDate;
    private String batchStatus;
    private LocalDateTime damagedDate;
    private String note;

    // ==========================================
    // CONSTRUCTORS
    // ==========================================
    public ProductBatch() {
        this.batchStatus = "AVAILABLE"; // Gán giá trị mặc định giống SQL
    }

    public ProductBatch(Integer batchId, Integer productId, BigDecimal importPrice, 
                        Integer initialQuantity, Integer usableQuantity, LocalDateTime importDate, 
                        String batchStatus, LocalDateTime damagedDate, String note) {
        this.batchId = batchId;
        this.productId = productId;
        this.importPrice = importPrice;
        this.initialQuantity = initialQuantity;
        this.usableQuantity = usableQuantity;
        this.importDate = importDate;
        this.batchStatus = batchStatus;
        this.damagedDate = damagedDate;
        this.note = note;
    }

    // ==========================================
    // GETTERS & SETTERS
    // ==========================================
    public Integer getBatchId() { return batchId; }
    public void setBatchId(Integer batchId) { this.batchId = batchId; }

    public Integer getProductId() { return productId; }
    public void setProductId(Integer productId) { this.productId = productId; }

    public BigDecimal getImportPrice() { return importPrice; }
    public void setImportPrice(BigDecimal importPrice) { this.importPrice = importPrice; }

    public Integer getInitialQuantity() { return initialQuantity; }
    public void setInitialQuantity(Integer initialQuantity) { this.initialQuantity = initialQuantity; }

    public Integer getUsableQuantity() { return usableQuantity; }
    public void setUsableQuantity(Integer usableQuantity) { this.usableQuantity = usableQuantity; }

    public LocalDateTime getImportDate() { return importDate; }
    public void setImportDate(LocalDateTime importDate) { this.importDate = importDate; }

    public String getBatchStatus() { return batchStatus; }
    public void setBatchStatus(String batchStatus) { this.batchStatus = batchStatus; }

    public LocalDateTime getDamagedDate() { return damagedDate; }
    public void setDamagedDate(LocalDateTime damagedDate) { this.damagedDate = damagedDate; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}