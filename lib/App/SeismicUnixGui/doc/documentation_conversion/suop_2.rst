SYNOPSIS
--------

PERL PROGRAM NAME:

AUTHOR:

DATE:

DESCRIPTION:

Version:

USE
---

NOTES
~~~~~

Examples
^^^^^^^^

.. _synopsis-1:

SYNOPSIS
--------

SEISMIC UNIX NOTES
~~~~~~~~~~~~~~~~~~

SUOP - do unary arithmetic operation on segys

::

   suop <stdin >stdout op=abs                                     



   Required parameters:                                           

          none                                                    



   Optional parameter:                                            

          op=abs          operation flag                          

                          abs   : absolute value                  

                          avg   : remove average value            

                          ssqrt : signed square root              

                          sqr   : square                          

                          ssqr  : signed square                   

                          sgn   : signum function                 

                          exp   : exponentiate                    

                          sexp  : signed exponentiate             

                          slog  : signed natural log              

                          slog2 : signed log base 2               

                          slog10: signed common log               

                          cos   : cosine                          

                          sin   : sine                            

                          tan   : tangent                         

                          cosh  : hyperbolic cosine               

                          sinh  : hyperbolic sine                 

                          tanh  : hyperbolic tangent              

                          cnorm : norm complex samples by modulus ", 

                          norm  : divide trace by Max. Value      

                          db    : 20 * slog10 (data)              

                          neg   : negate value                    

                          posonly : pass only positive values     

                          negonly : pass only negative values     

                         sum   : running sum trace integration   

                         diff  : running diff trace differentiation

                         refl  : (v[i+1] - v[i])/(v[i+1] + v[i]) 

                          mod2pi : modulo 2 pi                    

                          inv   : inverse                         

                          rmsamp : rms amplitude                  

                         s2v   : sonic to velocity (ft/s) conversion     

                         s2vm  : sonic to velocity (m/s) conversion     

                         d2m   : density (g/cc) to metric (kg/m^3) conversion 

                         drv2  : 2nd order vertical derivative 

                         drv4  : 4th order vertical derivative 

                         integ : top-down integration            

                         spike : local extrema to spikes         

                         saf   : spike and fill to next spike    

                         freq  : local dominant freqeuncy        

                         lnza  : preserve least non-zero amps    

                         --------- window operations ----------- 

                         mean  : arithmetic mean                 

                         despike  : despiking based on median filter

                         std   : standard deviation              

                         var   : variance                        

         nw=21           number of time samples in window        

                         --------------------------------------- 

                          nop   : no operation                    



   Note:  Binary ops are provided by suop2.                       

   Operations inv, slog, slog2, and slog10 are "punctuated",      ", 

   meaning that if, the input contains 0 values,                  

   0 values are returned.                                 ",      



   For file operations on non-SU format binary files use:  farith



   Credits:



   CWP: Shuki Ronen, Jack K Cohen (c. 1987)

    Toralf Foerster: norm and db operations, 10/95.

    Additions by Reg Beardsley, Chris Liner, and others.



   Notes:

          If efficiency becomes important consider inverting main loop

        and repeating operation code within the branches of the switch.



          Note on db option.  The following are equivalent:

          ... | sufft | suamp | suop op=norm | suop op=slog10 |\

                  sugain scale equals 20| suxgraph style=normal



          ... | sufft | suamp | suop op=db | suxgraph style=normal

User’s notes (Juan Lorenzo)
---------------------------

::

   An additional parameter called "list"  allows the operation
   to be repeated among multiple files.

   The names of the su files are in the list.

   The list is found in $DATA_SEISMIC_TXT.
   Output file names carry a suffix equal to the operation
   variable. For example,

      file1_neg.su

CHANGES and their DATES
-----------------------

Import packages
---------------

instantiation of packages
-------------------------

Encapsulated
------------

hash of private variables

sub Step
--------

collects switches and assembles bash instructions by adding the program
name

sub note
--------

collects switches and assembles bash instructions by adding the program
name

sub clear
---------

sub \_get_inbound
-----------------

sub \_set_inbound_list
----------------------

sub \_get_file_names
--------------------

sub list
--------

::

   list array

sub nw
------

sub op
------

sub get_max_index
-----------------

max index = number of input variables -1
