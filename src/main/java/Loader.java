import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class Loader  {
    PhotosAndReportersLoader loader;
    DatabaseConnection dbConnection;
    public static void main(String[] args) throws FileNotFoundException, IOException {
        try {
            Loader loader = new Loader();
            PhotosAndReportersLoader PRLoader = new PhotosAndReportersLoader();
            String relativePath = "src/main/resources/uploads.csv";
            System.out.println("loading from "+ relativePath);
            String absolutePath = new File(relativePath).getAbsolutePath();
            List<PhotoAndReporter> photosAndReporters = PRLoader.loadPhotosAndReporters(absolutePath);
            String[] imageInsertStatements = imageInsertBuilder(photosAndReporters);
            String[] reporterInsertStatements = loader.reporterInsertBuilder(photosAndReporters);
            loader.insertValues(reporterInsertStatements);
            loader.insertValues(imageInsertStatements);
    } catch (IOException e) {
        e.printStackTrace();
    }

}
private void insertValues(String[] insertStatements){
    //Insert values into the database
    for (String statement : insertStatements) {
        if(!statement.isEmpty()){
            dbConnection.executeStatement(statement);
        }
    }
}

public static String[] imageInsertBuilder(List<PhotoAndReporter> photosAndReporters) throws IOException{
        int i = 0;
        String[] insertStatements = new String[photosAndReporters.size()];
        for(PhotoAndReporter photoAndReporter : photosAndReporters) {
            //INSERT photoAndReporter.getPhoto() into the database
            String[] photoAndDate = photoAndReporter.getPhoto().toString().split(";");
            String title = photoAndDate[0];
            String date = photoAndDate[1];
            String[] reporterInfo = photoAndReporter.getReporter().toString().split(";");
            String cpr = reporterInfo[0];
            insertStatements[i] = "INSERT INTO Image(Title, Date_Taken, Reporter_id) VALUES"+"("+"'"+title+"'"+","+date+","+ cpr+");";
            i++;
        }
        return insertStatements;
}

public String[] adressInsertBuilder(List<PhotoAndReporter> photosAndReporters){
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
            int id = adressIdGenerator();
            if(!adressExists(streetName,civicNumber,city,zipCode,country)){
                insertStatements[i] = "INSERT INTO Address(address_id, street_name, civic_number, city, zip_code, country) VALUES"+
                "("+id+"," +"'"+streetName+"'"+","+ "'"+civicNumber+"'"+"," +"'"+city+"'"+","+ "'"+zipCode+"'"+","+ "'Denmark')";
            } else {
                insertStatements[i] = "";
            }
            i++;
        }
        return insertStatements;
    }


public String[] journalistInsertBuilder(List<PhotoAndReporter> photosAndReporters){
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
            if(adressExists(streetName, civicNumber, country, zipCode, country)){
                
                try {
                    addressId = getAddressId(streetName, civicNumber, zipCode);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }

            else{
                adressInsertBuilder(photosAndReporters);
                try {
                    addressId = getAddressId(streetName, civicNumber, zipCode);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            String sql = "INSERT INTO Journalist (CPR_NUMBER, First_name, Last_name, Email_address, Address_ID) VALUES (" + cpr + ", '" + firstName + "', '" + lastName + "', 'unknown@email.com" + addressId + ")";
            
        }else {
                insertStatements[i] = "";
            }
            i++;
        }
        return insertStatements;
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


public boolean reporterExists(int cpr){
        //Call Zia's method with query: (SELECT COUNT(ID) FROM USERS WHERE ID = ?)
    int count = dbConnection.returnCountQuery("SELECT COUNT(*) FROM Reporter WHERE Reporter_ID = " + cpr);
    return count > 0;
}
public boolean adressExists(String streetName, String civicNumber, String city, String zipCode, String country){
    //Call Zia's method with query: (SELECT COUNT(ID) FROM USERS WHERE ID = ?)
int count = dbConnection.returnCountQuery("SELECT COUNT(*) FROM Address WHERE street_name = '" + streetName + "' AND civic_number = '" + civicNumber + "' AND city = '" + city + "' AND zip_code = '" + zipCode + "' AND country = '"+country+"'");
return count > 0;
}

public int adressIdGenerator() {
    return dbConnection.idGenerator("SELECT MAX(address_id) FROM Address");
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
