# ============================================================================
# Name        : Makefile
# Author      : Juan Lorenzo 
# Version     : 0.1
# Copyright   : Please copy
# Description : Makefile for immodpg
# ============================================================================

.PHONY: all clean

# Change this line if you are using a different Fortran compiler
FORTRAN_COMPILER = gfortran
F77 = -iffixed-form
F95 = -iffree-form
FORTRAN_95_FLAGS    = -O2 -g $(F95)
FORTRAN_77_FLAGS    = -O2 -g $(F95)

# where is your working directory
LSeismicUnix_FORTRAN = .

# location of code
LSeismicUnix_FORTRAN_SRC = $(LSeismicUnix_FORTRAN)/src

# folder for binaries
LSeismicUnix_FORTRAN_BIN = $(LSeismicUnix_FORTRAN)/bin

BIN_OUT          = $(LSeismicUnix_FORTRAN_BIN)
# BIN_OUT          = ''
# folder for object files
LSeismicUnix_FORTRAN_OBJ = $(LSeismicUnix_FORTRAN)/obj

# compile F95 source code
Project_config.o:	$(LSeismicUnix_FORTRAN_SRC)/Project_config.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/Project_config.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/Project_config.o

main.o:	$(LSeismicUnix_FORTRAN_SRC)/main.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/main.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/main.o

main: main.o read_1col.o write_1col.o
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	$(LSeismicUnix_FORTRAN_OBJ)/main.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_1col.o \
	-o $(LSeismicUnix_FORTRAN_BIN)/main
	
readVbot_file.o: $(LSeismicUnix_FORTRAN_SRC)/readVbot_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readVbot_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readVbot_file.o
	
readVbot_upper_file.o: $(LSeismicUnix_FORTRAN_SRC)/readVbot_upper_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readVbot_upper_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readVbot_upper_file.o
	
readVtop_file.o: $(LSeismicUnix_FORTRAN_SRC)/readVtop_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readVtop_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readVtop_file.o
	
readVtop_lower_file.o: $(LSeismicUnix_FORTRAN_SRC)/readVtop_lower_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readVtop_lower_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readVtop_lower_file.o
			
readVincrement_file.o: $(LSeismicUnix_FORTRAN_SRC)/readVincrement_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readVincrement_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readVincrement_file.o
	
readVbotNtop_factor_file.o: $(LSeismicUnix_FORTRAN_SRC)/readVbotNtop_factor_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readVbotNtop_factor_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readVbotNtop_factor_file.o
	
read_bin_data.o: $(LSeismicUnix_FORTRAN_SRC)/read_bin_data.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_bin_data.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_bin_data.o
	
read_immodpg_config.o: $(LSeismicUnix_FORTRAN_SRC)/read_immodpg_config.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_immodpg_config.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_immodpg_config.o
	
read_clip_file.o: $(LSeismicUnix_FORTRAN_SRC)/read_clip_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_clip_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_clip_file.o
	
read_layer_file.o: $(LSeismicUnix_FORTRAN_SRC)/read_layer_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_layer_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_layer_file.o
	
read_thickness_increment_m_file.o: $(LSeismicUnix_FORTRAN_SRC)/read_thickness_increment_m_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_thickness_increment_m_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_thickness_increment_m_file.o
	
read_thickness_m_file.o: $(LSeismicUnix_FORTRAN_SRC)/read_thickness_m_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_thickness_m_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_thickness_m_file.o
	
read_option_file.o: $(LSeismicUnix_FORTRAN_SRC)/read_option_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_option_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_option_file.o
	
read_parmmod_file.o: $(LSeismicUnix_FORTRAN_SRC)/read_parmmod_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_parmmod_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_parmmod_file.o		
	
read_yes_no_file.o: $(LSeismicUnix_FORTRAN_SRC)/read_yes_no_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/read_yes_no_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/read_yes_no_file.o
	
write_model_file_text.o: $(LSeismicUnix_FORTRAN_SRC)/write_model_file_text.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/write_model_file_text.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/write_model_file_text.o

