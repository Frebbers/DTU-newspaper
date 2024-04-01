import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class DatabaseConnection {
    public Connection connection;
    Statement statement;
    public DatabaseConnection () {
        String host = "localhost";
        String port = "3306";
        String database = "dkavisen";
        String cp = "utf8";

        String username = "root";
        String password = "Ziabeg10";

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?characterEncoding=" + cp;

        try {
            // Create a connection to database
            Connection connection = DriverManager.getConnection(url, username, password);
            statement = connection.createStatement();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void executeStatement (String data) {
        try {
            statement.executeUpdate(data);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void executeQuery (String data) {
        try {
            statement.executeQuery(data);
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void closeConnection () {
        try {
            connection.close();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    //Testing methods
    public static void main (String[] args) {
        DatabaseConnection db = new DatabaseConnection();
        db.executeStatement("INSERT dkavisen.image VALUES (6, '2023-03-20', 6)");
        db.closeConnection();
    }
}
