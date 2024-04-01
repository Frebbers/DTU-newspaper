import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;

public class Loader  {
    PhotosAndReportersLoader loader;
    public static void main(String[] args) throws FileNotFoundException, IOException {
        try {
        PhotosAndReportersLoader loader = new PhotosAndReportersLoader();
        String relativePath = "src/main/resources/uploads.csv";
        System.out.println("loading from "+ relativePath);
        String absolutePath = new File(relativePath).getAbsolutePath();
        List<PhotoAndReporter> photosAndReporters = loader.loadPhotosAndReporters(absolutePath);
        String[] imageInsertStatements = imageInsertBuilder(photosAndReporters);
    } catch (IOException e) {
        e.printStackTrace();
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
            insertStatements[i] =
            i++;
        }
        return insertStatements;
}

public static String[] reporterInsertBuilder(List<PhotoAndReporter> photosAndReporters){
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
        if(reporterExists(Integer.parseInt(cpr))){
                insertStatements[i] = "INSERT INTO...";
            } else {
                insertStatements[i] = "";
            }
            i++;
        }
        return insertStatements;
}

public static boolean reporterExists(int cpr){
        //Call Zia's method with query: (SELECT COUNT(ID) FROM USERS WHERE ID = ?)
    return queryResult > 0;
}
}
