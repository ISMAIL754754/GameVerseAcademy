package ma.ac.esi.gameverseacademy.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    private static final String URL ="jdbc:postgresql://localhost:5432/gameverseacademy";
    private static final String USER = "postgres";
    private static final String PASSWORD = "IsmailKamal2004";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (SQLException e) {
            System.err.println("Erreur lors de la connexion à la base de données PostgreSQL !");
            e.printStackTrace();
        }
        return null;
    }
}