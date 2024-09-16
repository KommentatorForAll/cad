$fn=20;

module base() {
    minkowski() {
        cube([20,20,.25]);
        translate([1,1,0]) cylinder(h=.25,r=2);
    }
}

module pop() {
    difference() {
        sphere(r=1);
        translate([0,0,-.5]) cube([2,2,1], true);
    }
}

module fidgit_popper() {
    translate([0,0,-.5]) base();
    for (x=[1:2.5:22]) {
        for (y=[1:2.5:22]) {
            translate([x,y,0]) pop();
        }
    }
}

fidgit_popper();