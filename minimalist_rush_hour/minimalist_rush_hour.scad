// Minimalist Rush Hour
// The idea for this is a fast-printing, minimalist-style clone of Rush Hour.

include <BOSL/constants.scad>
include <BOSL/shapes.scad>
include <BOSL/transforms.scad>

parking_lot_tiles_x = 6;
parking_lot_tiles_y = 6;
parking_lot_exit_index = 2;

square_size = 6;
square_depth = 0.6;
wheel_width = 0.8;
border_thickness = 1.2;
base_depth = 0.2 * 3; // 3 Layers
border_depth = 2;
piece_depth = 1.8;

module __no_more_params__ () {}

// Constants:
slide_gap = 0.2;
fudge = 0.02;

tile_gap = wheel_width * 2 + slide_gap * 4;
edge_gap = tile_gap / 2;

module board() {
    inner_width = edge_gap * 2 + square_size * parking_lot_tiles_x + tile_gap * (parking_lot_tiles_x - 1);
    inner_height = edge_gap * 2 + square_size * parking_lot_tiles_y + tile_gap * (parking_lot_tiles_y - 1);
    
    outer_width = inner_width + border_thickness * 2;
    outer_height = inner_height + border_thickness * 2; 
    
    difference() {
        cuboid([outer_width, outer_height, base_depth + border_depth], align=V_UP, fillet=border_thickness, edges=EDGES_Z_ALL, $fs=0.3, $fa=5);
        up(base_depth)
            upcube([inner_width, inner_height, border_depth + fudge]);
    }
        
    // Move to bottom-left
    translate([
        -inner_width/2 + edge_gap,
        -inner_height/2 + edge_gap,
        base_depth - fudge ])
        for(x = [0:parking_lot_tiles_x-1]) {
            for(y = [0:parking_lot_tiles_y-1]) {
                translate([
                    x * (square_size + tile_gap),
                    y * (square_size + tile_gap),
                    0])
                cuboid([square_size, square_size,square_depth + fudge], align=V_UP + V_RIGHT + V_BACK, fillet=0.4, edges=EDGES_Z_ALL, $fs=0.3, $fa=5);
            }
        }
}

module car(length=2) {
    dim_x = wheel_width * 2 + slide_gap * 2 + square_size;
    dim_y = (square_size + tile_gap) * length - slide_gap;
    color("red")
    up(base_depth + fudge)
    difference() {
        cuboid([dim_x, dim_y, piece_depth - fudge], align=V_UP, fillet=0.4, edges=EDGES_X_BOT, $fs=0.3, $fa=5);
        down(1)
        upcube([
            dim_x - wheel_width * 2,
            dim_y * 1.2,
            square_depth + 0.3 + 1]);
    }
}

difference() {
    union() {
        board();
        right(parking_lot_tiles_x * (square_size + tile_gap) / 2 + border_thickness * 2)
        right((wheel_width * 2 + slide_gap * 2 + square_size)/2 + slide_gap) {
        car(2);
        fwd(3 * (square_size + tile_gap))
        car(3);
        }
    }
    *fwd(5)
    backcube([100, 100, 100]);
}