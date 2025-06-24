package model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

public class OrderListView {

    private int id;
    private String renterName;
    private BigDecimal totalPrice;
    private Date rentStart;
    private Date rentEnd;
    private String status;
    private Timestamp createdAt;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRenterName() {
        return renterName;
    }

    public void setRenterName(String renterName) {
        this.renterName = renterName;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
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

    /**
     * Trả về trạng thái tiếng Việt hiển thị ngoài giao diện
     */
    public String getStatusDisplay() {
        if (status == null) return "";
        switch (status) {
            case "cho_duyet":
                return "Chờ duyệt";
            case "dang_thue":
                return "Đang thuê";
            case "hoan_thanh":
                return "Hoàn thành";
            case "huy":
                return "Đã hủy";
            default:
                return "";
        }
    }
}
