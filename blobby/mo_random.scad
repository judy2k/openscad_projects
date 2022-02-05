use <blobby.scad>;

seed = 8;

// Radius of the blob.
blob_size = 15;

quick=false;

$fn = 20;

module mo_random(blob_size, seed, quick=false) {
    // Generate a bunch of seeds from the primary seed:
    seeds = rands(0, 10, 1000, seed=seed);

    sphere_count = rands(30, 50, 1, seed=seeds[0])[0];
    sphere_size = rands(blob_size/3, blob_size * 1.3, sphere_count, seed=seeds[1]);

    blobby(sphere_count, sphere_size, blob_size, seed, quick=quick);
}

mo_random(blob_size, seed, quick=quick);