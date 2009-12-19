import org.rtmidi.*;

public class MidiOutTest {

	public static void main(String[] args) throws Exception {
		System.out.println("hello");
		
		RtMidiOut out = new RtMidiOut("MidiOutTest");
		out.openPort();
		long start = System.currentTimeMillis();

		CharVector cv = new CharVector(3);
		cv.set(0,(short)144);
		cv.set(1,(short)60);
		cv.set(2,(short)78);
		int i = 0;
		while ((System.currentTimeMillis() - start) < 5000l) {
			cv.set(1,(short)(10+(i+=1)));
			if (i > 60)
				i = 0;
			out.sendMessage(cv);
			Thread.sleep(300);
		}
		
	}

}