include <openscad-utilities/common.scad>

hook_interior_d = 20;
edge_width = 5;
hook_d = hook_interior_d + 2 * edge_width;
bar_d = 6.5;
bar_opening_width = 0.8 * bar_d;
top_d = bar_d + 2 * edge_width;
extra_depth = 5;
edge_d = 1;
neck_angle = 60;

top_height = 2 * get_opposite_soh(neck_angle, hook_d/2 - edge_width/2) + top_d/2;

hook();

module hook() {
    difference() {
        hook_blank();
        translate([0, -top_height])
            keyhole();
    }
}

module hook_blank() {
    translate([0, 0, edge_d/2])
        minkowski() {
            linear_extrude(edge_width - edge_d)
                offset(-edge_d/2)
                    hook_2d_with_fillet();
            sphere(d = edge_d);
        }
}

module keyhole() {
    linear_extrude(edge_width)
        union() {
            circle(d = bar_d);
            polygon(
                [
                    [0, bar_opening_width/2],
                    [bar_d/2, bar_opening_width/2],
                    [top_d/2, bar_opening_width/2 + 1],
                    [top_d/2, -bar_opening_width/2 - 1],
                    [bar_d/2, -bar_opening_width/2],
                    [0, -bar_opening_width/2]
                ]
            );
        }
}

module hook_2d_with_fillet() {
    // Double offset will fillet interior corners
    offset(-edge_width)
        offset(edge_width)
            hook_2d();
}

module hook_2d() {
    // Bottom loop
    translate([0, extra_depth])
        circle_segment(hook_d, edge_width, 180);

    // Bottom loop depth extension
    translate([hook_d/2 - edge_width, 0])
        square([edge_width, extra_depth]);
    translate([-hook_d/2, edge_width/2]) {
        square([edge_width, extra_depth - edge_width/2]);
        translate([edge_width/2, 0])
            circle(d = edge_width);
    }

    // Neck between bottom loop and top
    rotate(-neck_angle) {
        circle_segment(hook_d, edge_width, neck_angle);
        translate([hook_d - edge_width, 0])
            rotate(180)
                circle_segment(hook_d, edge_width, neck_angle);
    }

    // Top
    translate([0, -top_height]) {
        circle(d = top_d);
        translate([-edge_width/2, 0])
            square([edge_width, top_d/2]);
    }
}

module circle_segment(outer_d, width, angle) {
    difference() {
        pie_wedge(outer_d/2, angle);
        fix_preview() pie_wedge(outer_d/2 - width, angle);
    }
}
