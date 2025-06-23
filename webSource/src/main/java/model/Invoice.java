package model;

import java.sql.Timestamp;

public class Invoice {
    private int id;
    private int orderId;
    private Timestamp invoiceDate;
    private double totalAmount;
    private String paymentMethod;
    private String paymentStatus; // 'pending', 'paid', 'failed'

    public Invoice() {
    }

    public Invoice(int id, int orderId, Timestamp invoiceDate, double totalAmount, String paymentMethod, String paymentStatus) {
        this.id = id;
        this.orderId = orderId;
        this.invoiceDate = invoiceDate;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Timestamp getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Timestamp invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }
}