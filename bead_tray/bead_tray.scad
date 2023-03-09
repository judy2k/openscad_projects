
$fn=30;

module dot() {
    sphere(d=0.4);
}

difference() {
    hull()
    for (angle = [0, 120, 240]) {
        rotate([0, 0, angle])
        translate([35, 0, 0]) {
            sphere(d=0.4);
            translate([5, 0, 10])
                sphere(d=0.4);
        }

    }

    hull()
    for (angle = [0, 120, 240]) {
        rotate([0, 0, angle])
        translate([25, 0, 2]) {
            sphere(d=3);
            translate([14, 0, 8.3])
                sphere(d=0.1);
        }

    }
}