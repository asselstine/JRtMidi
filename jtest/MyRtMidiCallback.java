import org.rtmidi.*; 

class MyRtMidiCallback extends RtCallback {
	public void receiveMessage(double timeStamp, CharVector cv) {
		String res = "";
		for (int i = 0 ; i < cv.size(); i++) {
			if (i>0) res += ", ";
			res += cv.get(i);
		}
		VirtualPortInOutTest.LOG.info("Received: " + res);
	}
}
