package com.mikemybytes.squash;

import org.testcontainers.DockerClientFactory;
import org.testcontainers.containers.output.FrameConsumerResultCallback;
import org.testcontainers.containers.output.OutputFrame;
import org.testcontainers.containers.output.ToStringConsumer;

import java.time.LocalDateTime;
import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

public class PostgresDumper {

    private PostgresDumper() {
        // static only
    }

    /**
     * Dumps the content of a DB running in a Docker container.
     *
     * @param postgresContainerId Docker container ID
     * @param dbName              Name of the DB to be dumped
     * @param dbUser              Username for DB connection
     * @param dbPassword          Password for DB connection
     * @return SQL code representing dumped DB content.
     */
    public static String dump(String postgresContainerId, String dbName, String dbUser, String dbPassword) {
        var dockerClient = DockerClientFactory.instance().client();
        var response = dockerClient.execCreateCmd(postgresContainerId)
                .withAttachStdout(true)
                .withEnv(List.of("PGPASSWORD=\"" + dbPassword + "\""))
                // calling pg_dump without '--inserts' makes the init script complain about the default binary format
                .withCmd("pg_dump", "-U", dbUser, dbName, "--inserts")
                .exec();

        var stdoutConsumer = new ToStringConsumer();
        var stderrConsumer = new ToStringConsumer();
        var callback = new FrameConsumerResultCallback();
        callback.addConsumer(OutputFrame.OutputType.STDOUT, stdoutConsumer);
        callback.addConsumer(OutputFrame.OutputType.STDERR, stdoutConsumer);

        try {
            dockerClient.execStartCmd(response.getId()).exec(callback).awaitCompletion();
        } catch (InterruptedException e) {
            throw new IllegalStateException("Interrupted while awaiting command output from Docker", e);
        }

        var dump = stdoutConsumer.toUtf8String();
        assertThat(dump)
                .withFailMessage(() -> "Unexpected pg_dump output - stderr: " + stderrConsumer.toUtf8String())
                .contains("PostgreSQL database dump");

        // Adding generation timestamp feels like a nice idea, although this is what we have Git for ;)
        var header = "-- Generated with <3 using Testcontainers at " + LocalDateTime.now();
        return header + "\n\n" + dump;
    }

}
