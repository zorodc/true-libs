#!/bin/sh

gnatprove --prover=z3 -Pstack && cat ./gnatprove/gnatprove.out
