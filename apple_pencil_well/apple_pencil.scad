include<BOSL/constants.scad>
include<BOSL/shapes.scad>
include<BOSL/transforms.scad>

$fa = 1;
$fs = 1;

apple_pencil_D = 8.9;
apple_pencil_d = 8.5;

module apple_pencil_xs(d=apple_pencil_d, D=apple_pencil_D) {
    linear_extrude(20)
    difference() {
        circle(d=D);
        translate([-D/2,D/2 - (D-d),0])
            square([D, D/2]);
    }
}

module cx_tester() {
    difference() {
        upcube([apple_pencil_D + 4,apple_pencil_D + 4,1]);
        down(1)
        apple_pencil_xs(D=apple_pencil_D + 0.2, d=apple_pencil_d + 0.2);
    }
}

module point_tester() {
    // Too short: 16.8, 19

    linear_extrude(1)
    difference() {
        R = apple_pencil_D/2;
        l = 20;
        margin = 2;
    
        color("red")
        left(R + margin)
        square([apple_pencil_D + margin * 2, l + margin]);
    
        polygon([
            [-R,0],
            [R, 0],
            [0, l],
        ]);
    }
}

point_tester();