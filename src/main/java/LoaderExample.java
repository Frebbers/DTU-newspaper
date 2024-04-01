import java.io.File;
import java.io.IOException;
import java.util.List;

public class LoaderExample {

	public static void main(String[] args) {
		PhotosAndReportersLoader loader = new PhotosAndReportersLoader();
		try {
			//System.out.println("loading from "+args[0]);
			String relativePath = "src/main/resources/uploads.csv";
			String absolutePath = new File(relativePath).getAbsolutePath();
			List<PhotoAndReporter> photosAndReporters = loader.loadPhotosAndReporters(absolutePath);
			for(PhotoAndReporter photoAndReporter : photosAndReporters) {
				System.out.print("\tPhoto: " + photoAndReporter.getPhoto());
				System.out.println("\tReporter: " + photoAndReporter.getReporter());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}


