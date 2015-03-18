##############################################################################
## Filename:          C:\work\svn_work\mango-dev\edk_user_repository\MyProcessorIPLib/drivers/w3_userio_v1_00_a/src/Makefile
## Description:       Microprocessor Driver Makefile
## Date:              Sun Jun 24 20:36:55 2012 (by Create and Import Peripheral Wizard)
##############################################################################

#w3_userio driver has only a header file (no .c files), so make libs just returns

COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS=
EXTRA_COMPILER_FLAGS=
LIB=libxil.a

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I./. -I${INCLUDEDIR}

INCLUDEFILES=*.h
LIBSOURCES=*.c
OUTS = *.o

libs:
	echo "Compiling w3_userio_axi"
#	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) $(LIBSOURCES)
#	$(ARCHIVER) -r ${RELEASEDIR}/${LIB} ${OUTS}
#	make clean

include:
	${CP} $(INCLUDEFILES) $(INCLUDEDIR)

clean:
	rm -rf ${OUTS}
