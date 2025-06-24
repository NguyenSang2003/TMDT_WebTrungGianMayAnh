package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

// lớp join 2 bảng product và product_detail lại để view
public class ProductView {
    private int id;
    private int userId;
    private String name;
    private BigDecimal pricePerDay;
    private int quantity;
    private String status;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private int viewCount;
    private int soldCount;
    private String imageUrl; // từ product_details.image_url
    private String formattedPricePerDay;
    private String brand;
    private String category;
    private int isActive;         // 0 = ẩn, 1 = hiện

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public BigDecimal getPricePerDay() {
        return pricePerDay;
    }

    public void setPricePerDay(BigDecimal pricePerDay) {
        this.pricePerDay = pricePerDay;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public int getViewCount() {
        return viewCount;
    }

    public void setViewCount(int viewCount) {
        this.viewCount = viewCount;
    }

    public int getSoldCount() {
        return soldCount;
    }

    public void setSoldCount(int soldCount) {
        this.soldCount = soldCount;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getFormattedPricePerDay() {
        return formattedPricePerDay;
    }

    public void setFormattedPricePerDay(String formattedPricePerDay) {
        this.formattedPricePerDay = formattedPricePerDay;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setRating(double rating) {
    }

    public int getIsActive() { return isActive; }
    public void setIsActive(int isActive) { this.isActive = isActive; }

    }
