package com.svalero.basededatos.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Database {
    private Connection connection;

    public void connect () throws ClassNotFoundException, SQLException {
        Class.forName("org.mariadb.jdbc.Driver");
        connection = DriverManager.getConnection(
                "jdbc:mariadb://localhost:3306/wikibook",
                "hermes", "scorpio71");
    }

    public void close() throws SQLException {
        connection.close();
    }

    public Connection getConnection () {
        return connection;
    }
}