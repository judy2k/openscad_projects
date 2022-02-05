seed = 6;

sphere_count = 50;  // How many spheres
sphere_size = 5; // Diameter of each of the spheres that make it blobby.
blob_size = 15; // Radius of the blob
quick=false;  // Debug setting

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

blobby(sphere_count, sphere_size, blob_size, seed, quick);