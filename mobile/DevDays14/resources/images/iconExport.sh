#!/bin/bash
mkdir -p drawable-ldpi
mkdir -p drawable-mdpi
mkdir -p drawable-hdpi
mkdir -p drawable-xhdpi
mkdir -p drawable-xxhdpi
mkdir -p drawable-xxxhdpi
inkscape --export-png drawable-ldpi/$1.png -w 36 $1.svg
inkscape --export-png drawable-mdpi/$1.png -w 48 $1.svg
inkscape --export-png drawable-hdpi/$1.png -w 72 $1.svg
inkscape --export-png drawable-xhdpi/$1.png -w 96 $1.svg
inkscape --export-png drawable-xxhdpi/$1.png -w 144 $1.svg
inkscape --export-png drawable-xxxhdpi/$1.png -w 192 $1.svg

