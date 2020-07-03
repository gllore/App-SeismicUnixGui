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
L_SU_FORTRAN_SRC = $(L_SU_FORTRAN)/src

# folder for binaries
L_SU_FORTRAN_BIN = $(L_SU_FORTRAN)/bin

# folder for object files
L_SU_FORTRAN_OBJ = $(L_SU_FORTRAN)/obj

main.o:	$(L_SU_FORTRAN_SRC)/main.f
	$(FORTRAN_COMPILER) $(FORTRAN_FLAGS) \
	-c $(L_SU_FORTRAN_SRC)/main.f \
	-o $(L_SU_FORTRAN_OBJ)/main.o

read_1col.o: $(L_SU_FORTRAN_SRC)/read_1col.f
	$(FORTRAN_COMPILER) $(FORTRAN_FLAGS) \
	-c $(L_SU_FORTRAN_SRC)/read_1col.f \
	-o $(L_SU_FORTRAN_OBJ)/read_1col.o

all: main.o read_1col.o
	$(FORTRAN_COMPILER) $(FORTRAN_FLAGS) \
	$(L_SU_FORTRAN_OBJ)/main.o \
	$(L_SU_FORTRAN_OBJ)/read_1col.o \
	-o $(L_SU_FORTRAN_BIN)/main
	
clean:
	rm -f $(L_SU_FORTRAN_BIN)/* 
	rm -f $(L_SU_FORTRAN_OBJ)/*
