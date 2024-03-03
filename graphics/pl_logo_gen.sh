#!/bin/bash

mydir="$(dirname "$(realpath "$0")")"

file="$1"

export_png_files() {
    newfile="$1"
    mdpi_w="$2"
    mdpi_h="$3"
	  hdpi=1.5
    if [ -z "$mdpi_h" ]; then
        mdpi_h="$mdpi_w"
    fi
    mkdir -p $base_folder-mdpi
    mkdir -p $base_folder-hdpi
    mkdir -p $base_folder-xhdpi
    mkdir -p $base_folder-xxhdpi
    mkdir -p $base_folder-xxxhdpi
    convert "$fil" -resize "$mdpi_wx$mdpi_h" "$base_folder-mdpi/$newfile"
    convert "$file" -resize "$(echo "$mdpi_w*$hdpi" | bc)x$(echo "$mdpi_h*$hdpi" | bc)" "$base_folder-hdpi/$newfile"
    convert "$file" -resize "$((mdpi_w*2))x$((mdpi_h*2))" "$base_folder-xhdpi/$newfile"
    convert "$file" -resize "$((mdpi_w*3))x$((mdpi_h*3))" "$base_folder-xxhdpi/$newfile"
    convert "$file" -resize "$((mdpi_w*4))x$((mdpi_h*4))" "$base_folder-xxxhdpi/$newfile"
}

# Generate privateline_splash_white in ui-styles
base_folder="$mydir/../library/ui-styles/src/main/res/drawable"
file="$mydir/privateline_splash_white.png"
export_png_files "privateline_splash_white.png" 108

file="$mydir/privateline_logo_orig.png"
export_png_files "privateline_logo_orig.png" 108
