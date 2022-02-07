// Cable Thickness (mm)
g_cable_d = 4; // [1:0.1:6]

// Cable Loops
g_cable_loops = 5; // [2:10]

// Clip Thickness
g_clip_thickness = 1.2; // [1.2:0.4:3.2]

// Below are not customizer vars.
module __Customizer_Limit__ () {}

$fn=40;

// Clip Height
g_clip_height = 5;

module clip(cable_d, cable_loops, clip_thickness, clip_height, debug=false) {
    cutout_height = clip_height + 0.1;
    cutout_translate = [0,0,-0.05];
    
    if (debug) {
        // Loops:
        #color("blue") loops(cable_d, cable_loops, clip_thickness, clip_height);
    }
    
    difference() {
        hinge_finangle = 0.4;
        // Adding a value to the clip_thickness so it becomes "minimum" clip thickness
        // due to the slightly enlarged hinge cutout:
        outer_shape(cable_d, cable_loops, clip_thickness + hinge_finangle/2, clip_height, debug);
        
        translate(cutout_translate) {
            // The first cutout is slightly bigger - allows sliding, and means
            // if the tolerances are tight the hinge won't be wedged slightly open.
            cylinder(d=cable_d + hinge_finangle, h=cutout_height);
            hull() {
                translate([cable_d * 0.8,0,0]) cylinder(d=cable_d, h=cutout_height);
                translate([cable_d * (cable_loops-1),0,0]) cylinder(d=cable_d, h=cutout_height);
            }
        }
    }
}

module outer_shape(cable_d, cable_loops, clip_thickness, clip_height, debug) {
    cable_r = cable_d / 2;
    
    // Outer Shell:
    union() {
        hull() {
            cylinder(r=cable_r + clip_thickness, h=clip_height);
            translate([cable_d * (cable_loops - 1), 0, 0])
                translate([0,-(cable_r + clip_thickness),0])
                cube([0.0001, 2 * (cable_r + clip_thickness), clip_height]);
                //cylinder(r=cable_r + clip_thickness, h=clip_height);
            
        }

        translate([cable_d * (cable_loops - 1), 0, 0]) {
            // Top Triangle:
            triangle(cable_d, clip_thickness, clip_height);
        
            // Bottom Triangle:
            translate([0,0,clip_height])
            rotate([180, 0, 0])
                triangle(cable_d, clip_thickness, clip_height);
        }
    }
}

module triangle(cable_d, clip_thickness, clip_height) {
    cable_r = cable_d / 2;

    triangle_corner = 0.2;  // Radius of most of the triangle points
    end_corner = clip_thickness / 2; // Divided by two because it's a radius
    clip_ease = cable_d; // "Pointiness of clip arms
    finangle = 0.05; // Just move the touching parts away, so they're not joined.

    hull() {
            translate([0, cable_r + clip_thickness - triangle_corner, 0])
                cylinder(r=triangle_corner, h=clip_height);
            translate([0, cable_r + triangle_corner, 0])
                cylinder(r=triangle_corner, h=clip_height);
            // Inside point:
            translate([cable_r + triangle_corner, triangle_corner + finangle, 0])
                cylinder(r=triangle_corner, h=clip_height);
            // This is the pointy-end:
            translate([clip_ease, cable_r + clip_thickness - end_corner, 0])
                cylinder(r=end_corner, h=clip_height);
        }
    }

module loops(cable_d, cable_loops, clip_thickness, clip_height) {
    height = clip_height + 1;
    for (loop = [0 : cable_loops - 1]) {
        translate([cable_d * loop,0,-0.5])
            cylinder(d=cable_d, h=height, $fn=20);
    }
}

clip(g_cable_d, g_cable_loops, g_clip_thickness, g_clip_height);