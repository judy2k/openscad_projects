include <BOSL2/std.scad>
include <BOSL2/shapes2d.scad>

//$fa=1;
//$fs=.25;
$fn=100;

module loop_clip(stake_d=2.4, thickness=0.4*3, h=1, clip_d=10) {
    linear_extrude(h) {
        back(stake_d/2 + thickness / 2)
        pac_loop(stake_d, thickness);
        fwd(clip_d/2 + thickness / 2)
        zrot(180)
        pac_loop(clip_d, thickness);
    }
}

module pac_loop(inner_d, thickness, gap = 0.2) {
    outer_d = inner_d + thickness * 2;
    theta = asin( (thickness / 2 + gap / 2) / (inner_d / 2 + thickness / 2) );
    
    union() {
        difference() {
            ring(d1=inner_d, d2=outer_d);
            zrot(90 - theta)
            arc(d = outer_d + 1, angle=theta * 2, wedge=true);
        }
        
        zrot(theta)
        back(inner_d/2)
        circle(d=thickness, anchor=FRONT);
        
        zrot(-theta)
        back(inner_d/2)
        circle(d=thickness, anchor=FRONT);
    }
}

//pac_loop(inner_d=3, thickness=0.8);

loop_clip();