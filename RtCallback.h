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

#ifndef RTCALLBACK__H
#define RTCALLBACK__H

#include "jni.h"

#include <vector>
#include <iostream>

extern "C" {
	void __JavaRtMidiCallback(double timestamp, std::vector<unsigned char> *message, void *userdata); 
}

class RtCallback
{
        /* added for java module */
public: 
        RtCallback();
        virtual ~RtCallback();
        void callReceive();
	void receiveMessage( double timeStamp, std::vector<unsigned char> *message, void *userData );
	virtual void receiveMessage( double timeStamp, std::vector<unsigned char> *message);
        
}; 

#endif //RTCALLBACK__H
