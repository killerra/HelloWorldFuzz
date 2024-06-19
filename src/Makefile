CXX = g++
CXXFLAGS=-g -Wall -std=c++11 -no-pie
LDFLAGS="-Wl,-rpath,."
all: target

target: target.cpp
	$(CXX) $(CXXFLAGS) -o target target.cpp

clean:
	$(RM) target
