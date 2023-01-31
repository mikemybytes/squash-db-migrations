package com.mikemybytes.squash;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

/**
 * Updates init.sql script content.
 */
public class InitSqlUpdater {

    private InitSqlUpdater() {
        // static only
    }

    /**
     * Replaces init.sql script content.
     * @param content New script content
     */
    public static void write(String content) {
        try {
            var initSqlPath = Paths.get("src", "test", "resources", "init.sql");
            Files.writeString(initSqlPath, content);
        } catch (IOException e) {
            throw new IllegalStateException("Failed to write init.sql content", e);
        }
    }

}
