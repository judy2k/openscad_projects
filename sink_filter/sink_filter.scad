/*
 * Plug Filter
 * -----------
 * Not particularly clever, but useful, plughole filter for my bathroom sink,
 * while we're washing dishes there during our kitchen refurbishment.
 */

// Slightly wider top diameter of plughole
plughole_upper_diameter = 37;
// Slightly narrower bottom diameter of plughole
plughole_lower_diameter = 35;
// Depth of plughole
plughole_depth = 12;

// Thickness of the filter perimeters
thickness = 1;

module __end_of_params__() {}

hole_d = 3;
hole_spacing = 1.6;

// $fn = 10;
$fa = 3;
$fs = 1;

finangle = 0.1;

module cutout() {
    $fn = 15;
    translate([0,0,plughole_depth - thickness - finangle])
    scale([1,1,thickness + (2 * finangle)])
        cylinder(d=hole_d, h=1);
}

module cutout_ring(offset, count) {
    for (i = [1:count]) {
        rotate([0,0,i * (360/count)])
        translate([offset, 0, 0])
            cutout();
    }
}

module cutout_rings(ring_multiplier, rings) {
    for (i = [1:rings]) {
        cutout_ring(i * (hole_d + hole_spacing), i * ring_multiplier);
    }
}

module filter(
        plughole_upper_diameter=plughole_upper_diameter,
        plughole_lower_diameter=plughole_lower_diameter,
        plughole_depth=plughole_depth) {
    difference() {
        cylinder(d1=plughole_upper_diameter, d2=plughole_lower_diameter, h=plughole_depth);
        translate([0, 0, -finangle])
            cylinder(
                d1=plughole_upper_diameter - (2 * thickness),
                d2=plughole_lower_diameter - (2 * thickness),
                h=plughole_depth - thickness +finangle);
        
        cutout();
        cutout_rings(5, 3);
    }
}

filter();