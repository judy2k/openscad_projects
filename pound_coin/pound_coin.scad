include <BOSL2/std.scad>

$fa=1;              // Minimum facet angle
$fs=1;              // Minimum facet size

point_count = 12;   // A pound coin has 12 points around the outside edge.
d1 = 23.43;         // Distance between two points on the coin edge.
d2 = 23;            // Distance between two faces on the coin edge.
h = 2.9;            // Height when sitting flat
thickness = 2;      // This is the thickness of the ring, not the height, when sitting flat

finangle = 0.000001;

pound_coin(point_count=point_count, d1=d1, d2=d2, h=h, thickness=thickness);

module pound_coin(point_count=point_count, d1=d1, d2=d2, h=h, thickness=thickness) {


    linear_extrude(h)
    difference() {                              // Cut a hole out of the middle
        arc_coin_2d(point_count, d1/2, d2/2);   // Outer coin shape
        circle(d=d2 - thickness * 2);           // Hole
    }
}

module arc_coin_2d(
        point_count,    // Number of points (12, for a pound coin)
        end_r,          // The radius of an outside point
        mid_r,          // The radius at the centre of a facet
) {
    wedge_angle = 360 / point_count;
    wedge_points = [
        [end_r, 0],                         // pointy bit
        zrot(wedge_angle*1/3, [mid_r, 0]),  // face point 1
        zrot(wedge_angle*2/3, [mid_r, 0]),  // face point 2
    ];
    polygon(flatten([for(a = [0:wedge_angle:360-finangle]) zrot(a=a, p=wedge_points)]));
}

// Stolen from https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/List_Comprehensions#Flattening_a_nested_vector
function flatten(l) = [ for (a = l) for (b = a) b ] ;
