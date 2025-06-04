package model;

public class OrderView {
    private Order order;
    private OrderItems orderItem;
    private Product product;
    private String imageUrl;

    public OrderView(Order order, OrderItems orderItem, String imageUrl, Product product) {
        this.order = order;
        this.orderItem = orderItem;
        this.imageUrl = imageUrl;
        this.product = product;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public OrderItems getOrderItem() {
        return orderItem;
    }

    public void setOrderItem(OrderItems orderItem) {
        this.orderItem = orderItem;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
}