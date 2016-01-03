// Simple glider.

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// This is the fuselage.  Print with very low fill density in something like
// HIPS for low weight.

// We have a pair of cylinders, which we join, then use a minkowsky hull to
// round all the edges.


// General constants
include <constants.h>

// Useful constants
MINK_R = 5;				// Minkowski radius

AFT_L  = 85;				// Length of aft cylinder
FORE_L = 65;				// Length of forward cylinder

MIN_R =  6;				// Minimum cylinder radius
MAX_R = 10;				// Maximum cylinder radius

// Smooth corners
$fn = 96;

// Forward cylinder

module fore_cyl () {
    translate (v = [AFT_L, 0, MAX_R])
        rotate (a = [0, 90, 0])
	    cylinder (r = MAX_R - MINK_R, h = FORE_L - MINK_R, center = false);
}

// aft cylinder. Because this is a cone, we need a bit more rotation

module aft_cyl () {
    theta = atan ((MAX_R - MIN_R) / (AFT_L - MINK_R));
    off = (MIN_R - MINK_R) * cos (theta);
    translate (v = [MINK_R, 0, off + MINK_R])
        rotate (a = [0, 90 - theta, 0])
	    cylinder (r1 = MIN_R - MINK_R, r2 = MAX_R - MINK_R,
	              h = AFT_L - MINK_R, center = false);
}


// Complete fuselage shape. Use a hull to deal with the small gap between
// fuselate sections.

module fuse_hull () {
    minkowski () {
	sphere (r = MINK_R);
	hull () {
	    fore_cyl ();
	    aft_cyl ();
	}
    }
}


// Fuselage has holes cut out

module fuselage () {
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
        // Pin slots for tailplane
        translate (v = [FIN_OFF1, 0, MIN_R + FIN_PIN_DEPTH * 3 - GAP2])
            cube (size = [FIN_THICK + GAP2, FIN_THICK + GAP2,
	  	          FIN_PIN_DEPTH * 4], center = true);
        translate (v = [FIN_OFF2, 0, MIN_R + FIN_PIN_DEPTH * 3 - GAP2])
            cube (size = [FIN_THICK + GAP2, FIN_THICK + GAP2,
	  	          FIN_PIN_DEPTH * 4], center = true);
        translate (v = [FIN_OFF3, 0, MIN_R + FIN_PIN_DEPTH * 3 - GAP2])
            cube (size = [FIN_THICK + GAP2, FIN_THICK + GAP2,
	  	          FIN_PIN_DEPTH * 4], center = true);
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
