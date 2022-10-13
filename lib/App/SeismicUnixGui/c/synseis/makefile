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
SeismicUnixGui_C_BIN = /usr/local/pl/dir/lib/SeismicUnixGui/c/bin

# working directory
SeismicUnixGui_C =/usr/local/pl/dir/lib/SeismicUnixGui/c/synseis

# location of code
SeismicUnixGui_C_SRC = $(SeismicUnixGui_C)/src

C_COMPILER = gcc

C_FLAGS = -C -ansi -g	-Wall


C_OBJ = /usr/local/pl/dir/lib/SeismicUnixGui/c/synseis/obj

# get math library functions e.g., exp
L_FLAGS = -lm -lc

synseis:
	$(C_COMPILER) $(C_FLAGS) $(L_FLAGS) -o $(SeismicUnixGui_C_BIN)/synseis $(SeismicUnixGui_C_SRC)/synseis.c
tbd:
	$(C_COMPILER) $(C_FLAGS) $(SeismicUnixGui_C_SRC)/tbd.c $(L_FLAGS) -o $(SeismicUnixGui_C_BIN)/tbd 

clean:
	rm -f $(C_OBJ)/*