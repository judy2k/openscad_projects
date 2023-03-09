include <BOSL/shapes.scad>
include <BOSL/transforms.scad>
use <BOSL/threading.scad>

charm_height = 10;
charm_base = 15;
point_r=3;
base_r=1;
thread_length=3.5;

// Lay out the two parts for slicing
prepare = true;

// This empty module means that globals afterwards don't show up in the customizer.
module __no_more_params__() {}

$fn=60;
hole_d = 8;
croc_thickness = 3;
button_thickness = 1.2;
debug_cutaway = false;
fudge = 0.001;

// This prints much cleaner than the default pitch.
thread_pitch = 1.2;


module pyramid_charm(charm_height=charm_height, charm_base=charm_base, thread_length=thread_length) {
    difference() {
        up(croc_thickness + fudge)
            soft_prismoid(base=[charm_base,charm_base], h=charm_height);
        up(croc_thickness)
            threaded_rod(d=hole_d*0.8, l=thread_length , align=V_TOP, internal=true, pitch=thread_pitch);
        // Gap above the thread, for tolerance:
        up(croc_thickness + thread_length-fudge)
            cyl(d1 = hole_d * 0.75, d2=hole_d * 0.65, h=0.6, align=V_TOP);
    }
}

module pyramid_charm_button(
        hole_d=hole_d,
        croc_thickness=croc_thickness,
        button_thickness=button_thickness,
        thread_length=thread_length) {
    union() {
        cyl(d=hole_d + 3, h=button_thickness, align=V_BOTTOM, chamfer=0.4);
        cyl(d=hole_d, h=croc_thickness, align=V_TOP);
        up(croc_thickness-fudge)
            threaded_rod(d=hole_d*0.8, l=thread_length, align=V_TOP, bevel2=true, pitch=thread_pitch);
    }
}

module soft_prismoid(base, h, base_r=base_r, point_r=point_r) {

    module base_cyl() {
        cyl(r=base_r, h=0.2, align=V_TOP);
    }

    hull() {
        translate([base[0]/2 - base_r, base[1]/2 - base_r, 0])
            base_cyl();
        translate([-(base[0]/2 - base_r), base[1]/2 - base_r, 0])
            base_cyl();
        translate([base[0]/2 - base_r, -(base[1]/2 - base_r), 0])
            base_cyl();
        translate([-(base[0]/2 - base_r), -(base[1]/2 - base_r), 0])
            base_cyl();
        up(h-point_r)
            sphere(r=point_r);
    }
}

if (prepare) {
    down(croc_thickness)
    pyramid_charm();

    translate([20, 0, button_thickness])
        pyramid_charm_button();
} else {
    difference() {
        union() {
            color("red")
                pyramid_charm();
            color("blue")
                pyramid_charm_button();
        }
        if (debug_cutaway) {
            fwdcube([100, 100, 100]);
        }
    
    }
}