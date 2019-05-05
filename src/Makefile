#########
#
# Makefile pour fichiers Java
#
#########

JC			= javac
CLASSPATH	= -classpath	

JASPER_DIR	= ../jasper
SICSTUS_LIB = ../lib
JASPER_PATH = $(JASPER_DIR)/jasper.jar
JAVA_LIST	= IAClient.java lPieces.java Piece.java TCoupReq.java TCoupRep.java
SICSTUS		= IASictus.java


all: compile1 compile2

compile1:
	$(JC) $(CLASSPATH) $(JASPER_PATH):. $(SICSTUS)

compile2: 
	$(JC) $(JAVA_LIST)

clean:
	rm -f *.class;
