include <openscad-utilities/common.scad>

size = 5;
edge_d = 1;

hook_d = 18;
length = 28;
opening_size = 5;
bar_size = 6.5;

attach_d = bar_size + 2 * size;

hook_straight_len = 0;

top();
bottom();

module top() {
	difference() {
		union() {
			hull () {
				translate([0, 0, 0]) {
					rotate([0, 0, 0]) {
						rounded_cylinder(d = attach_d, h = size, top_d = edge_d, bottom_d = edge_d);
					}
				}
			}
			translate([-size/2, 0, size]) {
				rotate([-90, 0, 0]) {
					rounded_cube([size, size, length], edge_d, top_d = 0, bottom_d = 0);
				}
			}

		}
		translate([0, 0, size/2]) {
			rotate([0, 0, 0]) cylinder(d = 6.5, h = size + 2, center = true);
		}
		translate([-5, 0, size/2]) {
			cube([10, opening_size, size + 2], center = true);
		}
		//bump(true);
		//translate([0, length, size/2]) rotate([90, 0, 0]) cylinder(d = 2.6, h = 10);
	}
}

module bump(is_cut = false){
	adjust = is_cut ? 0 : 0;
	w = 1.5;
	bump_size = size - w + 2 * adjust;

	translate([-bump_size/2, length, bump_size/2 + size/2]) {
		rotate([-90, 0, 0]) {
			hull() {
				rounded_cube_vertical([bump_size, bump_size, 0.1], edge_d + adjust);
				h = 5;
				translate([h/2, h/2, -(h/2 + adjust)]) {
					rounded_cube_vertical([bump_size - h, bump_size - h, h/2 + adjust], edge_d + adjust);
				}
			}
		}
	}
}

module bottom() {
	difference() {
		union() {
			//bump();
			//reflect([1, 0, 0]) {
				translate([hook_d/2 + size/2, length, 0]) {
					rotate_extrude(angle = 180) {
						translate([hook_d/2, 0, 0]) {
							projection() {
								rounded_cube([size, size, 1], edge_d, top_d = 0, bottom_d = 0);
							}
						}
					}
					translate([hook_d/2 + size/2, -hook_straight_len, 0]) {
						rounded_cylinder(d = size, h = size, top_d = edge_d, bottom_d = edge_d);
						translate([-size/2, 0, size]) {
							rotate([-90, 0, 0]) {
								rounded_cube([size, size, hook_straight_len], edge_d, top_d = 0, bottom_d = 0);
							}
						}
					}
				}
			//}
		}
//		translate([0, length + 3, size/2]) {
//			rotate([90, 0, 0]) {
//				countersink(6.3, 3.2);
//			}
//		}
	}
}
