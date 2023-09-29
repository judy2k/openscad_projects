include <BOSL/shapes.scad>
include <BOSL/involute_gears.scad>

$fn=100;

wall_thickness=1.2;
width = 30;
inner_width = width - wall_thickness * 2;
depth = 10;
inner_depth = depth - wall_thickness;

// Gear
difference() {
    union() {
        gear(mm_per_tooth=3, thickness=5, hole_diameter=0);
        
        
    }
    
    cyl(d=3, h=80, center=true);
}

color("green") union() {
    intersection() {
        fwd(pitch_radius(mm_per_tooth=3, number_of_teeth=12))
            rack(mm_per_tooth=3, height=5, thickness=5);
        cube([inner_width - .2, inner_width, inner_depth ], center=true);
    }
    
    right(inner_width/ 2 - 0.1)
        leftcube([2, 19, 5]); 
    
    right(inner_width / 2 - 0.2)
        xcyl(d=5, h=10, align=V_RIGHT);
}


zrot(180)
color("green")
union() {
    intersection() {
    fwd(pitch_radius(mm_per_tooth=3, number_of_teeth=12))
    right(1.5)
        rack(mm_per_tooth=3, height=5, thickness=5);
        cube([inner_width - .2, inner_width, inner_depth ], center=true);
    }
    
    right(inner_width/ 2  - 0.1)
        leftcube([2, 19, 5]); 
    
    right(inner_width / 2 - 0.2)
        xcyl(d=5, h=10, align=V_RIGHT);
}

color("red") union() {
    // Axle:
    downcyl(d=2.7, h=10);
    // Cog Rest:
    down(2.6)
        downcyl(r=root_radius(mm_per_tooth=3, number_of_teeth=12) * 0.8, h=inner_depth - 2.6);

    difference() {
        // Outer cube:
        downcube([width, width, depth]);
        // Inner cube:
        up(.01)
        downcube([inner_width, inner_width, inner_depth ]);
        
        xcyl(d = 5 + 0.4, h= width * 1.1);
    }
    
    // Rail rest 1:
    translate([0, -inner_width /2, -2.6])
        cuboid([inner_width, 6.5, inner_depth -2.6], align=V_DOWN + V_BACK);
        
    fwd(inner_width/ 2)
        cuboid([inner_width, 4, inner_depth], align=V_DOWN + V_BACK);
    
    zrot(180) {
        // Rail rest 2:
        translate([0, -inner_width /2, -2.6])
            cuboid([inner_width, 6.5, inner_depth -2.6], align=V_DOWN + V_BACK);
            
        fwd(inner_width/ 2)
            cuboid([inner_width, 4, inner_depth], align=V_DOWN + V_BACK);
    }
}

