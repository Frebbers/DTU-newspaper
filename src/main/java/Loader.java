import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
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
            String cpr = reporterInfo[0];
            String streetName = reporterInfo[3];
            String civicNumber = reporterInfo[4];
            String zipCode = reporterInfo[5];
            String country = reporterInfo[6];
            
        if(!reporterExists(Integer.parseInt(cpr))){
                insertStatements[i] = "INSERT INTO...";
            } else {
                insertStatements[i] = "";
            }
            i++;
        }
        return insertStatements;
    }


public String[] reporterInsertBuilder(List<PhotoAndReporter> photosAndReporters){
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
                insertStatements[i] = "INSERT INTO...";
            } else {
                insertStatements[i] = "";
            }
            i++;
        }
        return insertStatements;
    }



public boolean reporterExists(int cpr){
        //Call Zia's method with query: (SELECT COUNT(ID) FROM USERS WHERE ID = ?)
    int count = dbConnection.returnCountQuery("SELECT COUNT("+ cpr +") FROM USERS WHERE ID = ?");
    return count > 0;
}
public boolean adressExists(int id){
    //Call Zia's method with query: (SELECT COUNT(ID) FROM USERS WHERE ID = ?)
int count = dbConnection.returnCountQuery("SELECT COUNT("+ id +") FROM USERS WHERE ID = ?");
return count > 0;
}

public int adressIdGenerator(){
    //Call Zia's method with query: (SELECT COUNT(ID) FROM USERS WHERE ID = ?)
int id = dbConnection.returnCountQuery("SELECT COUNT(*) FROM adress")+1;
while(adressExists(id)){
    id++;
}
return id;
}

}