write_yes_no_file.o: $(LSeismicUnix_FORTRAN_SRC)/write_yes_no_file.f
	$(FORTRAN_COMPILER) $(FORTRAN95_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/write_yes_no_file.f \
	-o $(LSeismicUnix_FORTRAN_OBJ)/write_yes_no_file.o

# compile F77 fortran source code by Emilio Vera	
messa.o:$(LSeismicUnix_FORTRAN_SRC)/messa.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/messa.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/messa.o	
immodpg.o:$(LSeismicUnix_FORTRAN_SRC)/immodpg.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/immodpg.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/immodpg.o
	
readpar.o: $(LSeismicUnix_FORTRAN_SRC)/readpar.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readpar.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readpar.o
readmmod.o: $(LSeismicUnix_FORTRAN_SRC)/readmmod.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/readmmod.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/readmmod.o
denfvp.o:  $(LSeismicUnix_FORTRAN_SRC)/denfvp.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/denfvp.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/denfvp.o
	
thi.o: $(LSeismicUnix_FORTRAN_SRC)/thi.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/thi.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/thi.o
wrimod2.o: $(LSeismicUnix_FORTRAN_SRC)/wrimod2.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/wrimod2.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/wrimod2.o
txpr.o: $(LSeismicUnix_FORTRAN_SRC)/txpr.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/txpr.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/txpr.o
txgrd.o: $(LSeismicUnix_FORTRAN_SRC)/txgrd.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/txgrd.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/txgrd.o
moveNzoom.o: $(LSeismicUnix_FORTRAN_SRC)/moveNzoom.for
	$(FORTRAN_COMPILER) $(FORTRAN77_FLAGS) \
	-c $(LSeismicUnix_FORTRAN_SRC)/moveNzoom.for \
	-o $(LSeismicUnix_FORTRAN_OBJ)/moveNzoom.o

# link and build executable with both F77 and F95 files
immodpg1.1: immodpg.o readpar.o readmmod.o \
denfvp.o thi.o wrimod2.o txpr.o txgrd.o moveNzoom.o \
readVbot_file.o readVbot_upper_file.o readVtop_file.o readVtop_lower_file.o \
readVincrement_file.o readVbotNtop_factor_file.o read_bin_data.o \
read_immodpg_config.o \
read_clip_file.o read_layer_file.o read_thickness_m_file.o  read_thickness_increment_m_file.o  \
read_option_file.o read_parmmod_file.o \
read_yes_no_file.o \
write_model_file_text.o write_yes_no_file.o \
messa.o Project_config.o
	$(FORTRAN_COMPILER) \
	$(LSeismicUnix_FORTRAN_OBJ)/thi.o \
	$(LSeismicUnix_FORTRAN_OBJ)/wrimod2.o \
	$(LSeismicUnix_FORTRAN_OBJ)/txpr.o \
	$(LSeismicUnix_FORTRAN_OBJ)/txgrd.o \
	$(LSeismicUnix_FORTRAN_OBJ)/denfvp.o \
	$(LSeismicUnix_FORTRAN_OBJ)/moveNzoom.o \
	$(LSeismicUnix_FORTRAN_OBJ)/immodpg.o \
	$(LSeismicUnix_FORTRAN_OBJ)/messa.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readpar.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readmmod.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readVbot_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readVbot_upper_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readVtop_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readVtop_lower_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readVincrement_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/readVbotNtop_factor_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_bin_data.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_immodpg_config.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_clip_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_layer_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_thickness_increment_m_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_thickness_m_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_option_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_parmmod_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/read_yes_no_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/write_model_file_text.o \
	$(LSeismicUnix_FORTRAN_OBJ)/write_yes_no_file.o \
	$(LSeismicUnix_FORTRAN_OBJ)/Project_config.o \
	-L/usr/local/pgplot -lpgplot  -L/usr/lib64 -lX11 -o$(BIN_OUT)/immodpg1.1
	
clean:
	rm -f $(LSeismicUnix_FORTRAN_BIN)/* 
	rm -f $(LSeismicUnix_FORTRAN_OBJ)/*
