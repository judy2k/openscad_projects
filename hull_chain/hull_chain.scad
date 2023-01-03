module hull_chain(close=false) {
    union () {
        for (i = [0 : $children - 2]) {
            hull() {
                children(i);
                children(i+1);
            }
        }
        hull() {
            if (close) {
                children(0);
                children($children - 1);
            }
        }
    }
}

hull_chain(true) {
    $fn=20;
    cylinder(d = 1);
    
    translate([0, 10, 0]) {
        cylinder(d = 2, h=2);
    }
    translate([10, 10, 0]) {
        cylinder(d = 1);
    }
    translate([10, 0, 0]) {
        cylinder(d = 2, h = 0.1);
    }
}