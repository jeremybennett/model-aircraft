// Simple glider.

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// This is the left wing.  Print with very low fill density in something like
// HIPS for low weight.

include <wings-common.scad>


// Sockets to join together
module wing_left () {
    mirror ([0, 1, 0])
        union () {
            wing_3d ();
            translate (v = [0, 10 + 5, wing_z / 2])
                cube (size = [peg_len - gap, wing_z - gap, wing_z], center = true);
            translate (v = [0, 10 + max_y / 2, wing_z / 2])
                cube (size = [peg_len - gap, wing_z - gap, wing_z], center = true);
            translate (v = [0, 10 + max_y - 5, wing_z / 2])
                cube (size = [peg_len - gap, wing_z - gap, wing_z], center = true);
        }
}


wing_left ();