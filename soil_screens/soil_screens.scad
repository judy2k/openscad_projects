include <hex_map.scad>
include <BOSL/masks.scad>
include <BOSL/transforms.scad>

module soil_screen(outer_d=100, rim_thickness=1.6, base_thickness=1.2, height=20) {
    $fn=100;
    inner_d = outer_d - (rim_thickness * 2);
       
    intersection() {
        difference() {
            cylinder(d=outer_d, h=height);

            translate([0,0,base_thickness * 2])
                cylinder(d=inner_d, h=height);
            translate([0,0, base_thickness])
                cylinder(d1 = inner_d - (2 * rim_thickness), d2=inner_d, h=base_thickness * 1.001);
            rotate([180,0,0])
                chamfer_cylinder_mask(r=outer_d/2, chamfer=rim_thickness);
            translate([0,0,height-rim_thickness+0.001])
                cylinder(d2=outer_d, d1=inner_d, h=rim_thickness);
                
            
            color("red")
            translate([0,0,base_thickness / 2])
            intersection() {
                translate([0, 0, -base_thickness * 3/2])
                concentric_hex(side=3, h=base_thickness * 3, space=1.2, repeats=7);
                cylinder(d=inner_d - (2 * rim_thickness), h= base_thickness * 2, center=true);
            }
        }
    }
}

soil_screen();

