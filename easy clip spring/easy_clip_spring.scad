include <BOSL/shapes.scad>
include <BOSL/transforms.scad>
include <BOSL/constants.scad>


module end() {
    difference() {
        union() {
            cuboid([15, 2, 9.5], align=V_BACK);
            back(1.99) cuboid([10, 4.01, 9.5], align=V_BACK);
        }

    }
}

module part(screw_d = 7.8) {
    screw_gap = 0.6;

    difference() {
        union() {
            forward(15)  end();
            zrot(180) forward(15) end();
            
            spring();
            
            yrot(180) spring(); 
        }
        
        xrot(90) hex(w=screw_d + screw_gap, h=30.2);
    }
}

module hex(w=1, h=1) {
    zrot(45/2) cyl(d=w, h=h, circum=true, $fn=8);  
}

module spring(r=28, t=1.2, spring_gap = 2.5) {
    intersection() {
        left(r - 7) tube(or=r, wall=t, h=9.5 - spring_gap * 2, center=true, $fn=100);
        cuboid([30, 30, 9.5]);
    }
    
    cyl(d=t, h=spring_gap);
}



color("blue")  part();