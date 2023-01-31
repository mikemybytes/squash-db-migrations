package com.mikemybytes.squash.manual;

import com.mikemybytes.squash.InitSqlUpdater;
import com.mikemybytes.squash.PostgresDumper;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.DynamicPropertyRegistry;
import org.springframework.test.context.DynamicPropertySource;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.junit.jupiter.Container;
import org.testcontainers.junit.jupiter.Testcontainers;
import org.testcontainers.utility.DockerImageName;

// This test should only be enabled on demand, when new DB snapshot has to be created.
// You may want to replace @Disabled with other form of conditional execution (e.g. using system property).
@Disabled
@SpringBootTest
@Testcontainers
class SquashDbMigrationsManualContainerManagementTest {

    // This approach would look very similar for the singleton containers
    // https://www.testcontainers.org/test_framework_integration/manual_lifecycle_control/#singleton-containers

    @Container
    @SuppressWarnings("rawtypes")
    private static final PostgreSQLContainer postgres =
            new PostgreSQLContainer(DockerImageName.parse("postgres:15.1"));

    @DynamicPropertySource
    static void registerPgProperties(DynamicPropertyRegistry registry) {
        registry.add("spring.datasource.url", postgres::getJdbcUrl);
        registry.add("spring.datasource.username", postgres::getUsername);
        registry.add("spring.datasource.password", postgres::getPassword);
    }

    @Test
    void squashDbMigrations() {
        var dump = PostgresDumper.dump(
                postgres.getContainerId(),
                postgres.getDatabaseName(),
                postgres.getUsername(),
                postgres.getPassword()
        );

        InitSqlUpdater.write(dump);
    }

}
