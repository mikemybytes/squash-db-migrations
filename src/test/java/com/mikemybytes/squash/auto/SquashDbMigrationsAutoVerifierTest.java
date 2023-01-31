package com.mikemybytes.squash.auto;

import com.mikemybytes.squash.DbMigrationsVerifier;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest(properties = {
        "spring.datasource.url=jdbc:tc:postgresql:15.1:///test?TC_INITSCRIPT=init.sql"
})
class SquashDbMigrationsAutoVerifierTest {

    @Autowired
    DbMigrationsVerifier dbMigrationsVerifier;

    @Test
    void allMigrationsApplied() {
        // You may not need this test in real life. Here, we just want to prove that all
        // the migrations have been successfully applied.
        boolean allMigrationsApplied = dbMigrationsVerifier.allMigrationsApplied();
        assertThat(allMigrationsApplied).isTrue();
    }

}
