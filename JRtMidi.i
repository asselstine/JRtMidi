/**
Copyright (c) 2009 Brendan Asselstine 

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
*/

%module(directors="1") JRtMidi

/** Set up typemaps */
%include "std_string.i"
%include "std_vector.i"
namespace std {
        %template(CharVector) vector<unsigned char>; 
}


%feature("director") RtMidiCallback;

%{
#include "RtCallback.h"
#include "RtMidi.h"
%}

class RtCallback {
public:
        RtCallback();
        virtual ~RtCallback();
        void callReceive();
        virtual void receiveMessage( double timeStamp, std::vector<unsigned char> *message);
};

/* %typemap(javapackage) RtCallback, RtCallback*, RtCallback&, RtMidiOut, RtMidiOut*, RtMidiOut&, RtMidiIn, RtMidiIn *, RtMidiIn & "org.rtmidi"; */

class RtMidiIn
{
 public:
 typedef void (*RtMidiCallback)( double timeStamp, std::vector<unsigned char> *message, void *userData);
  RtMidiIn( const std::string clientName = std::string( "RtMidi Input Client") );
  ~RtMidiIn();
  void openPort( unsigned int portNumber = 0, const std::string Portname = std::string( "RtMidi Input" ) );
  void openVirtualPort( const std::string portName = std::string( "RtMidi Input" ) );
  void setCallback( RtMidiCallback callback, void *userData = 0 );
  void cancelCallback();
  void closePort( void );
  unsigned int getPortCount();
  std::string getPortName( unsigned int portNumber = 0 );
  void setQueueSizeLimit( unsigned int queueSize );
  void ignoreTypes( bool midiSysex = true, bool midiTime = true, bool midiSense = true );
  double getMessage( std::vector<unsigned char> *message );
};

%extend RtMidiIn {
        void setCallback(RtCallback* callback) {
                $self->setCallback(__JavaRtMidiCallback,callback);
        }
};


class RtMidiOut
{
 public:
  RtMidiOut( const std::string clientName = std::string( "RtMidi Output Client" ) );
  ~RtMidiOut();
  void openPort( unsigned int portNumber = 0, const std::string portName = std::string( "RtMidi Output" ) );
  void closePort();
  void openVirtualPort( const std::string portName = std::string( "RtMidi Output" ) );
  unsigned int getPortCount();
  std::string getPortName( unsigned int portNumber = 0 );
  void sendMessage( std::vector<unsigned char> *message );
};

%pragma(java) jniclasscode=%{
	static {
		try {
			System.loadLibrary("jrtmidi");
		} catch (UnsatisfiedLinkError e) {
			System.err.println("Could not load JRtMidi native library: " + e);
			System.exit(1);
		}
	}
%}