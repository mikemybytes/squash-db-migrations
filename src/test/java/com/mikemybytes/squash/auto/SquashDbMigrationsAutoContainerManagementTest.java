package com.mikemybytes.squash.auto;

import com.github.dockerjava.api.model.Container;
import com.mikemybytes.squash.InitSqlUpdater;
import com.mikemybytes.squash.PostgresDumper;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;
import org.testcontainers.DockerClientFactory;
import org.testcontainers.containers.PostgreSQLContainer;
import org.testcontainers.utility.DockerImageName;

import static org.assertj.core.api.Assertions.assertThat;

// This test should only be enabled on demand, when new DB snapshot has to be created.
// You may want to replace @Disabled with other form of conditional execution (e.g. using system property).
@Disabled
@SpringBootTest(properties = {
        "spring.datasource.url=jdbc:tc:postgresql:15.1:///test"
})
class SquashDbMigrationsAutoContainerManagementTest {

    @Test
    void squashDbMigrations() {
        var postgresDefault = new PostgreSQLContainer(DockerImageName.parse("postgres:15.1"));

        var dump = PostgresDumper.dump(
                findPostgresContainerId(),
                postgresDefault.getDatabaseName(),
                postgresDefault.getUsername(),
                postgresDefault.getPassword()
        );

        InitSqlUpdater.write(dump);
    }

    private String findPostgresContainerId() {
        var dockerClient = DockerClientFactory.instance().client();
        var postgresContainers = dockerClient.listContainersCmd().exec()
                .stream()
                .filter(this::isTestContainersPostgres)
                .toList();
        assertThat(postgresContainers).hasSize(1);

        return postgresContainers.get(0).getId();
    }

    private boolean isTestContainersPostgres(Container container) {
        // you can do more if needed (like matching on the exposed port)
        return container.toString().contains("postgres")
                && "true".equals(container.labels.get("org.testcontainers"));
    }

}
