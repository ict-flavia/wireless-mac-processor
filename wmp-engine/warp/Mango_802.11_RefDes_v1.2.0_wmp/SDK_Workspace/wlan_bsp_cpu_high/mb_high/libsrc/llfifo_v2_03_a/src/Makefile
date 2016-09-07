COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=
EXTRA_COMPILER_FLAGS=
LIB=libxil.a

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

INCLUDEFILES:=xllfifo.h xllfifo_hw.h xstreamer.h
LIBSOURCES:=xllfifo.c xstreamer.c
OUTS := $(LIBSOURCES:.c=.o)


libs:
	echo "Compiling llfifo"
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) $(LIBSOURCES)
	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} ${OUTS} 
	make clean

include: 
	 ${CP} ${INCLUDEFILES} ${INCLUDEDIR}

clean:
	rm -rf ${OUTS}

