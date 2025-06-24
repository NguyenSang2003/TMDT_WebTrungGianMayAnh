package model;

import java.math.BigDecimal;
import java.sql.Timestamp;


public class WithdrawalView {
    private int orderId;
    private int ownerId;
    private String productName;
    private int quantity;
    private BigDecimal amount;
    private String paymentMethod;
    private Timestamp createdAt;

    public WithdrawalView() {}

    public WithdrawalView(int orderId, int ownerId, String productName, int quantity,
                          BigDecimal amount, String paymentMethod, Timestamp createdAt) {
        this.orderId = orderId;
        this.ownerId = ownerId;
        this.productName = productName;
        this.quantity = quantity;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.createdAt = createdAt;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
