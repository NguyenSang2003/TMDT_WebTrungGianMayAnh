package model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class Order {
    private int id;
    private int renterId;
    private int ownerId;
    private double totalPrice;
    private String status; // 'cho_duyet', 'dang_thue', 'hoan_thanh', 'huy'
    private Date rentStart;
    private Date rentEnd;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private List<OrderItems> orderItems; // dùng để load danh sách chi tiết từng sản phẩm

    // getter setter
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRenterId() {
        return renterId;
    }

    public void setRenterId(int renterId) {
        this.renterId = renterId;
    }

    public int getOwnerId() {
        return ownerId;
    }

    public void setOwnerId(int ownerId) {
        this.ownerId = ownerId;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getRentStart() {
        return rentStart;
    }

    public void setRentStart(Date rentStart) {
        this.rentStart = rentStart;
    }

    public Date getRentEnd() {
        return rentEnd;
    }

    public void setRentEnd(Date rentEnd) {
        this.rentEnd = rentEnd;
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

    public List<OrderItems> getOrderItems() {
        return orderItems;
    }

    public void setOrderItems(List<OrderItems> orderItems) {
        this.orderItems = orderItems;
    }

    // Phương thức chuyển đổi trạng thái sang dạng hiển thị bằng tiếng Việt:
    public String getDisplayStatus() {
        if (status == null) {
            return "";
        }
        switch (status) {
            case "cho_duyet":
                return "Chờ duyệt";
            case "dang_thue":
                return "Đang thuê";
            case "hoan_thanh":
                return "Hoàn thành";
            case "huy":
                return "Hủy";
            default:
                return status;
        }
    }
}
