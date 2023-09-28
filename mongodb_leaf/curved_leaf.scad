include <BOSL/transforms.scad>
include <BOSL/shapes.scad>

$fn=100;

module leaf_body() {
    xrot(90)
    rotate_extrude(angle=180)
        import("mongodb_half_logo.svg");
}

module leaf_cutout() {
    linear_extrude(30)
    fwd(11.5)
    xrot(180)
    translate([-2.13,0,0])
        import("mongodb_leaf_cutout.svg");
}

scale([1,1,0.5])
difference() {
    leaf_body();
    up(2)
    leaf_cutout();
}
