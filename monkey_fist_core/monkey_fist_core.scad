/**
 * A relatively quick, simple-to-print core, to go inside a monkey's fist knot.
 *
 * Takes about 3 minutes at .3mm layers, with 2 perimeters.
 * The tabs on the bottom are simple to remove, and provide extra support while printing.
 * A size of 11 (or maybe 12) works well with standard paracord.
 */
include <BOSL/shapes.scad>

SIZE = 11;

module shape_printable(size) {
    chamfer = size / 3.3; // 3.3 is a magic number.

    union() {
        up(size/2)
        cuboid(size=size, chamfer=chamfer);

        for (x = [0: 90: 270]) {
            zrot(45 + x)
            fwd(0.3 + chamfer/2 * 1.7)
            teardrop(ang=35, l=0.22, orient=ORIENT_Z, align=V_FWD + V_UP, $fn=20);
        }
    }
}


shape_printable(SIZE);
