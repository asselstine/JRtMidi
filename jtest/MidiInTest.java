import org.rtmidi.*;

public class MidiInTest extends RtCallback {

	public static void main(String[] args) throws Exception {
		RtMidiIn input = new RtMidiIn("MidiInTest");
		if (input.getPortCount() == 0) {
			System.out.println("No ports available");
			System.exit(0);
		}
		input.openPort();
		System.out.println("MidiInTest Ok.");
		long start = System.currentTimeMillis();
		while (System.currentTimeMillis()-start < 5000l) {
			Thread.sleep(100);
		}
	}

}