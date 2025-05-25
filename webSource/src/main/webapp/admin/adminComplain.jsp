<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 5/15/2025
  Time: 1:27 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
  <title>Quản lý khiếu nại và hoàn tiền</title>
</head>
<body>
<style>
  .section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
  }
  .complaint-wrapper {
    background-color: #fff;
    padding: 20px;
    margin-bottom: 20px;
    box-shadow: 0 1px 5px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
  }

  .complaint-wrapper h2 {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 20px;
    flex-wrap: nowrap; /* ngăn xuống dòng */
  }

  .complaint-wrapper table {
    width: 100%;
    border-collapse: collapse;
  }

  .complaint-wrapper thead {
    background-color: #f5f6fa;
  }

  .complaint-wrapper th,
  .complaint-wrapper td {
    padding: 16px;
    text-align: left;
    font-size: 14px;
  }

  .complaint-wrapper th {
    color: #8f9bb3;
    font-weight: 600;
  }

  .complaint-wrapper td img {
    width: 40px;
    margin-right: 10px;
    vertical-align: middle;
  }

  .product-name {
    display: flex;
    align-items: center;
  }

  .status.pending {
    color: #ff9900;
  }

  .status.shipping {
    color: #007bff;
  }

  .status.refund {
    color: #ff6600;
  }

  .status.completed {
    color: #28a745;
  }

  .actions i {
    margin-right: 10px;
    cursor: pointer;
    color: #999;
  }

  .actions i:hover {
    color: #333;
  }

  .more {
    float: right;
    font-size: 14px;
    color: #888;
    cursor: pointer;
  }
  .more-link {
    color: gray;
    font-weight: bold;
    text-decoration: none;
    white-space: nowrap;
  }

  .more-link:hover {
    color: #7265ff;
  }
</style>
<div class="section-header">
  <h2 class="chart-title">Quản lý khiếu nại và hoàn tiền</h2>
  <a href="adminComplain.jsp" class="more-link">More →</a>
</div>



<table>
  <thead>
  <tr>
    <th>Products</th>
    <th>QTY</th>
    <th>Date</th>
    <th>Revenue</th>
    <th>Net Profit</th>
    <th>Status</th>
    <th>Actions</th>
  </tr>
  </thead>
  <tbody>
  <tr>
    <td class="product-name"><img src="../adminAssets/img/products/canon70d.jpg" alt=""> Canon 70D</td>
    <td>x1</td>
    <td>Feb 5, 2020</td>
    <td>$253.82</td>
    <td>$60.76</td>
    <td class="status pending">Pending</td>
    <td class="actions">
      <i class="edit">✏️</i>
      <i class="delete">🗑️</i>
      <i class="more">⋯</i>
    </td>
  </tr>
  <tr>
    <td class="product-name"><img src="../adminAssets/img/products/sonya6400.jpg" alt=""> Sony A6400</td>
    <td>x3</td>
    <td>Sep 8, 2020</td>
    <td>$556.24</td>
    <td>$66.41</td>
    <td class="status shipping">Shipping</td>
    <td class="actions">
      <i class="edit">✏️</i>
      <i class="delete">🗑️</i>
      <i class="more">⋯</i>
    </td>
  </tr>
  <tr>
    <td class="product-name"><img src="../adminAssets/img/products/Canon24.jpg" alt=""> Canon 24-70F4L IS USM</td>
    <td>x3</td>
    <td>Dec 21, 2020</td>
    <td>$115.26</td>
    <td>$95.66</td>
    <td class="status refund">Refund</td>
    <td class="actions">
      <i class="edit">✏️</i>
      <i class="delete">🗑️</i>
      <i class="more">⋯</i>
    </td>
  </tr>
  <tr>
    <td class="product-name"><img src="../adminAssets/img/products/canon70200.jpg" alt=""> Canon 70-200F2.8L</td>
    <td>x2</td>
    <td>Aug 13, 2020</td>
    <td>$675.51</td>
    <td>$84.80</td>
    <td class="status completed">Completed</td>
    <td class="actions">
      <i class="edit">✏️</i>
      <i class="delete">🗑️</i>
      <i class="more">⋯</i>
    </td>
  </tr>
  </tbody>
</table>

</body>
</html>

