package DAO;

import database.JDBC;
import model.CustomerView;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    public List<CustomerView> getCustomerByOwnerId(int ownerId) {
        List<CustomerView> list = new ArrayList<>();

        String sql = "SELECT DISTINCT u.id AS user_id, u.username, u.email, " +
                "up.full_name, up.phone_number, up.address, up.id_card_number " +
                "FROM orders o " +
                "JOIN users u ON o.renter_id = u.id " +
                "LEFT JOIN user_profiles up ON u.id = up.user_id " +
                "WHERE o.owner_id = ?";

        try (Connection conn = JDBC.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CustomerView customer = new CustomerView();
                customer.setUserId(rs.getInt("user_id"));
                customer.setUsername(rs.getString("username"));
                customer.setEmail(rs.getString("email"));
                customer.setFullName(rs.getString("full_name"));
                customer.setPhoneNumber(rs.getString("phone_number"));
                customer.setAddress(rs.getString("address"));
                customer.setIdCardNumber(rs.getString("id_card_number"));
                list.add(customer);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
