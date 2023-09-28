base_thickness = 0.6;
wall_thickness = 1.2;
inner_diameter = 100;
height = 15;

$fn = 80;

module tray() {
    union() {
        difference() {
            cylinder(d=inner_diameter + (wall_thickness * 2), h=height);
            translate([0,0,base_thickness])
                cylinder(d=inner_diameter, h=height);
        }
        torus();
    }
}

module torus() {
    translate([0, 0, height])
    rotate_extrude()
    translate([(inner_diameter + wall_thickness) / 2, 0, 0])
        circle(d=wall_thickness);
}

tray();