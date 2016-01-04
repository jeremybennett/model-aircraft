// Simple glider.

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// This is the tail wing.  Print with very low fill density in something like
// HIPS for low weight.


// General constants
include <constants.h>

// Useful constants
VERTEX_R =  TAIL_THICK / 2;
WING_Z   =  2;
MAX_X    = 76;
MIN_X    = 38;
X_OFF    = (MAX_X - MIN_X) / 2;
MAX_Y    = TAIL_MAX_X;
MIN_Y    = 14;

// Smooth corners
$fn      = 96;


// Place a sphere at each vertex and then put a hull round it

module tailwing () {
    hull () {
        translate (v = [VERTEX_R, VERTEX_R, VERTEX_R])
            sphere (r = VERTEX_R);
        translate (v = [MAX_X - VERTEX_R, VERTEX_R, VERTEX_R])
            sphere (r = VERTEX_R);
        translate (v = [MAX_X - VERTEX_R, MIN_Y - VERTEX_R, VERTEX_R])
            sphere (r = VERTEX_R);
        translate (v = [MIN_X + X_OFF, MAX_Y - VERTEX_R, VERTEX_R])
            sphere (r = VERTEX_R);
        translate (v = [X_OFF, MAX_Y - VERTEX_R, VERTEX_R])
            sphere (r = VERTEX_R);
        translate (v = [VERTEX_R, MIN_Y - VERTEX_R, VERTEX_R])
            sphere (r = VERTEX_R);
    }
}


tailwing ();
