
use <blobby_preparation.scad>;
use <mo_random.scad>;

blob_size = 15;
quick=true;

for (i = [0:5]) {
    translate([0, i * 2 * blob_size, 0])
    prepare(i) {
        mo_random(blob_size, i, quick=quick);
    }
}