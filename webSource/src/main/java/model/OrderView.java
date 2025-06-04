package model;

public class OrderView {
    private Order order;
    private Product product;
    private String imageUrl;

    public OrderView(Order o, String imageUrl, Product product) {
        this.order = o;
        this.imageUrl = imageUrl;
        this.product = product;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
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
