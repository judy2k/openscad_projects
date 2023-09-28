include <BOSL/constants.scad>
include <BOSL/shapes.scad>
include <BOSL/transforms.scad>

charger_x = 57.5;
charger_y = 26.75;
charger_z = 90;
charger_corner_r = 4;

bracket_gap = 0.3;
bracket_thickness = 1.6;    // 4 perimeters;
floor_thickness = 1.2;      // 6 layers @ 0.2 (or ~4 at 0.3);

module __no_params_after_this() {}

finangle = 0.01;
$fa = 1;
$fs = 1;

module charger(width, height, depth, corner_r) {
    up(finangle)
    color("red")
    cuboid(
        [width, height, depth],
        align=V_TOP + V_BACK, fillet=corner_r, edges=EDGES_Z_ALL);
    
}

module bracket(width, height, depth, corner_r, wall_thickness, floor_thickness, gap) {
    difference() {
        // Outside perimeter:
        fwd(gap + wall_thickness)
        down(floor_thickness)
        cuboid(
            [width + gap * 2 + wall_thickness * 2, height + gap * 2 + wall_thickness * 2, depth + floor_thickness],
            align=V_TOP + V_BACK, fillet=corner_r + gap + wall_thickness, edges=EDGES_Z_BK);

        // Cut out space for charger:
        fwd(gap)
        cuboid(
            [width + gap * 2, height + gap * 2, depth + finangle],
            align=V_TOP + V_BACK, fillet=corner_r + gap, edges=EDGES_Z_ALL);
        
        // Cut out a hole in the bottom for the power cable:
        up(finangle)
        back(5)
        cuboid([22, 12, 10+finangle], align=V_BOTTOM + V_BACK, fillet=1.5, edges=EDGES_Z_ALL);
        
        // Put dips on either side of the top rim to allow grip on the charger:
        cutout_d = (height - corner_r * 2) * 0.8;
        back(height / 2)
        up(depth)
        yrot(90)
        cylinder(d=cutout_d, h= width + (wall_thickness + gap + finangle) * 2, center=true);
    }
}

*charger(charger_x, charger_y, charger_z, charger_corner_r);
bracket(charger_x, charger_y, charger_z, charger_corner_r, bracket_thickness, floor_thickness, bracket_gap);