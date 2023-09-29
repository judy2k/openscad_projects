include <BOSL/shapes.scad>

module rib(jig_thickness, reinforcement_height) {
    // A rib designed to be repeated around a hole.
    // The rib should grip a bamboo pole, while also allowing the bamboo to compress around it.
    down(jig_thickness - 0.4)
    cyl(r=0.3, h=jig_thickness - 0.4 + reinforcement_height, align=V_UP, $fn=20);
}

module jig() {
    jig_thickness = 1;
    reinforcement_height = 2;
    rod_d = 3.5;
    rod_shift = 6;
    
    rod_r = rod_d/2;

    
    union() {
        difference() {
            union() {
                cuboid([(rod_shift + rod_d + 0.4*4) * 2, (rod_shift + rod_d + 0.4*4) * 2, jig_thickness], align=V_DOWN, fillet=rod_r + 0.4*4, edges=EDGES_Z_ALL, $fn=20);
                
                for (z = [0: 90: 270]) {
                    zrot(z)
                    translate([rod_shift + rod_r,rod_shift + rod_r,0]) {
                        // rod:
                        //cyl(d=rod_d, h=100, $fn=20);
                        
                        // Reinforcement:
                        cyl(r1=rod_r + 0.4*4, r2=rod_r + 0.4*1,  h=reinforcement_height, align=V_UP, $fn=30);
                    }
                }
            }
            
            // Holes for rods:
            for (z = [0: 90: 270]) {
                zrot(z)
                translate([rod_shift + rod_r,rod_shift + rod_r,0]) {
                    // rod:
                    cyl(d=rod_d, h=100, $fn=20);
                }
            }
        }
    
        // Add ribs for the holes:
        for (z = [0: 90: 270]) {
            zrot(z)
            translate([rod_shift + rod_r,rod_shift + rod_r,0]) {
                for (z = [0: 45: 359]) {
                    zrot(z)
                    back(rod_r)
                    rib(jig_thickness, reinforcement_height);
                }
            }
        }
    }
}

jig();