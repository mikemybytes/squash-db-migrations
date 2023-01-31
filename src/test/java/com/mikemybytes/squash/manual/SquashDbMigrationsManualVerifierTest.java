package com.mikemybytes.squash.manual;

import com.mikemybytes.squash.DbMigrationsVerifier;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@Testcontainers
class SquashDbMigrationsManualVerifierTest {

    @Container
    @SuppressWarnings("rawtypes")
    private static final PostgreSQLContainer postgres =
            (PostgreSQLContainer) new PostgreSQLContainer(DockerImageName.parse("postgres:15.1"))
                    .withInitScript("init.sql");

    @DynamicPropertySource
    static void registerPgProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Autowired
    DbMigrationsVerifier dbMigrationsVerifier;

    @Test
    void allMigrationsApplied() {
        // You may not need this test in real life. Here, we just want to prove that all
        // the migrations have been applied.
        boolean allMigrationsApplied = dbMigrationsVerifier.allMigrationsApplied();
        assertThat(allMigrationsApplied).isTrue();
    }

}
