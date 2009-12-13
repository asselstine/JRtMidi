
import java.util.logging.Logger;

import org.rtmidi.*;

public class VirtualPortInOutTest {
	public static String TESTNAME = "VirtualPortInOutTest";
	public static Logger LOG = Logger.getLogger(TESTNAME);
	public static boolean running = true;
	public static void main(String[] args) {
		System.loadLibrary("jrtmidi");

		Thread sendThread = new Thread() {
			public void run() {
				RtMidiOut rmo = new RtMidiOut(TESTNAME);
				LOG.info("Constructed RtMidiOut");
				rmo.openVirtualPort(TESTNAME + "-Out");
				CharVector cv = new CharVector(3);
				cv.set(0,(short)144);
				cv.set(1,(short)90);
				cv.set(2,(short)42);
				while(VirtualPortInOutTest.running) {
					rmo.sendMessage(cv);	
					try { 
					Thread.sleep(10);
					} catch (Exception e) { e.printStackTrace(); System.exit(1); }
				}
			}
		};

		Thread receiveThread = new Thread() {
			public void run () {

				RtMidiIn rmi = new RtMidiIn(TESTNAME);
				LOG.info("Constructed RtMidiIn");
				rmi.openVirtualPort(TESTNAME + "-In");
				CharVector cv = new CharVector(3);
				rmi.setCallback( new MyRtMidiCallback() ); 
				//rmi.setCallback(null);
				while(VirtualPortInOutTest.running) {
					try { 
					Thread.sleep(200);
					} catch (Exception e) { e.printStackTrace(); System.exit(1); }
				}
			}
		};


		try {

			sendThread.start();
			receiveThread.start();
			Thread.sleep(5000);
//			jtest.running = false;
			sendThread.join();
			receiveThread.join();	
		} catch (Exception e) {
			e.printStackTrace();
			System.exit(1);
		}

	}
}
