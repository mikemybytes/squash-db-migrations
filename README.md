# Squashing DB migrations using Testcontainers

This project illustrates the approach described in my [article](https://mikemybytes.com/2023/02/01/squashing-db-migrations-using-testcontainers/), 
which allows squashing (compacting) database migrations into a single file using [Testcontainers](https://www.testcontainers.org/).
This can result in a reduced test execution time in certain cases.

The example project uses:
- [Spring Boot 3](https://spring.io/projects/spring-boot),
- [Flyway](https://flywaydb.org/) migrations,
- [PostgreSQL](https://www.postgresql.org/),
- [Testcontainers](https://www.testcontainers.org/).

Yet, the approach should look rather similar with different framework and databases.

## Building sources

The project uses Maven as its build tool, so it's enough to run:
```
./mvnw clean verify
```

## Familiarizing with the code

**I recommend reading [the article](https://mikemybytes.com/2023/02/01/squashing-db-migrations-using-testcontainers/) before digging into the code.**

There are three classes that could be used as a good entry points:
- [SquashDbMigrationsManualContainerManagementTest](src/test/java/com/mikemybytes/squash/manual/SquashDbMigrationsManualContainerManagementTest.java) using
    manual DB container setup via [JDBC URL scheme](https://www.testcontainers.org/modules/databases/jdbc/).
- [SquashDbMigrationsAutoContainerManagementTest](src/test/java/com/mikemybytes/squash/auto/SquashDbMigrationsAutoContainerManagementTest.java) using
    automated DB container setup via [JDBC URL scheme](https://www.testcontainers.org/modules/databases/jdbc/).
- [PostgresDumper](src/test/java/com/mikemybytes/squash/PostgresDumper.java) dumping DB schema of a running container
    into a set of SQL statements.

Database migrations can be found within the [db.migration](src/main/resources/db/migration) directory.

The output of squashing procedure is stored within the [init.sql](src/test/resources/init.sql) file.
