package model;

import java.sql.Timestamp;

public class Comment {
    private int id;
    private int orderId;
    private String commenterName;
    private String productName;
    private String comment;
    private Timestamp createdAt;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public String getCommenterName() { return commenterName; }
    public void setCommenterName(String commenterName) { this.commenterName = commenterName; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}