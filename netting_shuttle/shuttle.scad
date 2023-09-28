include <BOSL/constants.scad>
include <BOSL/transforms.scad>
include <BOSL/shapes.scad>



module shuttle(length, width, pin_length=undef, rib_thickness=undef) {
    pin_length =  is_undef(pin_length) ? length / 4: pin_length;
    pointiness = 0.9; // Minimum value: 0.5
    point_length = width * pointiness;
    body_length = length - point_length;
    shuttle_width = width;

    shuttle_height = 1;
    rib_thickness = is_undef(rib_thickness) ? shuttle_width / 5 : rib_thickness;
    
    standard_fillet = rib_thickness / 2;
    
    inner_width = shuttle_width - rib_thickness * 2;
    
    pin_thickness = rib_thickness;
    front_wind_area = pin_length * inner_width - pin_length * pin_thickness;
    
    rear_depth = front_wind_area / inner_width;
    

    union() {
        difference() {
            cuboid([shuttle_width, body_length, shuttle_height],
                align=V_BACK);

            // Rear cut-out:
            forward(0.01)
            cuboid([inner_width, rear_depth, shuttle_height * 1.1],
                fillet=standard_fillet,
                edges=EDGE_BK_RT + EDGE_BK_LF,
                align=V_BACK);
            
            // Front cut-out:
            back(body_length + 0.01)
            cuboid([inner_width, pin_length, shuttle_height * 1.1],
                fillet=standard_fillet,
                edges=EDGE_FR_RT + EDGE_FR_LF,
                align=V_FRONT);
                
            // Middle cut-out:
            middle_length = body_length - pin_length - rear_depth - rib_thickness * 2;
            
            if ( middle_length > rib_thickness ) {
                back(rear_depth + rib_thickness)
                cuboid([inner_width, middle_length, shuttle_height * 1.1],
                    fillet=standard_fillet,
                    edges=EDGE_FR_RT + EDGE_FR_LF + EDGE_BK_RT + EDGE_BK_LF,
                    align=V_BACK);
            }
            
        }
        
        // Pin:
        back(body_length - pin_length - 0.01)
        cuboid([pin_thickness, pin_length, shuttle_height],
            fillet=standard_fillet,
            edges=EDGE_BK_RT + EDGE_BK_LF,
            align=V_BACK);
        
        // Internal fillets for pin:
        translate([pin_thickness / 2 - 0.01, body_length - pin_length - 0.01, 0])
            interior_fillet(l=shuttle_height, r=standard_fillet,  orient=ORIENT_Z);
        translate([-pin_thickness / 2 + 0.01, body_length - pin_length - 0.01, 0])
            yrot(180)
            interior_fillet(l=shuttle_height, r=standard_fillet,  orient=ORIENT_Z);
        
        
        // Point
        back(body_length - 0.01)
            difference() {
                pointy(shuttle_width, point_length, h=shuttle_height);
                yscale(0.8)
                cylinder(d=inner_width, h=shuttle_height * 1.1, center=true);
            }
        
    } // union
} // module shuttle


module pointy(w, l, h=1) {
    R = l ^ 2  / w + w  / 4;
    
    difference() {
        intersection() {
                left(R - w/2)
                cylinder(r=R, h=h, center = true);
            
            right(R - w/2)
                cylinder(r=R, h=h * 1.1, center = true);
        }
        fwdcube([w * 1.1, l * 1.1, h * 3]);
    }
}

$fa= 1;
$fs = 0.5;
shuttle(60, 10, 15);