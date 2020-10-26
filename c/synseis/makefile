#!/bin/bash
# ============================================================================
# Name        : Makefile
# Author      : Juan Lorenzo
# Version     : 1.1
# Copyright   : Your copyright notice
# Description : Makefile for read
# ============================================================================
.PHONY: all clean

#binary folder
L_SU_C_BIN = ../bin

# working directory
L_SU_C =${L_SU}/c/synseis

# location of code
L_SU_C_SRC = $(L_SU_C)/src

C_COMPILER = gcc

CFLAGS = -C -ansi  -g -Wall

# get math library functions e.g. exp
LFLAGS = -lm -lc

synseis:
	$(C_COMPILER)  $(C_FLAGS) $(LFLAGS) -o $(L_SU_C_BIN)/synseis $(L_SU_C_SRC)/synseis.c
tbd:
	$(C_COMPILER)  $(C_FLAGS) $(L_SU_C_SRC)/tbd.c $(LFLAGS) -o $(L_SU_C_BIN)/tbd 

clean:
	rm -f $(C_OBJ)/*
