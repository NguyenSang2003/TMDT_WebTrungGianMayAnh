package model;

import java.math.BigDecimal;
import java.sql.Date;

public class RevenueReportView {
    private int productId;
    private String productName;
    private BigDecimal totalRevenue;
    private int totalOrders;
    private int quantity;
    private Date rentDate;

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public BigDecimal getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(BigDecimal totalRevenue) { this.totalRevenue = totalRevenue; }

    public int getTotalOrders() { return totalOrders; }
    public void setTotalOrders(int totalOrders) { this.totalOrders = totalOrders; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Date getRentDate() { return rentDate; }
    public void setRentDate(Date rentDate) { this.rentDate = rentDate; }
}
