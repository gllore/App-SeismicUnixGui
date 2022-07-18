# ============================================================================
# Name        : Makefile
# Author      : 
# Version     :
# Copyright   : Your copyright notice
# Description : Makefile for read
# ============================================================================

.PHONY: all clean

# Change this line if you are using a different Fortran compiler
FORTRAN_COMPILER = gfortran
FORTRAN_FLAGS    = -O2 -g

# where is your working directory
L_SU_FORTRAN = /usr/local/pl/L_SU/fortran

# location of code
L_SU_FORTRAN_SRC = $(SeismicUnixGui_FORTRAN)/src

# folder for binaries
L_SU_FORTRAN_BIN = $(SeismicUnixGui_FORTRAN)/bin

# folder for object files
L_SU_FORTRAN_OBJ = $(SeismicUnixGui_FORTRAN)/obj

main.o:	$(SeismicUnixGui_FORTRAN_SRC)/main.f
	$(FORTRAN_COMPILER) $(FORTRAN_FLAGS) \
	-c $(SeismicUnixGui_FORTRAN_SRC)/main.f \
	-o $(SeismicUnixGui_FORTRAN_OBJ)/main.o

read_1col.o: $(SeismicUnixGui_FORTRAN_SRC)/read_1col.f
	$(FORTRAN_COMPILER) $(FORTRAN_FLAGS) \
	-c $(SeismicUnixGui_FORTRAN_SRC)/read_1col.f \
	-o $(SeismicUnixGui_FORTRAN_OBJ)/read_1col.o

all: main.o read_1col.o
	$(FORTRAN_COMPILER) $(FORTRAN_FLAGS) \
	$(SeismicUnixGui_FORTRAN_OBJ)/main.o \
	$(SeismicUnixGui_FORTRAN_OBJ)/read_1col.o \
	-o $(SeismicUnixGui_FORTRAN_BIN)/main
	
clean:
	rm -f $(SeismicUnixGui_FORTRAN_BIN)/* 
	rm -f $(SeismicUnixGui_FORTRAN_OBJ)/*
