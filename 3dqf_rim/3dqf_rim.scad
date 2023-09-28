/*
 * The side disc of a 3DQF filament spool.
 *
 *  Originally modelled as a precursor to designing a slightly better spool rim.
 */

include <BOSL/shapes.scad>

$fn=100;



union() {
        color("brown")
        zcyl(h=6, d=198, align=V_UP);
}
