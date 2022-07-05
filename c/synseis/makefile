#!/bin/bash
# ============================================================================
# Name        : Makefile
# Author      : Juan Lorenzo
# Version     : 1.1
# Copyright   : 
# Description : Makefile for read
# ============================================================================
.PHONY: all clean

#binary folder
L_SU_C_BIN = ../bin

# working directory
L_SU_C =${LSeismicUnix}/c/synseis

# location of code
L_SU_C_SRC = $(LSeismicUnix_C)/src

C_COMPILER = gcc

CFLAGS = -C -ansi  -g -Wall

# get math library functions e.g. exp
LFLAGS = -lm -lc

synseis:
	$(C_COMPILER)  $(C_FLAGS) $(LFLAGS) -o $(LSeismicUnix_C_BIN)/synseis $(LSeismicUnix_C_SRC)/synseis.c
tbd:
	$(C_COMPILER)  $(C_FLAGS) $(LSeismicUnix_C_SRC)/tbd.c $(LFLAGS) -o $(LSeismicUnix_C_BIN)/tbd 

clean:
	rm -f $(C_OBJ)/*