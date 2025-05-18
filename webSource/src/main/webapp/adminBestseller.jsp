<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Bestsellers</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background: #f5f7fa;
        }

        .card {
            background: #ffffff;
            border-radius: 12px;
            padding: 16px;
            width: 100%;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.06);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 14px;
            font-weight: bold;
            margin-bottom: 12px;
        }

        .card-header span:last-child {
            color: #5e72e4;
            font-weight: normal;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead th {
            font-size: 12px;
            color: #7d879c;
            padding-bottom: 6px;
            text-align: left;
        }

        tbody tr {
            border-top: 1px solid #f0f0f0;
        }

        td {
            padding: 8px 0;
            font-size: 13px;
        }

        .product-cell {
            display: flex;
            align-items: center;
            gap: 6px;
            white-space: nowrap;
        }

        .product-img {
            width: 20px;
            height: 20px;
            object-fit: cover;
            border-radius: 4px;
        }

        .product-name {
            font-weight: 500;
            color: #333;
            font-size: 13px;
        }

        /* Giảm padding để tránh bị bó */
        th, td {
            padding-right: 8px;
        }
    </style>
</head>
<body>


<div class="card">
    <div class="card-header">
        <span>Bestsellers</span>
        <span>More →</span>
    </div>

    <table>
        <thead>
        <tr>
            <th>Product</th>
            <th>Profit</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td class="product-cell">
                <img src="adminAssets/img/products/canon70d.jpg" class="product-img" alt="">
                <span class="product-name">700D</span>
            </td>
            <td>$1822</td>
        </tr>
        <tr>
            <td class="product-cell">
                <img src="adminAssets/img/products/sonya6400.jpg" class="product-img" alt="">
                <span class="product-name">A6400</span>
            </td>
            <td>$8545</td>
        </tr>
        <tr>
            <td class="product-cell">
                <img src="adminAssets/img/products/Canon24.jpg" class="product-img" alt="">
                <span class="product-name">D610</span>
            </td>
            <td>$7287</td>
        </tr>
        <tr>
            <td class="product-cell">
                <img src="adminAssets/img/products/canon70200.jpg" class="product-img" alt="">
                <span class="product-name">A7C</span>
            </td>
            <td>$9325</td>
        </tr>
        </tbody>
    </table>
</div>


</body>
</html>
