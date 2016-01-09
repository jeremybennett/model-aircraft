// Simple glider.

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// This is the fuselage.  We tried doing as a shell to keep weight down, but
// that just didn't work.  It's too hard to control the wall thickness
// throughout.  We now do it as a solid, but it should be printed with a very
// low infill percentage, if any, and a thinner skin (2 layers rather than 3).

// We now mark the corners with spheres, then create a hull.  By printing on
// its side, we can print as a solid shape, rather than two halves to be
// joined.


// General constants

include <constants.h>

// Useful constants

MINK_R = 2;                             // Minkowski radius

AFT_L  = 85;                            // Length of aft block
FORE_L = 65;                            // Length of forward block

FUSE_W = 8;				// Width of the fuselage

MIN_H = 12;                             // Minimum fuselage height
MAX_H = 20;                             // Maximum fuselage height

// Half the angle at which the aft top of the fuselage slopes down.

THETA = atan ((MAX_H - MIN_H) / (AFT_L - MINK_R));

// Smooth corners

$fn = 96;

// Complete fuselage shape.

module fuse_hull () {
    Y_OFF_P = FUSE_W / 2 - MINK_R;	// Positive offset in Y direction
    Y_OFF_N = -Y_OFF_P;			// Negative offset in Y direction
    hull () {
	// Corners of stern
        translate (v = [MINK_R, Y_OFF_P, MINK_R])
	    sphere (r = MINK_R);
        translate (v = [MINK_R, Y_OFF_N, MINK_R])
	    sphere (r = MINK_R);
        translate (v = [MINK_R, Y_OFF_P, MIN_H - MINK_R])
	    sphere (r = MINK_R);
        translate (v = [MINK_R, Y_OFF_N, MIN_H - MINK_R])
	    sphere (r = MINK_R);
	// Corners of mid-point
        translate (v = [AFT_L, Y_OFF_P, MINK_R])
	    sphere (r = MINK_R);
        translate (v = [AFT_L, Y_OFF_N, MINK_R])
	    sphere (r = MINK_R);
        translate (v = [AFT_L, Y_OFF_P, MAX_H - MINK_R])
	    sphere (r = MINK_R);
        translate (v = [AFT_L, Y_OFF_N, MAX_H - MINK_R])
	    sphere (r = MINK_R);
	// Corners of forward
        translate (v = [AFT_L + FORE_L - MINK_R, Y_OFF_P, MINK_R])
	    sphere (r = MINK_R);
        translate (v = [AFT_L + FORE_L - MINK_R, Y_OFF_N, MINK_R])
	    sphere (r = MINK_R);
        translate (v = [AFT_L + FORE_L - MINK_R, Y_OFF_P, MAX_H - MINK_R])
	    sphere (r = MINK_R);
        translate (v = [AFT_L + FORE_L - MINK_R, Y_OFF_N, MAX_H - MINK_R])
	    sphere (r = MINK_R);
    }
}


// Fuselage has holes cut out for wing and tailplane

module fuselage () {
    difference () {
        fuse_hull ();
        // Tailplane
        translate (v = [0, 0, MIN_H / 2])
            rotate (a = [0, 5, 0])
                cube (size = [TAIL_MAX_X, 50, TAIL_THICK + GAPXY2],
                      center = true);
        // Main wing
        translate (v = [WING_OFF_X + WING_MAX_X / 2, 0, WING_OFF_Z])
            cube (size = [40, 50, WING_THICK + GAPXY2], center = true);
        // Pin slots for tailplane.
        translate (v = [FIN_OFF1, 0, MIN_H])
	    rotate (a = [0, -THETA, 0])
                cube (size = [FIN_THICK + GAPXY2, FIN_THICK + GAPZ2,
                              FIN_PIN_DEPTH * 2], center = true);
        translate (v = [FIN_OFF2, 0, MIN_H])
	    rotate (a = [0, -THETA, 0])
                cube (size = [FIN_THICK + GAPXY2, FIN_THICK + GAPZ2,
                              FIN_PIN_DEPTH * 2], center = true);
        translate (v = [FIN_OFF3, 0, MIN_H])
	    rotate (a = [0, -THETA, 0])
                cube (size = [FIN_THICK + GAPXY2, FIN_THICK + GAPZ2,
                              FIN_PIN_DEPTH * 2], center = true);
    }
}


module fuselage_side () {
    translate (v = [0, 0, FUSE_W / 2])
        rotate (a = [-90, 0, 0])
	    fuselage ();
}


fuselage_side ();
