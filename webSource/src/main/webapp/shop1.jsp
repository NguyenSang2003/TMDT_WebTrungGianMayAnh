<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cửa hàng</title>

  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; }
    a { text-decoration: none; color: inherit; }
    header { background: #fff; padding: 10px 20px; display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #ddd; }
    .logo { font-size: 1.5rem; font-weight: bold; }
    nav ul { list-style: none; display: flex; gap: 15px; }
    nav ul li { padding: 5px 0; }
    .auth { display: flex; gap: 15px; }
    .auth a { padding: 5px 10px; border: 1px solid #333; border-radius: 4px; }
    .container { max-width: 1200px; margin: 20px auto; padding: 0 20px; }
    h1.section-title { text-align: center; font-size: 2rem; border-bottom: 4px solid #333; display: inline-block; margin-bottom: 20px; }
    .search-bar { display: flex; justify-content: center; margin-bottom: 30px; }
    .search-bar input { width: 50%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; }
    .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }
    .product-card { background: #fff; border: 1px solid #eee; border-radius: 8px; overflow: hidden; text-align: center; padding: 15px; position: relative; }
    .product-card img { max-width: 100%; height: auto; }
    .product-info { margin-top: 10px; }
    .product-info h3 { font-size: 1rem; margin-bottom: 5px; }
    .price { color: #e63946; font-weight: bold; margin-bottom: 5px; }
    .category { font-size: 0.9rem; color: #555; margin-bottom: 8px; }
    .rating { font-size: 0.9rem; color: #f4c430; margin-bottom: 8px; }
    .cart-btn { position: absolute; top: 10px; right: 10px; background: #fff; border: none; cursor: pointer; }
    .pagination { display: flex; justify-content: center; margin: 30px 0; }
    .pagination button { padding: 8px 12px; margin: 0 5px; border: 1px solid #333; background: #fff; cursor: pointer; border-radius: 4px; }
    .pagination button.active { background: #333; color: #fff; }
    footer { background: #111; color: #ccc; padding: 40px 20px; }
    .footer-container { max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; }
    .footer-section h4 { color: #fff; margin-bottom: 15px; }
    .footer-section ul { list-style: none; }
    .footer-section ul li { margin-bottom: 10px; }
    .social-icons { display: flex; gap: 10px; margin-top: 15px; }
    .social-icons a { color: #ccc; font-size: 1.2rem; }
  </style>
</head>
<body>
<header>
  <div class="logo">EagleCam</div>
  <nav>
    <ul>
      <li><a href="#">Trang chủ</a></li>
      <li><a href="#">Cửa hàng</a></li>
      <li><a href="#">Giỏ hàng</a></li>
      <li><a href="#">Blog</a></li>
      <li><a href="#">Về chúng tôi</a></li>
      <li><a href="#">Liên hệ</a></li>
    </ul>
  </nav>
  <div class="auth">
    <a href="#">Đăng nhập</a>
    <a href="#">Đăng ký</a>
  </div>
</header>
<main class="container">
  <h1 class="section-title">Cửa hàng</h1>
  <div class="search-bar">
    <input type="text" placeholder="Nhập từ khóa tìm kiếm...">
  </div>
  <div class="products-grid">
    <!-- Lặp card sản phẩm -->
    <div class="product-card">
      <button class="cart-btn">🛒</button>
      <img src="https://via.placeholder.com/250x200" alt="Sản phẩm">
      <div class="product-info">
        <h3>Sony FX3 Full-Frame Cinema Camera</h3>
        <div class="price">1,000,000 đ/ngày</div>
        <div class="category">Máy ảnh</div>
        <div class="rating">★★★★★</div>
      </div>
    </div>
    <!-- Thêm các card tương tự -->
  </div>
  <div class="pagination">
    <button>&lt;</button>
    <button class="active">1</button>
    <button>2</button>
    <button>3</button>
    <button>&gt;</button>
  </div>
</main>
<footer>
  <div class="footer-container">
    <div class="footer-section">
      <h4>Về EagleCam</h4>
      <p>EagleCam là đơn vị cho thuê thiết bị hình ảnh chuyên nghiệp, mang đến dịch vụ chất lượng và uy tín cho khách hàng.</p>
    </div>
    <div class="footer-section">
      <h4>Hỗ trợ</h4>
      <ul>
        <li><a href="#">Câu hỏi thường gặp</a></li>
        <li><a href="#">Chính sách bảo hành</a></li>
        <li><a href="#">Hướng dẫn thanh toán</a></li>
      </ul>
    </div>
    <div class="footer-section">
      <h4>Liên hệ</h4>
      <ul>
        <li>Email: support@eaglecam.vn</li>
        <li>Hotline: 0123 456 789</li>
        <li>Địa chỉ: 123 Đ. Trần Phú, Hà Nội</li>
      </ul>
      <div class="social-icons">
        <a href="#">&#xF09A;</a>
        <a href="#">&#xF16D;</a>
        <a href="#">&#xF167;</a>
      </div>
    </div>
  </div>
</footer>
</body>
</html>
