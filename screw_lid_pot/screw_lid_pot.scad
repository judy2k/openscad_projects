include <BOSL/shapes.scad>
include <BOSL/transforms.scad>
use <BOSL/threading.scad>

PRINTER_SLOP = 0.15;
$fa=1;
$fs=1;

thread_pitch = 1.2;


trapezoidal_threaded_rod(d=20, l=5.5, pitch=thread_pitch, starts=2);

down(6)
trapezoidal_threaded_rod(d=20, l=5.5, pitch=thread_pitch);


/*difference() {
cylinder(d=22.6, h=5.499, center=true);
trapezoidal_threaded_rod(d=20, l=5.5, pitch=thread_pitch, starts=2, internal=true);
}*/
