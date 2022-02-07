// Puffy Diamond Generator

$fn = 32;
edge_radius = 7;

split(30, 35)
diamond()
    sphere(r=edge_radius);

module diamond() {
    hull() {
        children();
        
        translate([0, 0, 30]) {
            _hexme(20)
                children();
            
            rotate([0,0, 360/16])
            translate([0, 0, 10])
                _hexme(13)
                    children();
        }
    }
}

module _hexme(R) {
    for (a = [0:360/8:359]) {
        rotate([0, 0, a])
        translate([R, 0, 0])
        children();
    }
}

module split(z, t) {
    translate([t, 0, 0])
    rotate([0, 180, 0])
    translate([0,0,-z])
    intersection() {
        difference() {
            children();
            translate([0, 0, z])
            rotate([0, 90, 0])
            biscuit(0.8, 0.2, 0.2);
        }
        translate([0,0,z-500])
        cube([1000, 1000, 1000], center=true);
    }
    
    translate([-t, 0, 0])
    translate([0, 0, -z])
    intersection() {
        difference() {
            children();
            translate([0, 0, z])
            rotate([0, 90, 0])
            biscuit(0.8, 0.2, 0.2);
        }
        translate([0,0,z+500])
        cube([1000, 1000, 1000], center=true);
    }
    
    rotate([90, 0, 0])
    biscuit();
}

module biscuit(margin_x=0, margin_y=0, margin_z=0) {
    cube([5 + margin_x, 1 + margin_y , 25 + margin_z], center=true);
}