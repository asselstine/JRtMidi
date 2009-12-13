#This file builds the library

#if you update the rt midi library, update this
RT_MIDI_FOLDER='rtmidi-1.0.10'


env = Environment()
cxxFiles = env.Glob('*.cxx')
cppFiles = env.Glob('*.cpp') + env.Glob(RT_MIDI_FOLDER+'/*.cpp')


# These are linux only options!  Please add a windows and mac option as well
env.AppendUnique(CCFLAGS = ["-I/usr/lib/jvm/java-6-sun/include"])
env.AppendUnique(CCFLAGS = ["-I/usr/lib/jvm/java-6-sun/include/linux"])
env.AppendUnique(CCFLAGS = ["-I."])
env.AppendUnique(CCFLAGS = ["-I"+RT_MIDI_FOLDER])
env.AppendUnique(CCFLAGS = ["-D__LINUX_ALSASEQ__"])
env.AppendUnique(CCFLAGS = ["-g"])
env.AppendUnique(LIBS = ["asound", "pthread"])


env.SharedLibrary('jrtmidi', cxxFiles + cppFiles)
