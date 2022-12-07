BASE = ogpgddm
AR = ar
ARFLAGS = 
CPP = g++
CPPFLAGS = 
CXX = g++
FLEX = flex
FLEXFLAGS =
BISON = bison
BISONFLAGS = -Wcounterexamples
INSTALLDIR = /usr/local/bin

.PHONY : clean all


all: $(BASE)

%.cpp: %.ll
	$(FLEX) $(FLEXFLAGS) -o $@ $<

%.cpp %.hpp: %.yy
	$(BISON) $(BISONFLAGS) -o $*.cpp $<

%.o: %.cpp %.hpp
	$(CPP) $(CPPFLAGS) -c -o $@ $<

$(BASE): $(BASE).o scanner.o parser.o dbRAM.o foftodb.o prover.o strs.o
	$(CPP) -o $@ ogpgddm.cpp foftodb.o parser.o scanner.o prover.o dbRAM.o strs.o -lsqlite3

lib: libogpgddm.o scanner.o parser.o dbRAM.o foftodb.o prover.o strs.o
	$(AR) cq libogpgddm.a libogpgddm.o

$(BASE).o: parser.hpp
parser.o: parser.hpp strs.hpp strs.cpp
scanner.o: parser.hpp

testlib: testlib.cpp
	$(CPP) -o $@ testlib.cpp -logpgddm -L . -I .

CLEANFILES = $(BASE) *.o parser.hpp parser.cpp location.hh scanner.cpp *.a

clean:
	rm -f $(CLEANFILES) $(BASE) testlib

install:
	cp $(BASE) $(INSTALLDIR)
