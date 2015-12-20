// Simple glider.

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// This is the common parts of the wings.  Print with very low fill density in
// something like HIPS for low weight.


// Useful constants
corner_r =   3;
micro_r  =   0.1;
wing_z   =   2;
max_x    = 100;
min_x    =  70;
max_y    =  39;
min_y    =  30;

// Constants for the pegs. Note that the length is sum of peg *and* hole
// length.
gap = 0.1;
peg_len = 3 * 2;

// Smooth corners
$fn      = 96;

// 2D outline, which we'll later extrude.
module wing_2d () {
    hull () {
        translate (v = [micro_r, micro_r, 0])
            circle (r = micro_r);
        translate (v = [max_x - corner_r, corner_r, 0])
            circle (r = corner_r);
        translate (v = [max_x - corner_r, min_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [min_x, max_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [micro_r, max_y - micro_r, 0])
            circle (r = micro_r);
    }
}
