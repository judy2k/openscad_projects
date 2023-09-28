/**
 * Model of a V60 filter cone. A stand for unfolded paper filters.
 */

include <BOSL/constants.scad>;
include <BOSL/shapes.scad>;

$fn=100;

cone_side = 120;
c = PI * cone_side;
base_rad = c / (2 * PI);
cone_height = sqrt(cone_side ^ 2 - base_rad ^ 2);



module cone() {
    intersection() {
        union() {
            up(20)
            cyl(h=cone_height, r1=base_rad, r2=0, align=V_UP);
            zcyl(h=20, r=base_rad, align=V_UP);
        }
        
        zcyl(h=cone_height + 10, r=base_rad * 0.8, align=V_UP);
    }
}

module vanes() {
    vane_height = 20 + cone_height;
    //vane_height = 0.2;

    vane_angle = 30;
    vane_d = 1.6;
    interior_fillet = 5;
    
    
    union() {
        zcyl(h=vane_d, r=base_rad * 2, align=V_UP);
        for(i = [0: vane_angle: 179.99]) {
            rotate([0,0,i]) {
            upcube([base_rad * 2.5, vane_d, vane_height]);
            
            translate(vane_d * 2 * [cos(15), sin(15), 0] * 0.97)
            interior_fillet(ang=vane_angle, l=vane_height, r=interior_fillet, orient=ORIENT_Z, align=V_UP);
            
            rotate([0,0, 180])
            translate(vane_d * 2 * [cos(15), sin(15), 0] * 0.97)
            interior_fillet(ang=vane_angle, l=vane_height, r=interior_fillet, orient=ORIENT_Z, align=V_UP);
            }
        }
    }
    
    
    
}

module main() {
    intersection() {
        cone();

        vanes();
    }
    
}

main();