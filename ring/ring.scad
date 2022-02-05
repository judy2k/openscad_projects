inner_dia = 19;
outer_dia = inner_dia + 4;
z = [0, 0, 1];


difference() {
    cylinder(4, r=outer_dia/2);

    translate(-z * 0.25)
    cylinder(
        4.5, r=inner_dia/2
    );
}