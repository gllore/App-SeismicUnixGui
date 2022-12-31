package App::SeismicUnixGui::messages::help_button_messages;

use Moose;
our $VERSION = '0.0.1';

sub get {
    my ( $self) = @_;
    my @message;

$message[0] = ("Installation:  \n");
	
    return ( \@message );


$message[1] = ("SeismicUnixGui

SeismicUnixGui (alpha) is a graphical user interface (GUI) \n
to select parameters for Seismic Unix (SU) modules. Seismic \n
Unix (Stockwell, 1999) is a widely distributed free software \n
package for processing seismic reflection and signal processing. \n
erl/Tk is a mature, well-documented and free object-oriented \n
graphical user interface for Perl.
In a classroom environment, shell scripting of SU modules engages \n
students and helps focus on the theoretical limitations and strengths \n
f signal processing. However, complex interactive processing stages, \n
e.g., selection of optimal stacking velocities, killing bad data traces, \n
or spectral analysis requires advanced flows beyond the scope of \n
introductory classes. In a research setting, special functionality \n
rom other free seismic processing software such as SioSeis (UCSD-NSF) \n
can be incorporated readily via an object-oriented style to programming. \n
An object oriented approach is a first step toward efficient extensible \n
programming of multi-step processes, and a simple GUI simplifies \n
parameter selection and decision making. Currently, in L_SU, \n
Perl 5 packages wrap nearyly 300 SU modules that are used in teaching \
undergraduate and first-year graduate student classes (e.g., filtering, \
display, velocity analysis and stacking). Perl packages (classes) can \
advantageously add new functionality around each module and clarify \
parameter names for easier usage. For example, through the use of methods, \
packages can isolate the user from repetitive control structures, \
as well as replace the names of abbreviated parameters with \n
elf-describing names. Moose, an extension of the Perl 5 object system, \
greatly facilitates an object-oriented style. Perl wrappers are \
self-documenting via Perl programming document markup language.\n");

	
    return ( \@message );
}

1;

