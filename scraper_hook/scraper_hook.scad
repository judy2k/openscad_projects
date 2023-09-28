include <BOSL/shapes.scad>
include <BOSL/transforms.scad>

hex_width = 12.5;
hook_depth = 7;
back_side = 19.2;
back_depth = 1;

module __no_params_after() {}

hex_r = hex_width / 2;

module regular_polygon(sides=6, r=1, h=1) {
    cylinder(r=r, $fn=sides, h=h);
}

union() {
    regular_polygon(r=hex_r, h=hook_depth);
    cuboid([back_side, back_side, back_depth], fillet=back_depth / 2, edges=EDGES_TOP);
    up(hook_depth)
        cylinder(r1=hex_r, r2=4/5 * hex_r, $fn=6);
}