seed = 6;
blob_size = 15; // Radius of the blob
quick = false;  // Debug setting
prepare = true;


if (prepare) {
    prepare(seed)
        mo_random(blob_size, seed, quick);
} else {
    mo_random(blob_size, seed, quick=quick);
}


module blobby(sphere_count, sphere_size, blob_size, seed=42, quick=false) {
    if (quick) {
        #sphere(blob_size);
        union() {
            _blob_components(sphere_count, sphere_size, blob_size, seed);
        }
    } else {
        hull() {
            _blob_components(sphere_count, sphere_size, blob_size, seed);
        }
    }
}

module mo_random(blob_size, seed, quick=false) {
    // Generate a bunch of seeds from the primary seed:
    seeds = rands(0, 10, 1000, seed=seed);

    sphere_count = rands(30, 50, 1, seed=seeds[0])[0];
    sphere_size = rands(blob_size/3, blob_size * 1.3, sphere_count, seed=seeds[1]);

    blobby(sphere_count, sphere_size, blob_size, seed, quick=quick);
}

module _blob_components(sphere_count, sphere_size, blob_size, seed) {
    rot = rands(0, 360, sphere_count * 3, seed);

    for (i = [0:sphere_count - 1]) {
            ss = is_list(sphere_size) ? sphere_size[i] : sphere_size;
          
            x = rot[i * 3];
            y = rot[i * 3 + 1];
            z = rot[i * 3 + 2];
            
            rotate([x, y, z])
                translate([blob_size - ss/2, 0, 0])
                    sphere(d=ss);
        }
}


module biscuit(margin_x=0, margin_y=0, margin_z=0) {
    cube([5 + margin_x, 1 + margin_y , 8 + margin_z], center=true);
}

module subtract_biscuit() {
    difference() {
        children();
        biscuit(0.8, 0.2, 0.2);
    }
}

module prepare(i) {
    translate([-20,0,0])
    rotate([0, 90, 0])
    
    difference() {
        subtract_biscuit() {
            intersection() {
                translate([-250,0,0])
                cube([500,500,500], center=true);
                children();
            }
        }
        translate([-0.5, 1, 0])
        rotate([0,90,0])
        linear_extrude(1)
            text(str(i), halign="center");
    }

    translate([20,0,0])
    rotate([0, -90, 0])
    difference() {
        subtract_biscuit() {
            intersection() {
                translate([250,0,0])
                cube([500,500,500], center=true);
                children();
            }
        }
    
        translate([0.5, 1, 0])
        rotate([0,-90,0])
        linear_extrude(1)
            text(str(i), halign="center");
    }

    rotate([90,0,0])
    biscuit();
}