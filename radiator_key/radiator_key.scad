// Radiator Key
include <BOSL/transforms.scad>
include <BOSL/shapes.scad>

handle_width = 20;
handle_thickness = 5;
handle_depth = 5;

key_depth = 6; // handle_depth + key_depth is the total height of the key.
key_d = 10; // Diameter of the key's core cylinder
key_side = 5.5; // The length of a side of the square that's extruded into the cylinder.
key_inset_depth = 5; // The depth the square should be extruded into the cylinder.


$fn=40;


module new_key() {
    difference() {       
        union() {
            zcyl(d= key_d, h=handle_depth + key_depth, align=V_TOP);
            //leaf(l=20, w=key_d, h=handle_depth);
            cuboid([handle_thickness, handle_width, handle_depth], align=V_TOP, fillet=0.8, edges=EDGES_Z_ALL);
        }
        up(handle_depth + key_depth + 0.1)
            downcube([key_side,key_side,key_inset_depth + 0.1]);
    }
}

new_key();

