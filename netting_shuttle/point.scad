include <BOSL/shapes.scad>
include <BOSL/transforms.scad>

$fn = 100;

module pointy(w, l, h=1) {
    //R = (l * l + w * w / 4) / w;
    
    R = l * l / w + w  / 4;
    
    difference() {
        intersection() {
            left(R - w/2)
                cylinder(r=R, h=h, center = true);
            
            right(R - w/2)
                cylinder(r=R, h=h * 2, center = true);
        }
        fwdcube([w, l, h * 1.1], );
    }
}

%cuboid([20, 30, 0.5],
    align=V_BACK
);
#pointy(w= 20, l=30);