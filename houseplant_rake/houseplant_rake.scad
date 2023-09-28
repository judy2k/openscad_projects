
include <BOSL/shapes.scad>

tine_count = 5;
tine_gap = 5;
tine_width = 3;
tine_length = 25.4;

rake_thickness=3;
rake_width = tine_width * tine_count + tine_gap * (tine_count - 1);

module tine() {
    $fn = 10;
    cube([tine_width, rake_thickness, tine_length-tine_width/2]);
    translate([tine_width/2,rake_thickness,tine_length-tine_width/2])
    rotate([90, 0, 0])
    cylinder(d=tine_width, h=rake_thickness);
}

/*translate([0,0,-tine_width])
    cube([tine_width * tine_count + tine_gap * (tine_count - 1), tine_width, tine_width]);
    */
    
    


union() {
    difference() {
        translate([rake_width/2, rake_thickness, 0])
        rotate([90, 0, 0])
            cylinder(h=rake_thickness, d=rake_width);
        upcube(rake_width * 3);
    }
        
    for (i = [0: tine_count - 1]) {
    translate([(tine_width + tine_gap) * i, 0, 0])
        tine();
    }
}