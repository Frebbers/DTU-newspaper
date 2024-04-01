import java.io.IOException;
import java.util.List;

public class LoaderExample {

	public static void main(String[] args) {
		PhotosAndReportersLoader loader = new PhotosAndReportersLoader();
		try {
			args[0] = "src/main/resources/photosAndReporters.csv";
			System.out.println("loading from "+args[0]);
			List<PhotoAndReporter> photosAndReporters = loader.loadPhotosAndReporters(args[0]);
			for(PhotoAndReporter photoAndReporter : photosAndReporters) {
				System.out.print("\tPhoto: " + photoAndReporter.getPhoto());
				System.out.println("\tReporter: " + photoAndReporter.getReporter());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}


