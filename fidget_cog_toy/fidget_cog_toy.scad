//include <BOSL/involute_gears.scad>
use <BOSL/involute_gears.scad>


$fn=30;
hole = 2.05;

fidget();

module panel(h=5) {
    $fn=100;
    union() {
        hull() {
            cylinder(h=h, d=11, center=true);
            translate([20.4, 0, 0])
                cylinder(h=h, d=30, center=true);
        }
        translate([0,0,h/2 + 0.09])
            washer();
        translate([20.4,0,h/2 + 0.09])
            washer();
    }
}

module washer() {
    difference() {
        cylinder(h=0.22, d=5, center=true);
        cylinder(h=0.22 * 1.1, d=hole, center=true);
    }
}

module fidget() {
    rotate([0, 0, 8.5]) {
        //cylinder(h=20, d=hole, center=true);
        gear(number_of_teeth=11, hole_diameter=hole+0.2);
    }

    translate([20.4, 0, 0])
        rotate([0, 0, 2.7]) {
            //cylinder(h=20, d=hole, center=true);
            gear(number_of_teeth=31, hole_diameter=hole+0.2);
        }

    color("red")
        difference() { 
            union() {
                rotate([180, 0, 0])
                    translate([0, 0, -6])
                        panel();
                    
                translate([0, 0, -6])
                    panel();
            }
            
            cylinder(h=20, d=hole, center=true);
            translate([20.4, 0, 0])
                    cylinder(h=20, d=hole, center=true);
        }
}