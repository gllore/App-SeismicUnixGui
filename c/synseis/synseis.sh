#! /bin/sh
set -x
# This script creates the synthetic seismogram in an ascii file
# usage synseis.sh Site number
#
# ***** SETTING SITE WATER DEPTHS******* NOTE 1 ***************************
#water_depth=1123. # water depth at site 904 delay = 370 ms
water_depth=1; #1123.  #wqter depth incurrent zrhov model
#

# ********SETTING PATHS ******* NOTE 2 ***************************
# 
# zrhov is the only file that synseis reads on input 
# zrhov contains depth versus density and velosity in three columns
# values versus depth DO NOT HAVE  to be at regular intervals but
# commonly are.
#
# Setting paths
path=./
zrhov_filename=./zrhov.904 # input filename 
zrhov_filename=./zrhov # input filename 
#zrhov_filename=$path2/juan/ODP/synseis/904/zrhov
output_source=./source.out
reflec_coef_time=./rc_t
reflec_coef_depth=./rc_z
reg_density_file=./zrho.reg
reg_velocity_file=./zv.reg
#
# *********** OPTIONS ************* NOTE 3 *************************
# The program has various options, e.g.
#	1) variable sampling rate
#	2) synthetic Ricker source
#	3A) real MCS source ready to roll!
#	3B) sources that need to be resampled at a finer sampling rate
#
# For each option several parameters must be turned off and others turned
# on.  At present this program works using an MCS source wavelet with
# a 2ms sampling interval taken from EW Line 1027 at CDP 1377 1.106-1.166ms
# (1027.source) found in /projects/projects5/Geol4068/synseis_class/sources
# Be careful with the units as SUnix uses microseconds and you may
# like to think in terms of milliseconds or just seconds!
#
# ---------------- uncomment before next line if using resampled source
#  OTHER OPTIONAL SOURCES with DIFFERENT (!!!) sampling intervals
#
# 1ms SI; first source used, fromCDP 1400, line2, SCS
# input_source_filename=$path/sources/CDP1400.source
# time_sampling_interval=0.001 # in seconds
#
# 1ms SI;  CDP 1210 1086-1173ms 
# input_source_filename=$path/sources/line2.source 
# time_sampling_interval=0.001 # in seconds
#
# ******************************************************
# WE USE THE FOLLOWING SOURCE IN THIS EXAMPLE
# *******************************************************
# 2ms SI CDP 1377 1.106-1.166ms
input_source_filename=./1027.source 
time_sampling_interval=0.002 # in seconds
#
depth_sampling_interval=0.4   # in meters
#
# Remember that you can't use an MCS source AND a Ricker wavelet
# and a seismic source wavelet you would like to change within synseis
# SIMLUTANEOUSLY.  Therefore, if you want to use on eof these options
# other options MUST be set off.  I advise you to not use the following
# options for the time being without help.

# If you want to use the following options
# ----------------- uncomment before next line for source for sampling
#  source_resampling_interval=0.004
##  tmin_resampled_source=0.004 
#  xstart4resampling_source=0.0
# -X0$xstart4resampling_source \
#-S$input_source_filename
#
# --------------- uncomment below this line if using Ricker --------
# Ricker_endtime=0.15    # s
# Ricker_file=$path2/Geol4068/users/$1/modeling/output/ricker.out
# Ricker_frequency=40.   # Hz
# -AF$Ricker_frequency \
# -AE$Ricker_endtime \
# -Ao$Ricker_file 
# -----------------------------------------------------------------  
# ************* Running the program *********** NOTE   ***************
# -V allows output of all values during run time : not recommended
# unless you desire to inspect the gizzards of the beast
#
# -X0$xstart4resampling_source \
synseis \
-S$input_source_filename \
-CZ$reflec_coef_depth \
-CT$reflec_coef_time \
-I$time_sampling_interval \
-IZ$depth_sampling_interval \
-LD$reg_density_file \
-LV$reg_velocity_file \
-Ro$output_source \
-Z$zrhov_filename \
-W$water_depth
# -V
