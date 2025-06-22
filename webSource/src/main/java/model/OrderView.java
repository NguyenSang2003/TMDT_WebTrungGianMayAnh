package model;

import java.util.List;

public class OrderView {
    private Order order;
    private List<OrderItems> items;
    private List<Product> products;
    private List<String> imageUrls;

    // Constructor đầy đủ:
    public OrderView(Order order, List<OrderItems> items, List<Product> products, List<String> imageUrls) {
        this.order = order;
        this.items = items;
        this.products = products;
        this.imageUrls = imageUrls;
    }

    // getter setter
    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public List<OrderItems> getItems() {
        return items;
    }

    public void setItems(List<OrderItems> items) {
        this.items = items;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }

    public List<String> getImageUrls() {
        return imageUrls;
    }

    public void setImageUrls(List<String> imageUrls) {
        this.imageUrls = imageUrls;
    }
}