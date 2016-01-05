// Simple glider. These are the constants

// Copyright (C) 2015 Embecosm Limited (www.embecosm.com)

// Contributor: Jeremy Bennett <jeremy.bennett@embecosm.com>

// This file is licensed under the Creative Commons Attribution-ShareAlike 3.0
// Unported License. To view a copy of this license, visit
// http://creativecommons.org/licenses/by-sa/3.0/ or send a letter to Creative
// Commons, PO Box 1866, Mountain View, CA 94042, USA.


// A very simple hand thrown glider for indoor use.

// Constants common to multiple components

GAP  = 0.4;			// Gap to allow for tight push fit.
GAP2 = GAP * 2;

LAYER_H  = 0.30;		// Height of all except first layer
LAYER1_H = 0.35;		// Height of first layer
NOZZLE_D = 0.40;		// Nozzle diameter

TAIL_THICK = LAYER1_H + LAYER_H * 2;
TAIL_MAX_X = 25.0;		// Tailplane width

WING_THICK = LAYER1_H + LAYER_H * 2;
WING_MAX_X = 40;
WING_OFF_X = 60;		// Where wing slot starts
WING_OFF_Z =  8;

FIN_THICK = LAYER1_H + LAYER_H * 2;
FIN_MAX_X = 25.0;
FIN_PIN_DEPTH = 6.0;
FIN_OFF1 = 10 + 3;
FIN_OFF2 = 10 + FIN_MAX_X / 2;
FIN_OFF3 = 10 + FIN_MAX_X - 3;

PEG_THICK = LAYER1_H + LAYER_H * 2;
