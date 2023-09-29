include <BOSL/shapes.scad>

module eclipse_cylinder(d1, d2, h) {
    difference() {
        cylinder(h=h, d=d1, center=true);
        right((d2 - d1 / 2) * 1.001)
            cuboid([d1-d2, d1, h * 1.002], align=V_RIGHT);
    }
}

$fn = 30;
eclipse_cylinder(5.85, 4.85, 1.1);