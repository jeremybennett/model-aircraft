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


// Useful constants
corner_r =   5;
max_x    = 150;
canopy_x =  85;
max_y    =  20;
min_y    =  12;
fuse_z   =   3;

// Smooth corners
$fn = 96;

// 2D outline, which we'll later extrude.
module fuse_2d () {
    hull () {
        translate (v = [corner_r, corner_r, 0])
            circle (r = corner_r);
        translate (v = [max_x - corner_r, corner_r, 0])
            circle (r = corner_r);
        translate (v = [max_x - corner_r, max_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [canopy_x, max_y - corner_r, 0])
            circle (r = corner_r);
        translate (v = [corner_r, min_y - corner_r, 0])
            circle (r = corner_r);
    }
}


// 3D fuselage block.  No cutouts yet.
module fuse_3d () {
    linear_extrude (height = fuse_z, slices = 1, convexity = 1)
        fuse_2d ();
}


// Cut out the necessary slots
module fuselage () {
    difference () {
        fuse_3d ();
        // Tailwing
        translate (v = [6.5, min_y / 2, 0])
            rotate (a = [0, 0, -5])
                cube (size = [14,2.2,50], center = true);
        // Main wing
        translate (v = [60 + 40 / 2, 8, 0])
            cube (size = [40, 2.2, 50], center = true);
        // Studs for rudder
        translate (v = [10 + 3, 10 / 2 + 12 - 5, fuse_z / 2])
            rotate (a = [90, 0, 0])
                cylinder (r = 1.1, h = 10, center = true);
        translate (v = [10 + 12.5, 10 / 2 + 12 - 5, fuse_z / 2])
            rotate (a = [90, 0, 0])
                cylinder (r = 1.1, h = 10, center = true);
        translate (v = [10 + 22, 10 / 2 + 12 - 5, fuse_z / 2])
            rotate (a = [90, 0, 0])
                cylinder (r = 1.1, h = 10, center = true);
    }
}

fuselage ();


