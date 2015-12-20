// Simple glider.

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// This is the rudder.  Print with very low fill density in something like
// HIPS for low weight.


// Useful constants
corner_r =  3;
micro_r  =  0.1;
rudder_z =  2;
max_x    = 25;
min_x    = 15;
max_y    = 30;

// Smooth corners
$fn      = 96;

// 2D outline, which we'll later extrude.
module rudder_2d () {
    hull () {
        translate (v = [micro_r, micro_r, 0])
            circle (r = micro_r);
        translate (v = [max_x - micro_r, micro_r, 0])
            circle (r = micro_r);
        translate (v = [min_x - corner_r, max_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [corner_r, max_y - corner_r, 0])
            circle (r = corner_r);
    }
}


// 3D rudder
module rudder_3d () {
    linear_extrude (height = rudder_z, slices = 1, convexity = 1)
        rudder_2d ();
}


// Pegs to attach to fuselage
module rudder () {
    union () {
        rudder_3d ();
        translate (v = [3, 0, rudder_z / 2])
            rotate (a = [90, 0, 0])
                cylinder (r = rudder_z / 2, h = 4 * 2, center = true);
        translate (v = [12.5, 0, rudder_z / 2])
            rotate (a = [90, 0, 0])
                cylinder (r = rudder_z / 2, h = 4 * 2, center = true);
        translate (v = [25 - 3, 0, rudder_z / 2])
            rotate (a = [90, 0, 0])
                cylinder (r = rudder_z / 2, h = 4 * 2, center = true);
    }
}

rudder ();
