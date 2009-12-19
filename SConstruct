import os, sys

#if you update the rt midi library, update this
RT_MIDI_FOLDER='rtmidi-1.0.10'

env = Environment()

JAVA_HOME = os.environ.get('JAVA_HOME')

cxxFiles = env.Glob('*.cxx')
cppFiles = env.Glob('*.cpp') 



#debugging flag to tell the compiler to insert debug symbols

if (sys.platform == 'win32'):
	
	JAVA_HOME_INC = JAVA_HOME + "\include"
	WIN_INCLUDE = os.environ.get('INCLUDES')
	if (WIN_INCLUDE == None or WIN_INCLUDE == ''):
		print 'INCLUDE environment variable for SDK headers not defined'
		exit()
	else:
		print "Using Include folder: " + WIN_INCLUDE
	WIN_LIB = os.environ.get('LIB')
	if (WIN_LIB == None or WIN_LIB == ''):
		print 'LIB environment variable for Lib objects not defined'
		exit()
	else:
		print "Using Library folder: " + WIN_LIB
	env.AppendUnique(CXXFLAGS = Split("/EHsc"))
	env.AppendUnique(LIBPATH = [WIN_LIB])
	env.AppendUnique(CPPPATH = [JAVA_HOME_INC, JAVA_HOME_INC + "\win32", WIN_INCLUDE, RT_MIDI_FOLDER])
	env.AppendUnique(CCFLAGS = ["-D__WINDOWS_MM__"])
	env.AppendUnique(LIBS = ["WinMM"])
	cppFiles += env.Glob(RT_MIDI_FOLDER+'\*.cpp')
	
elif (sys.platform == 'linux2'):
	env.AppendUnique(CCFLAGS = ["-I."])
	env.AppendUnique(CCFLAGS = ["-g"])
	JAVA_HOME_INC = JAVA_HOME + "/include"
	env.AppendUnique(CCFLAGS = ["-I"+RT_MIDI_FOLDER])
	env.AppendUnique(CCFLAGS = ["-I"+JAVA_HOME_INC])
	env.AppendUnique(CCFLAGS = ["-I" + JAVA_HOME_INC + "/linux"])
	env.AppendUnique(CCFLAGS = ["-D__LINUX_ALSASEQ__"])
	env.AppendUnique(LIBS = ["asound", "pthread"])
	cppFiles += env.Glob(RT_MIDI_FOLDER+'/*.cpp')

env.SharedLibrary('jrtmidi', cxxFiles + cppFiles)
