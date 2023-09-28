// The height to raise the webcam by. (The thickness of the shim.)
rise_height = 4;

// The width (left-to-right) of the webcam bracket as it rests on the monitor.
webcam_bracket_width = 50;

// The depth of the monitor frame (front-to-back).
monitor_depth = 22;

module __no_more_params__() {}

rail_height = 2;
rail_thickness = 1.2;


difference() {
    cube([
            webcam_bracket_width + rail_thickness * 2,
            monitor_depth + rail_thickness * 2,
            rise_height + rail_height + rail_height,
        ],
        center=true);
        
    translate([0,0,(rise_height + rail_height + rail_height)/2 - rail_height/2+ 0.01 ])
        #cube([
            webcam_bracket_width,
            monitor_depth + rail_thickness * 2 + 0.01,
            rail_height + 0.01,
        ],
        center=true
        );

    translate([0,0,-(rise_height + rail_height + rail_height)/2 + rail_height/2 - 0.01])
        #cube([
            webcam_bracket_width + rail_thickness * 2 + 0.01,
            monitor_depth,
            rail_height + 0.01,
        ],
        center=true);
}