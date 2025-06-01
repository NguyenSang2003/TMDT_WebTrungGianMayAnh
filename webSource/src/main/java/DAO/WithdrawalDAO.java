package DAO;

import database.JDBC;
import model.Withdrawal;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WithdrawalDAO {
    public List<Withdrawal> getWithdrawalsByOwner(int ownerId) {
        List<Withdrawal> list = new ArrayList<>();
        String sql = "SELECT * FROM withdrawals WHERE owner_id = ? ORDER BY created_at DESC";
        try (Connection conn = JDBC.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, ownerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Withdrawal w = new Withdrawal();
                w.setId(rs.getInt("id"));
                w.setOwnerId(rs.getInt("owner_id"));
                w.setAmount(rs.getDouble("amount"));
                w.setStatus(rs.getString("status"));
                w.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(w);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}