$fn = 20;

Stamp(["Pain", "Slut"], 45);
//Stamp(["Pain", "Slut", "some", "more", "lines"], 50);
//translate([100, 0, 0]) Stamp("hurt me!", 70, style="sphere");
//Stamp("Pain", 37);
//translate([-100, 0, 0]) Stamp("Brat", 37, rope_width=10);
//Stamp("Fops", 40);
//Stamp("Plushie", 70);
//Stamp("Sub", 35);

module Stamp(stamp_text, base_width, style="sphere", rope_width=8, text_size=15, line_offset=2.5, open=1, rope_cut_version=3) {
    
    multiline = is_list(stamp_text);
    print_text = multiline? stamp_text: [stamp_text];
    lines = len(print_text);
    text_offset = line_offset+text_size;
    
    rope_cutout = rope_width + 4;
    base_height = text_offset * lines;
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
        for (i = [0 : lines]) {
            color("#ff0000") translate([0,(text_offset) * -i,-2.5]) linear_extrude(5) text(print_text[i], size=text_size, halign="center");
            
        }
        
        difference() {
            minkowski() {
                translate([0,text_size/2 - ((lines-1)/2)*(text_offset),depth/2]) 
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
            for (i = [0:lines-1]) {
                translate([0, text_offset*-i, 0]) rope_cut(1, v=rope_cut_version);
            }
            //rope_cut(-1);
        }    
    };

}

