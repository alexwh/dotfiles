#!/usr/bin/zsh
mpc del $(mpc -f %position% | head -1)
