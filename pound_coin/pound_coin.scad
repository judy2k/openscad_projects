include <BOSL2/std.scad>
include <BOSL2/shapes2d.scad>

pound_coin();

module pound_coin() {
    $fa=1;
    $fs=1;
    
    point_count = 12;
    d1 = 23.43; // Distance between two points on the coin edge.
    d2 = 23;    // Distance between two faces on the coin edge.
    h = 2.9;    // Height when sitting flat
    // This is the thickness of the ring, not the height, when sitting flat:
    thickness = 2;
    
    
    linear_extrude(h)
    difference() {
        arc_coin_2d(point_count, d1/2, d2/2);
        circle(d=d2 - thickness * 2);
    }
}

module arc_coin_2d(point_count, end_r, mid_r) {
    angle = 360 / point_count;
    points = [
        [0,0],
        [end_r, 0],
        zrot(angle*1/3, [mid_r, 0]),
        zrot(angle*2/3, [mid_r, 0]),
        zrot(angle, [end_r, 0]),
    ];
    
    for(i = [0:12]) {
        zrot(360/12 * i)
            polygon(points);
    }
}

