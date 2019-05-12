#########
#
# Makefile pour Yokai no-mori
#
#########

CC          = gcc
CFLAG       = -Wall
PROG_NAME1  = player
PROG_NAME2  = server

SRC_DIR     = ./src
BUILD_DIR   = ./build
BIN_DIR     = ./bin
SRC_LIST1   = $(SRC_DIR)/fctCom.c $(SRC_DIR)/fctPlayer.c $(SRC_DIR)/player.c
SRC_LIST2   = $(SRC_DIR)/fctCom.c $(SRC_DIR)/fctServer.c $(SRC_DIR)/server.c
OBJ_UTIL1    = $(subst .c,.o,$(SRC_LIST1))
OBJ_UTIL2    = $(subst .c,.o,$(SRC_LIST2))
OBJ_LIST1    = $(subst $(SRC_DIR),$(BUILD_DIR),$(OBJ_UTIL1))
OBJ_LIST2    = $(subst $(SRC_DIR),$(BUILD_DIR),$(OBJ_UTIL2))
# OBJ_LIST    = $(BUILD_DIR)/$(notdir $(SRC_LIST:.c=.o))

.PHONY: all clean $(PROG_NAME1) $(PROG_NAME2) compile1 compile2

all: $(PROG_NAME1) $(PROG_NAME2)

compile1: 
	$(CC) -c $(SRC_LIST1)

compile2: 
	$(CC) -c $(SRC_LIST2)

$(PROG_NAME1): compile1 move1
	$(CC) $(CFLAG) $(OBJ_LIST1) -o $(BIN_DIR)/$@

$(PROG_NAME2): compile2 move2
	$(CC) $(CFLAG) $(OBJ_LIST2) $(BUILD_DIR)/yokai-fPIC.o -o $(BIN_DIR)/$@ 

move1:
	mv *.o $(BUILD_DIR)

move2:
	mv *.o $(BUILD_DIR)

clean:
	rm -f $(BUILD_DIR)/fctCom.o $(BUILD_DIR)/fctPlayer.o $(BUILD_DIR)/player.o $(BUILD_DIR)/fctServer.o $(BUILD_DIR)/server.o

mrproper:
	rm -f $(BIN_DIR)/$(PROG_NAME1) $(BIN_DIR)/$(PROG_NAME2)

