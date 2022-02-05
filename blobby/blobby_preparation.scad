// Prepare the contents of blobby.stl for printing

seed = 4;

blob_size = 15;
quick=true;

use <mo_random.scad>;

module biscuit(margin_x=0, margin_y=0, margin_z=0) {
    cube([5 + margin_x, 1 + margin_y , 8 + margin_z], center=true);
}

module subtract_biscuit() {
    difference() {
        children();
        biscuit(0.8, 0.2, 0.2);
    }
}

module prepare(i) {
    translate([-20,0,0])
    rotate([0, 90, 0])
    
    difference() {
        subtract_biscuit() {
            intersection() {
                translate([-250,0,0])
                cube([500,500,500], center=true);
                children();
            }
        }
        translate([-0.5, 1, 0])
        rotate([0,90,0])
        linear_extrude(1)
            text(str(i), halign="center");
    }

    translate([20,0,0])
    rotate([0, -90, 0])
    difference() {
        subtract_biscuit() {
            intersection() {
                translate([250,0,0])
                cube([500,500,500], center=true);
                children();
            }
        }
    
        translate([0.5, 1, 0])
        rotate([0,-90,0])
        linear_extrude(1)
            text(str(i), halign="center");
    }

    rotate([90,0,0])
    biscuit();
}

prepare("J")
    mo_random(blob_size, seed, quick);
