$fn=20;

module arm(length=5, width=5, cut_scale = [1.5, .75, 1], bearing_size=2.5) {
    cutout=cut_scale[1];
    translate([0, -width/2, 0])
    difference() {
        hull() {
            translate([0, width/2, 0]) cylinder(h=1, d=5);
            translate([length, width/2, 0]) cylinder(h=1, d=5);    
        }
        translate([length/2, -cutout, -.5]) 
            scale(cut_scale) 
                cylinder(h=2, d=5);
        translate([length/2, width+cutout, -.5]) 
            scale(cut_scale)
                cylinder(h=2, d=5);
        
        translate([length+.5, width/2, -.5]) 
            cylinder(h=2,d=bearing_size);
    }
}

module fidgit_spinner(cnt_arms=3,length=5, width=5, cut_scale = [1.5, .75, 1], bearing_size=2.5) {
    difference() {
        for (i=[0:360/cnt_arms:360]) {
            rotate([0,0,i]) arm(length, width, cut_scale, bearing_size);
        }
        translate([0,0,-.5]) cylinder(h=2,d=bearing_size);
    }
}
fidgit_spinner(cnt_arms=5, cut_scale=[1.25, 1, 1]);
//arm();