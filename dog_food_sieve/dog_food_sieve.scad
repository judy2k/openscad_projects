include <BOSL/masks.scad>
include <BOSL/transforms.scad>



module concentric_hex(side, h, space, repeats) {
    short_r = sqrt(3) * side + space;
    if (repeats > 0) {
        cylinder(r=side, h=h, $fn=6);
    }
    for (hex_side=[0:5]) {
        rotate([0,0,hex_side * 60])
        for (ring=[1:repeats-1]) {
            translate([0, ring  * short_r, 0])
            rotate([0,0, -120])
            for (cell=[0:ring]) {
                translate([0, short_r * cell, 0])
                cylinder(r=side, h=h, $fn=6);
            }
        }
    }
}


module food_seive(outer_d=100, rim_thickness=1.6, base_thickness=1.5, height=50) {
    $fn=100;
    inner_d = outer_d - (rim_thickness * 2);
       
    intersection() {
        difference() {
            cylinder(d=outer_d, h=height);

            translate([0,0,base_thickness * 2])
                cylinder(d=inner_d, h=height);
            translate([0,0, base_thickness])
                cylinder(d1 = inner_d - (2 * rim_thickness), d2=inner_d, h=base_thickness * 1.001);
            *rotate([180,0,0])
                chamfer_cylinder_mask(r=outer_d/2, chamfer=rim_thickness);
            translate([0,0,height-rim_thickness+0.001])
                cylinder(d2=outer_d, d1=inner_d, h=rim_thickness);
                
            
            color("red")
            translate([0,0,base_thickness / 2])
            intersection() {
                translate([0, 0, -base_thickness * 3/2])
                concentric_hex(side=4.2, h=base_thickness * 3, space=1.2, repeats=6);
                cylinder(d=inner_d - (2 * rim_thickness), h= base_thickness * 2, center=true);
            }
        }
    }
}

food_seive();
    

//concentric_hex(side=3, h=0.1 * 3, space=1.2, repeats=7);