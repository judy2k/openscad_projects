include <BOSL/shapes.scad>

frame_thickness = 5;
unit_size = 14;

module __no_more_params__();
unit = unit_size;
two_units = unit_size * 2;

module piece(x, y, height=5, finangle=0.25) {
    corner_radius = 1;

    indent_depth = 0.8;
    indent_sphere_radius = 13;

    $fs=0.3;
    $fa = 5;
    difference() {
        translate([0, 0, height/2])
            cuboid([x - finangle,y - finangle,height], fillet=corner_radius, edges=EDGES_Z_ALL);
        translate([0, 0, height + indent_sphere_radius - indent_depth])
            sphere(r=indent_sphere_radius);
    }
}

module whole_frame() {
    $fs = 0.1;
    $fa = 5;
    difference() {
        translate([0, 1.5 * unit, 3])
            cuboid([4 * unit + frame_thickness * 2, 5 * unit + frame_thickness * 2, 7], fillet=3, edges=EDGES_Z_ALL);
        // Play space:
        translate([-2 * unit, -unit, 0])
            cube([4 * unit, 5 * unit, unit]);
        
        // Opening:
        translate([-unit - 0.5, 4 * unit - 0.5, 0])
            cube([2 * unit + 1, frame_thickness + 1, 3.5]);
    }
}

module frame_top() {
    difference() {
        whole_frame();
        
        
        union() {
            difference() {
                translate([0, 1.5 * unit, -1.2])
                    upcube([4 * unit + frame_thickness * 2 + 1, 5 * unit + frame_thickness * 2 + 1, 1.2 + 3.5]);
                
                translate([-2 * unit - frame_thickness/2, -unit - frame_thickness/2, 0.01])
                        cube([4 * unit + frame_thickness, 5 * unit + frame_thickness, unit]);
            }
            
            translate([0, 1.5 * unit,0.2])
                downcube([4 * unit + frame_thickness * 2 + 1, 5 * unit + frame_thickness * 2 + 1, 100]);
        }
    }
}

module frame_bottom() {
    finangle = 0.1;

    union() {
        difference() {
            whole_frame();
            
            translate([0, 1.5 * unit, 3.5 - 0.01])
                upcube([4 * unit + frame_thickness * 2 + 1, 5 * unit + frame_thickness * 2 + 1, 10]);
            
            translate([-2 * unit - frame_thickness/2, -unit - frame_thickness/2, 0.01])
                        cube([4 * unit + frame_thickness, 5 * unit + frame_thickness, unit]);
        
        }
       
    }
}

module frame_cutting_tool() {
    
}

module frame() {
    frame_top();
    frame_bottom();
}

module explode(enable) {
    if (enable) {
        for ( i= [0:1:$children-1]) {
            translate([0, 0, i * 10])
                children(i);
        }
    } else {
        children();
    }
}

module winning_piece() piece(two_units, two_units, height=3);
module unit_piece() piece(unit, unit);
module long_piece() piece(unit, two_units);
module wide_piece() piece(two_units, unit);

module complete_puzzle(mockup)
    explode(!mockup) {
        winning_piece();
        /*
        translate([0, 2.5 * unit, 0]) {
            translate([unit / 2, 0, 0])
                unit_piece();
            translate([-unit / 2, 0, 0])
                unit_piece();
        }
        translate([0, 3.5 * unit, 0]) {
            translate([unit / 2, 0, 0])
                unit_piece();
            translate([-unit / 2, 0, 0])
                unit_piece();
        }

        translate([0, 1.5 * unit, 0])
            wide_piece();

        translate([1.5 * unit, 0, 0]) {
            long_piece();
            translate([0, 2 * unit, 0])
                long_piece();
        }

        translate([-1.5 * unit, 0, 0]) {
            long_piece();
            translate([0, 2 * unit, 0])
                long_piece();
        }*/

        frame();
    }
    
module unique_parts() {
    explode(true) {
        frame_top();
        frame_bottom();
        winning_piece();
        unit_piece();
        long_piece();
    }
}

//complete_puzzle(true);
unique_parts();

