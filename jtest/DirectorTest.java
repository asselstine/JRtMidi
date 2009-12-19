import org.rtmidi.*;

public class DirectorTest {

	public static void main(String[] args) {
		System.loadLibrary("jrtmidi");
		SubDirector sd = new SubDirector();
		sd.callReceive();	
	}

}
