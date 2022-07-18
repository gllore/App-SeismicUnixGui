#!/bin/bash

sudo make clean
sudo perl dist/manifest.pl
sudo perl Makefile.PL
sudo perl dist/manifest.pl
sudo perl Makefile.PL
sudo make all
sudo make install
sudo make clean
