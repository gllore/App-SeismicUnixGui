#!/bin/bash
# ============================================================================
# Name        : Makefile
# Author      : Juan Lorenzo
# Version     : 0.2
# Copyright   : 
# Description : Makefile for read
# ============================================================================
.PHONY: all clean

#binary folder
LSeismicUnix_C_BIN = ${LSeismicUnix}/c/bin

# working directory
LSeismicUnix_C =${LSeismicUnix}/c/synseis

# location of code
LSeismicUnix_C_SRC = $(LSeismicUnix_C)/src

C_COMPILER = gcc

C_FLAGS = -C -ansi -g -Wall

C_OBJ = ${LSeismicUnix}/c/synseis/obj

# get math library functions e.g., exp
L_FLAGS = -lm -lc

synseis:
	$(C_COMPILER) $(C_FLAGS) $(L_FLAGS) -o $(LSeismicUnix_C_BIN)/synseis $(LSeismicUnix_C_SRC)/synseis.c
tbd:
	$(C_COMPILER) $(C_FLAGS) $(LSeismicUnix_C_SRC)/tbd.c $(L_FLAGS) -o $(LSeismicUnix_C_BIN)/tbd 

clean:
	rm -f $(C_OBJ)/*