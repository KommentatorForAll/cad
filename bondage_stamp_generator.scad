$fn = 20;

stamp_text = "Plushie";
rope_width = 8;
text_size = 15;
base_width = 70;

open = 1;


rope_cutout = rope_width + 4;
base_height = max(text_size, rope_cutout);
depth = open == 1? 10 : 20;

module rope_cut(mod=1, v=1) {
    if (v==1) {
        translate([mod*-base_width,text_size/2,0]) rotate([0, mod*70, 0]) cylinder(h=100,d=rope_cutout);
    }
    else {
        translate([0, text_size/2, 20/2]) rotate([0, 90, 0]) cylinder(h=base_width+20, d=rope_cutout, center=true);
    }
}


union() {
    color("#ff0000") translate([0,0,-2.5]) linear_extrude(5) text(stamp_text, size=text_size, halign="center");
    
    difference() {
        minkowski() {
            translate([0,text_size/2,depth/2]) cube([base_width, base_height, depth], center=true);
            cylinder(1, 5);
        };                
        rope_cut(1, v=2);
        //rope_cut(-1);
    }    
};
