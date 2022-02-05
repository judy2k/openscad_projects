/* 
The aim of this is to create a blobby sphere,
by projecting spheres at random angles from a central point.
*/

$fs=0.1;

seed = 1;

union() {
    for (seeds=rands(0, 1000, 20, seed_value=seed)) {
        r=rands(1, 4, 1, seed_value=seeds)[0];
        rotate(rands(-180, 180,3, seed_value=seeds))
            translate([sqrt(100 - r*r),0,0])
                scale([rands(0.2, 1, 1)[0], 1, 1])
                sphere(r=r);
    }

    sphere(r=10);
}