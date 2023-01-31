package com.mikemybytes.squash;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

@Service
public class DbMigrationsVerifier {

    private final JdbcTemplate jdbcTemplate;

    public DbMigrationsVerifier(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    /**
     * Checks whether all the DB migrations have been applied based on certain criteria.
     * These checks are based on point-in-time knowledge of the migrations state and have
     * been introduced only for presentation purposes. You probably won't need a similar
     * method in your project.
     */
    public boolean allMigrationsApplied() {
        return countOrderItems() == 12 && countMigrationsApplied() == 7;
    }

    private int countOrderItems() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM order_item", Integer.class);
    }

    private int countMigrationsApplied() {
        return jdbcTemplate.queryForObject("SELECT COUNT(*) FROM flyway_schema_history", Integer.class);
    }

}
