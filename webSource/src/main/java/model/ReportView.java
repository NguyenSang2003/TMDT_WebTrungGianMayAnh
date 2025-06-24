package model;

import java.util.Date;

public class ReportView {
    private int id;
    private String productName;
    private String reporterName;
    private String reason;
    private Date createdAt;

    // Getter - Setter
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getReporterName() { return reporterName; }
    public void setReporterName(String reporterName) { this.reporterName = reporterName; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public Date getCreatedAt() { return createdAt; }
    public void setCreatedAt(Date createdAt) { this.createdAt = createdAt; }
}
