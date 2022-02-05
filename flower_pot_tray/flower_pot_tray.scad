$fn = 500;

thickness = 0.4 * 10;
interior_height = 10;



difference() {
    // Exterior:
    cylinder(d1 = 80 + thickness * 2, d2 = 85 + thickness * 2, h=interior_height + thickness);
    // Interior:
    translate([0,0,thickness])
        cylinder(d1 = 80, d2=85, h=interior_height + 0.1);
}