$fn = 20;

stamp_text = "Brat";
rope_width = 8;
text_size = 15;
base_width = 37;

//stamp_text = "Fops";
//rope_width = 8;
//text_size = 15;
//base_width = 40;


//stamp_text = "Plushie";
//rope_width = 8;
//text_size = 15;
//base_width = 70;

//stamp_text = "Sub";
//rope_width = 8;
//text_size = 15;
//base_width = 35;

style = "sphere"; //flat, tampered, sphere

open = 1;


rope_cutout = rope_width + 4;
base_height = max(text_size, rope_cutout);
x = open == 1? 10 : 20;
depth = style != "sphere"? x: x-5;

module rope_cut(mod=1, v=1) {
    if (v==1) {
        translate([mod*-base_width,text_size/2,0]) rotate([0, mod*70, 0]) cylinder(h=100,d=rope_cutout);
    }
    else if (v==2) {
        translate([0, text_size/2, 20/2]) rotate([0, 90, 0]) cylinder(h=base_width+20, d=rope_cutout, center=true);
    }
    else if (v==3){
        translate([0, text_size/2, 20/2+2.5]) 
        rotate([0, 90, 0]) 
        scale([1.25, 1, 1])
        cylinder(h=base_width+20, d=rope_cutout, center=true);
    }
    else {
        translate([0, text_size/2, 20/2+3]) 
        rotate([0, 90, 0]) 
        scale([1.5, 1, 1])
        cylinder(h=base_width+20, d=rope_cutout, center=true);
    }
}

//translate([75, 75, 0])
rotate([0, 180, 0])
union() {
    color("#ff0000") translate([0,0,-2.5]) linear_extrude(5) text(stamp_text, size=text_size, halign="center");
    
    difference() {
        minkowski() {
            translate([0,text_size/2,depth/2]) 
                cube([base_width, base_height, depth], center=true);
            
            if (style == "flat") {
                cylinder(h=1, r=5);
            }
            else if (style == "tampered") {
                cylinder(h=1, r1=0, r2=5);
            }
            else if (style == "sphere") {
                translate([0, 0, 5])
                    difference() {
                        sphere(r=5);
                        translate([0, 0, 2.5])
                            cube([10, 10, 5], center=true);
                }
            }
        };
        rope_cut(1, v=3);
        //rope_cut(-1);
    }    
};
