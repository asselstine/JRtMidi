import org.rtmidi.*;

class SubDirector extends RtCallback {
	public void receiveMessage(double timeStamp, CharVector message) {
		System.out.println("C++ can call Java methods!");
	}
}
