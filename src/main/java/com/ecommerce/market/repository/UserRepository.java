package com.ecommerce.market.repository;

import java.sql.PreparedStatement;
import java.sql.Statement;

import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;

import com.ecommerce.market.entity.User;

@Repository
public class UserRepository {
    private final JdbcTemplate jdbcTemplate;

    public UserRepository(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    public User findByUsernameAndPassword(String username, String password) {
        try {
            String sql = "SELECT * FROM user WHERE username = ? AND password = ?";
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                return u;
            }, username, password);
        } catch (EmptyResultDataAccessException e) {
            return null; // User not found
        }
    }

    public User findByUsername(String username) {
        try {
            String sql = "SELECT * FROM user WHERE username = ?";
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                return u;
            }, username);
        } catch (EmptyResultDataAccessException e) {
            return null; // User not found
        }
    }

    public boolean existsByUsername(String username) {
        String sql = "SELECT COUNT(*) FROM user WHERE username = ?";
        Integer count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count != null && count > 0;
    }

    public User save(User user) {
        if (user.getId() == 0) {
            // Insert new user
            String sql = "INSERT INTO user (username, password) VALUES (?, ?)";
            KeyHolder keyHolder = new GeneratedKeyHolder();
            
            jdbcTemplate.update(connection -> {
                PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getPassword());
                return ps;
            }, keyHolder);
            
            // Set the generated ID
            Number generatedId = keyHolder.getKey();
            if (generatedId != null) {
                user.setId(generatedId.intValue());
            }
            
            return user;
        } else {
            // Update existing user
            String sql = "UPDATE user SET username = ?, password = ? WHERE id = ?";
            int rowsAffected = jdbcTemplate.update(sql, user.getUsername(), user.getPassword(), user.getId());
            return rowsAffected > 0 ? user : null;
        }
    }

    public User findById(int id) {
        try {
            String sql = "SELECT * FROM user WHERE id = ?";
            return jdbcTemplate.queryForObject(sql, (rs, rowNum) -> {
                User u = new User();
                u.setId(rs.getInt("id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                return u;
            }, id);
        } catch (EmptyResultDataAccessException e) {
            return null; // User not found
        }
    }

    public boolean deleteById(int id) {
        String sql = "DELETE FROM user WHERE id = ?";
        int rowsAffected = jdbcTemplate.update(sql, id);
        return rowsAffected > 0;
    }
}