#!bin/sh
#sufdmod1 dfile=density.bin dz=1 freq=15 fz=0 nz=2001 press=0 rz=1 sz=1 \ tmax=1\.5 #verbose=0 vfile=velocity.bin & 
#sufdmod1 <velocity.bin nz=2001 dz=1 sz=1 rz=1 tmax=1.5 \
 #   abs=1,1 styp=1 dfile=density.bin >sufile

 sufdmod1 vfile<velocity.bin abs=1,1 nz=2001 dz=1 rz=1 sz=1 tmax=1\.5 abs=1,1 dfile=density.bin styp=1   sfile=junk 
