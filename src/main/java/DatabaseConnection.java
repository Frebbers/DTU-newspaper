import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
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
        String password = "v";

        String url = "jdbc:mysql://" + host + ":" + port + "/" + database + "?characterEncoding=" + cp;

        try {
            // Create a connection to database
            connection = DriverManager.getConnection(url, username, password);
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
    public int returnCountQuery(String data){
        try {
            ResultSet result = statement.executeQuery(data);
            while (result.next()) {
                String x = result.getString(1);
                int results = Integer.parseInt(x);
                return results;
            }

        }
        catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    public int returnCountQuery2(String sql, int parameter){
 int count = 0;
    try {
        // Create the prepared statement
        PreparedStatement preparedStatement = connection.prepareStatement(sql);

        // Set the parameter
        preparedStatement.setInt(1, parameter);

        // Execute the query
        ResultSet resultSet = preparedStatement.executeQuery();

        // Retrieve the count from the result set
        if (resultSet.next()) {
            count = resultSet.getInt(1);
        }

        // Close the result set and the prepared statement
        resultSet.close();
        preparedStatement.close();
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return count;
    }
    public boolean adressIdExists(int id){
        //Call Zia's method with query: (SELECT COUNT(ID) FROM USERS WHERE ID = ?)
    int count = returnCountQuery("SELECT COUNT(*) FROM Address WHERE address_id = " + id);
    return count > 0;
    
    }
    public int idGenerator(String data){
        int id = 0;


    try {
        // Call Zia's method to get the maximum address_id present in the table
        ResultSet rs = statement.executeQuery(data);
        
        // Retrieve the maximum address_id
        if (rs.next()) {
            id = rs.getInt(1);
        }

        // Increment the maximum address_id by 1 to generate a new id
        id++;
    } catch (SQLException e) {
        e.printStackTrace();
    }
    if(adressIdExists(id)){
        id++;
    }
    return id;
    }
    public PreparedStatement prepareStatement(String sql) throws SQLException {
        return connection.prepareStatement(sql);
    }
    public ResultSet executeQuery2(String data) {
        try {
            return statement.executeQuery(data);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }






    //Testing methods
    public static void main (String[] args) {
        DatabaseConnection db = new DatabaseConnection();
        db.executeStatement("INSERT dkavisen.image VALUES (6, '2023-03-20', 6)");
        db.closeConnection();
    }
}
