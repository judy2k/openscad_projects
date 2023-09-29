module leaf(l=40, w=20, h=10) {
    R = ((w*w) + (l*l))/(4*w);
    intersection() {
        left(R - w/2)  cylinder(r=R,h=h);
        right(R - w/2) cylinder(r=R,h=h);
    }
}

//leaf($fn=40);