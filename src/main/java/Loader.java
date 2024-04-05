import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Scanner;

public class Loader  {
    DatabaseConnection dbConnection;

    public static void main(String[] args) throws FileNotFoundException, IOException {
        try {
            Loader loader = new Loader();
            Scanner scanner = new Scanner(System.in);
            System.out.println("Enter the password for the database: ");
            String password = scanner.nextLine();
            loader.dbConnection = new DatabaseConnection(password);
            scanner.close();
            PhotosAndReportersLoader PRLoader = new PhotosAndReportersLoader();
            String relativePath = "src/main/resources/uploads.csv";
            System.out.println("loading from "+ relativePath);
            String absolutePath = new File(relativePath).getAbsolutePath();
            List<PhotoAndReporter> photosAndReporters = PRLoader.loadPhotosAndReporters(absolutePath);

            String[] insertAdressStatements = loader.insertAddressBuilder(photosAndReporters);
            //Insert addresses into the database
            loader.insertValues(insertAdressStatements);
            //Insert journalists into the database
            loader.journalistInsertBuilder(photosAndReporters);
            loader.imageInsertBuilder(photosAndReporters);
            String[] reporterInsertStatements = loader.insertReporterImagesBuilder(photosAndReporters);

            loader.dbConnection.closeConnection();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    private void insertValues(String[] insertStatements) {
        // Insert values into the database
        for (String statement : insertStatements) {
            if (statement != null && !statement.isEmpty()) {
                dbConnection.executeStatement(statement);
            }
        }
    }
    private void insertValue(String statement) {
        // Insert values into the database
        if (statement != null && !statement.isEmpty()) {
            dbConnection.executeStatement(statement);
        }
    }
    public void imageInsertBuilder(List<PhotoAndReporter> photosAndReporters) throws IOException{
        int i = 0;
        String[] insertStatements = new String[photosAndReporters.size()];
        for(PhotoAndReporter photoAndReporter : photosAndReporters) {
            //INSERT photoAndReporter.getPhoto() into the database
            String[] photoAndDate = photoAndReporter.getPhoto().toString().split(";");
            String title = photoAndDate[0];
            String date = photoAndDate[1];
            String[] reporterInfo = photoAndReporter.getReporter().toString().split(";");
            String cpr = reporterInfo[0];
            if (!imageExists(title, date)) {
                insertStatements[i] = "INSERT INTO Image(Title, Date_Taken, Reporter_id) VALUES"+"("+"'"+title+"'"+","+date+","+ cpr+");";
                insertValue(insertStatements[i]);
                System.out.println("Image with title: " + title + " and date: " + date + " is now inserted");
                insertValue("INSERT INTO Reporter (Reporter_ID, Image_Title) VALUES (" + cpr + ", '" + title + "')");
            }
            else {
                System.out.println("Image with title: " + title + " and date: " + date + " already exists");
                insertStatements[i] = "";
            }
            i++;
        }
    }

    public String[] insertAddressBuilder(List<PhotoAndReporter> photosAndReporters){
        PhotosAndReportersLoader loader = new PhotosAndReportersLoader();
        String[] insertStatements = new String[photosAndReporters.size()];
        int i = 0;

        for(PhotoAndReporter photoAndReporter : photosAndReporters) {

            //INSERT photoAndReporter.getReporter() into the database
            String[] reporterInfo = photoAndReporter.getReporter().toString().split(";");
            String streetName = reporterInfo[3];
            String civicNumber = reporterInfo[4];
            String zipCode = reporterInfo[5];
            String city = reporterInfo[6];
            String country = "Denmark";

            if(!addressExists(streetName,civicNumber,city,zipCode,country)){


                insertStatements[i] = "INSERT INTO Address(street_name, civic_number, city, zip_code, country) VALUES"+
                        "('"+streetName+"'"+","+ "'"+civicNumber+"'"+"," +"'"+city+"'"+","+ "'"+zipCode+"'"+","+ "'Denmark')";
                System.out.println(" Inserting address: " + streetName + ", " +civicNumber + ", " + zipCode + ", " + city + ", Denmark is now inserted" );
            } else {
                System.out.println("Address already exists: " + streetName + ", " +civicNumber + ", " + zipCode + ", " + city + ", Denmark");
                insertStatements[i] = "";
            }
            i++;
        }
        return insertStatements;
    }


    public void journalistInsertBuilder(List<PhotoAndReporter> photosAndReporters){
        PhotosAndReportersLoader loader = new PhotosAndReportersLoader();
        String[] insertStatements = new String[photosAndReporters.size()];
        int i = 0;
        for(PhotoAndReporter photoAndReporter : photosAndReporters) {
            //INSERT photoAndReporter.getReporter() into the database
            String[] reporterInfo = photoAndReporter.getReporter().toString().split(";");
            String cpr = reporterInfo[0];
            String firstName = reporterInfo[1];
            String lastName = reporterInfo[2];
            String streetName = reporterInfo[3];
            String civicNumber = reporterInfo[4];
            String zipCode = reporterInfo[5];
            String country = reporterInfo[6];
            if(!reporterExists(Integer.parseInt(cpr))){
                int addressId = 0;
                if(addressExists(streetName, civicNumber, country, zipCode, country)){
                    try {
                        addressId = getAddressId(streetName, civicNumber, zipCode);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                else{
                    try {
                        addressId = getAddressId(streetName, civicNumber, zipCode);
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                String sql = "INSERT INTO Journalist (CPR_NUMBER, First_name, Last_name, Email_address, Address_ID) VALUES (" + cpr + ", '" + firstName + "', '" + lastName + "', 'unknown@email.com', " + addressId + ")";
                insertValue(sql);
                System.out.println("Journalist with CPR "+ cpr + " is inserted now");
                insertStatements[i] = sql;
            }else {
                System.out.println("Journalist already exists with CPR "+ cpr);
                insertStatements[i] = "";
            }
            i++;
        }
    }

    public String[] insertReporterImagesBuilder(List<PhotoAndReporter> photosAndReporters) {
        String[] insertStatements = new String[photosAndReporters.size()];
        int i = 0;
        for (PhotoAndReporter photoAndReporter : photosAndReporters) {
            String[] reporterInfo = photoAndReporter.getReporter().toString().split(";");
            int reporterId = Integer.parseInt(reporterInfo[0]);
            String imageTitle = photoAndReporter.getPhoto().getTitle(); // Assuming Photo has a getTitle method

            insertStatements[i] = "INSERT INTO Reporter (Reporter_ID, Image_Title) VALUES (" + reporterId + ", '" + imageTitle + "')";
            i++;
        }
        return insertStatements;
    }


    public boolean reporterExists(int cpr) {
        int count = dbConnection.returnCountQuery2("SELECT COUNT(*) FROM Journalist WHERE CPR_NUMBER = ?", cpr);
        return count > 0;
    }

    public boolean addressExists(String streetName, String civicNumber, String city, String zipCode, String country){
        int count = dbConnection.returnCountQuery("SELECT COUNT(*) FROM Address WHERE street_name = '" + streetName + "' AND civic_number = '" + civicNumber + "' AND city = '" + city + "' AND zip_code = '" + zipCode + "' AND country = '"+country+"'");
        return count > 0;
    }

    private boolean imageExists(String title, String date) {
        try {
            // Query to check if an image with the same title and date exists
            String query = "SELECT COUNT(*) FROM Image WHERE Title = ? AND Date_Taken = ?";
            PreparedStatement preparedStatement = dbConnection.prepareStatement(query);
            preparedStatement.setString(1, title);
            preparedStatement.setString(2, date);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                int count = resultSet.getInt(1);
                return count > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }


    private int getAddressId(String streetName, String civicNumber, String zipCode) throws SQLException {
        String sql = "SELECT address_id FROM Address WHERE street_name = '" + streetName + "' AND civic_number = '" + civicNumber + "' AND zip_code = '" + zipCode + "'";
        ResultSet rs = dbConnection.executeQuery2(sql);
        if (rs.next()) {
            return rs.getInt("address_id");
        }
        return -1;
    }


}
