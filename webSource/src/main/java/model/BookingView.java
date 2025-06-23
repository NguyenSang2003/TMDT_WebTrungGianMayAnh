package model;

import java.sql.Date;

public class BookingView {
    private int id;
    private String productName;
    private String renterName;
    private Date rentStart;
    private Date rentEnd;
    private String status;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getRenterName() { return renterName; }
    public void setRenterName(String renterName) { this.renterName = renterName; }

    public Date getRentStart() { return rentStart; }
    public void setRentStart(Date rentStart) { this.rentStart = rentStart; }

    public Date getRentEnd() { return rentEnd; }
    public void setRentEnd(Date rentEnd) { this.rentEnd = rentEnd; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getStatusLabel() {
        if ("cho_duyet".equals(status)) {
            return "Chờ duyệt";
        } else if ("xac_nhan".equals(status)) {
            return "Xác nhận";
        } else if ("huy".equals(status)) {
            return "Đã hủy";
        }
        return status;
    }

    public boolean isStatusEditable() {
        return "xac_nhan".equals(status);
    }
}
