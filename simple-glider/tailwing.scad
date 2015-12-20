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


// Useful constants
corner_r =  3;
wing_z   =  2;
max_x    = 76;
min_x    = 38;
x_off    = (max_x - min_x) / 2;
max_y    = 25;
min_y    = 14;

// Smooth corners
$fn      = 96;

// 2D outline, which we'll later extrude.
module tailwing_2d () {
    hull () {
        translate (v = [corner_r, corner_r, 0])
            circle (r = corner_r);
        translate (v = [max_x - corner_r, corner_r, 0])
            circle (r = corner_r);
        translate (v = [max_x - corner_r, min_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [min_x + x_off, max_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [x_off, max_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [corner_r, min_y - corner_r, 0])
            circle (r = corner_r);
    }
}


// 3D tailwing
module tailwing () {
    linear_extrude (height = wing_z, slices = 1, convexity = 1)
        tailwing_2d ();
}


tailwing ();
