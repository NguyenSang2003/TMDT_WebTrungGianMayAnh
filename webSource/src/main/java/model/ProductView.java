package model;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.*;

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
    private double rating;
    private String imageUrl; // từ product_details.image_url
    private String category; // từ product_details.category
    private String formattedPricePerDay;
    private Date rentStart;
    private Date rentEnd;
    private String brand;

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

    public double getRating() {
        return rating;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getFormattedPricePerDay() {
        return formattedPricePerDay;
    }

    public void setFormattedPricePerDay(String formattedPricePerDay) { this.formattedPricePerDay = formattedPricePerDay; }

    public Date getRentStart() { return rentStart; }

    public void setRentStart(Date rentStart) { this.rentStart = rentStart; }

    public Date getRentEnd() { return rentEnd; }

    public void setRentEnd(Date rentEnd) { this.rentEnd = rentEnd; }

    private List<BookingSchedule> bookingSchedules;

    public List<BookingSchedule> getBookingSchedules() {
        return bookingSchedules;
    }

    public void setBookingSchedules(List<BookingSchedule> bookingSchedules) {
        this.bookingSchedules = bookingSchedules;
        updateRentPeriod(); // cập nhật rentStart và rentEnd ngay khi có bookingSchedules mới
    }

    public void updateRentPeriod() {
        if (bookingSchedules != null && !bookingSchedules.isEmpty()) {
            this.rentStart = bookingSchedules.stream()
                    .map(BookingSchedule::getRentStart)
                    .min(Date::compareTo)
                    .orElse(null);
            this.rentEnd = bookingSchedules.stream()
                    .map(BookingSchedule::getRentEnd)
                    .max(Date::compareTo)
                    .orElse(null);
        } else {
            this.rentStart = null;
            this.rentEnd = null;
        }
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }
}