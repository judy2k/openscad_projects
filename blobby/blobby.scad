// Blobby 2

seed = 6;

sphere_count = 50;
sphere_size = 10;
blob_size = 10;

module blobby(sphere_count, sphere_size, blob_size, seed=14) {
    rot = rands(0, 360, sphere_count * 3, seed);

    hull() {
        sphere(blob_size);
        for (i = [0:sphere_count - 1]) {
            echo(rot);
            x = rot[i * 3];
            y = rot[i * 3 + 1];
            z = rot[i * 3 + 2];
            
            rotate([x, y, z])
                translate([blob_size, 0, 0])
                    sphere(d=sphere_size);
        }
    }
}

module main() {
    blobby(sphere_count, sphere_size, blob_size, seed);
}

main();