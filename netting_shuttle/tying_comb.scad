include <BOSL/transforms.scad>
include <BOSL/shapes.scad>

tines = 5;
tine_width = 2;
tine_length = 10;
space_width = 3;
comb_thickness = 2;

spine_length = tines * tine_width + space_width * (tines - 1);

// Comb spine:
cuboid(
    [spine_length, tine_width, comb_thickness],
    fillet = 1,
    edges = EDGES_Z_BK,
    align = V_FRONT
    );
    
// Tines:
cuboid([tine_width, tine_length, comb_thickness]);