include <BOSL/shapes.scad>

size = 11;
chamfer = 10 / 3;



points = [
    [0,0,0],
    [-chamfer, -chamfer/2, 0],
    [-chamfer, chamfer/2,  0],
    
    [-chamfer, 0, chamfer],
];
faces = [
    [0,2,1],
    [0,1,3],
    [0,3,2],
    [1,2,3],
];

module support() {
    
    polyhedron(points, faces);
}

module shape() {
    cuboid(size=size, chamfer=chamfer);
}

// Includes tabs for stability
module shape_printable() {
    union() {
        up(size/2)
        shape();

        for (x = [0: 90: 270]) {
            zrot(45 + x)
            fwd(0.3 + chamfer/2 * 1.4)
            teardrop(ang=35, l=0.22, orient=ORIENT_Z, align=V_FWD + V_UP, $fn=20);
        }
    }
}

module rib(jig_thickness, reinforcement_height) {
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

shape_printable();
//jig();