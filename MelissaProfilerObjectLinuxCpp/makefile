# Melissa Profiler Object Linux C++

R = .
CXX = g++
CXXFLAGS = -Wall -Wextra -pedantic -std=c++17 -g -pthread -m64
LDLIBS = -L/home/emaiiii/MdLinuxExamples/ProfilerObject-Cpp-Linux/MelissaProfilerObjectLinuxCpp/Build -Wl,--no-as-needed,-ldl,-rpath,$(DIR) -lmdProfiler
RM = rm -f
OUT_DIR = Build

all: MelissaProfilerObjectLinuxCpp

MelissaProfilerObjectLinuxCpp: Main.cpp ProfilerObject.cpp mdProfiler.h mdProfilerEnums.h | $(OUT_DIR)
				$(CXX) $(CXXFLAGS) Main.cpp ProfilerObject.cpp -o $(OUT_DIR)/$@ $(LDLIBS)

clean:
				$(RM) *.o $(OUT_DIR)/MelissaProfilerObjectLinuxCpp
