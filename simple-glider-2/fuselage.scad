// Simple glider.

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// This is the fuselage.  It is deliberately a shell - for low weight we don't
// want a solid shape.

// We have a pair of cylinders and a sphere, which we join, then use a
// minkowsky hull to round all the edges.


// General constants
include <constants.h>

// Useful constants
MINK_R = 5;                             // Minkowski radius

AFT_L  = 85;                            // Length of aft cylinder
FORE_L = 65;                            // Length of forward cylinder

MIN_R =  6;                             // Minimum cylinder radius
MAX_R = 10;                             // Maximum cylinder radius

FUSE_WALL_THICK = 0.8;                  // Thickness of the fuselage wall.

// Half the angle at which the aft top of the fuselage slopes down.
THETA = atan ((MAX_R - MIN_R) / (AFT_L - MINK_R));

// Smooth corners
$fn = 96;

// Nose. Why does OpenScad barf if we don't have the closing semicolon - it
// isn't required!

module nose () {
    translate (v = [AFT_L + FORE_L - MAX_R, 0, MAX_R])
        sphere (r = MAX_R - MINK_R);
}


// Forward cylinder

module fore_cyl () {
    translate (v = [AFT_L, 0, MAX_R])
        rotate (a = [0, 90, 0])
            cylinder (r = MAX_R - MINK_R, h = FORE_L - MAX_R - MINK_R,
                      center = false);
}

// aft cylinder. Because this is a cone, we need a bit more rotation

module aft_cyl () {
    off = (MIN_R - MINK_R) * cos (THETA);
    translate (v = [MINK_R, 0, off + MINK_R])
        rotate (a = [0, 90 - THETA, 0])
            cylinder (r1 = MIN_R - MINK_R, r2 = MAX_R - MINK_R,
                      h = AFT_L - MINK_R, center = false);
}


// Bare hull. Use a hull to deal with the small gap between fuselate sections.

module bare_hull () {
    hull () {
        nose ();
        fore_cyl ();
        aft_cyl ();
    }
}


// Inner hull has a smaller minkowski sphere added to smooth corners.

module inner_hull () {
    minkowski () {
        sphere (r = MINK_R - FUSE_WALL_THICK);
        bare_hull ();
    }
}

// Full hull has a larger minkowski sphere added to smooth corners.

module full_hull () {
    minkowski () {
        sphere (r = MINK_R);
        bare_hull ();
    }
}


// Complete fuselage shape.

module fuse_hull () {
    difference () {
        full_hull ();
        inner_hull ();
    }
}


// Fuselage has holes cut out, but no pegs yet for joining

module fuselage_no_pegs () {
    difference () {
        fuse_hull ();
        // Tailplane
        translate (v = [0, 0, MIN_R])
            rotate (a = [0, 5, 0])
                cube (size = [TAIL_MAX_X, 50, TAIL_THICK + GAP2],
                      center = true);
        // Main wing
        translate (v = [WING_OFF_X + WING_MAX_X / 2, 0, WING_OFF_Z])
            cube (size = [40, 50, WING_THICK + GAP2], center = true);
        // Pin slots for tailplane. These rotate to align
        translate (v = [FIN_OFF1, 0, MIN_R + FIN_PIN_DEPTH * 3 - GAP2])
            rotate (a = [0, -THETA * 2, 0])
                cube (size = [FIN_THICK + GAP2, FIN_THICK + GAP2,
                              FIN_PIN_DEPTH * 4], center = true);
        translate (v = [FIN_OFF2, 0, MIN_R + FIN_PIN_DEPTH * 3 - GAP2])
            rotate (a = [0, -THETA * 2, 0])
                cube (size = [FIN_THICK + GAP2, FIN_THICK + GAP2,
                              FIN_PIN_DEPTH * 4], center = true);
        translate (v = [FIN_OFF3, 0, MIN_R + FIN_PIN_DEPTH * 3 - GAP2])
            rotate (a = [0, -THETA * 2, 0])
                cube (size = [FIN_THICK + GAP2, FIN_THICK + GAP2,
                              FIN_PIN_DEPTH * 4], center = true);
    }
}


// Peg hole for fixing the halves together

module peg_hole () {
    OUTER = PEG_THICK + GAP2 + FUSE_WALL_THICK * 2;
    INNER = PEG_THICK + GAP2;
    difference () {
        cube (size = [OUTER, 100, OUTER], center = true);
        cube (size = [INNER, 100, INNER], center = true);
    }
}


// Set of peg holes to add to the fuselage
module all_peg_holes () {
    intersection () {
        full_hull ();
        union () {
            // Aft peg hole
            translate (v = [(FIN_OFF1 + FIN_OFF2) / 2, 0, MIN_R])
                peg_hole ();
            // Mid peg hole (above center)
            translate (v = [AFT_L, 0, MAX_R * 3 / 2])
                peg_hole ();
            // Forward peg hole
            translate (v = [AFT_L + FORE_L - MAX_R, 0, MAX_R])
                peg_hole ();
        }
   }
}


// Fuselage adds the peg holes
module fuselage () {
    union () {
        fuselage_no_pegs ();
        all_peg_holes ();
    }
}


module fuselage_left () {
    translate (v = [0, -10, 0])
        rotate (a = [90, 0, 0])
            intersection () {
                fuselage ();
                translate (v = [0, 500, 0])
                    cube (size = [1000, 1000, 1000], center = true);
            }
}

module fuselage_right () {
    translate (v = [0, 10, 0])
        rotate (a = [-90, 0, 0])
            intersection () {
                fuselage ();
                translate (v = [0, -500, 0])
                    cube (size = [1000, 1000, 1000], center = true);
            }
}

fuselage_left ();
fuselage_right ();
