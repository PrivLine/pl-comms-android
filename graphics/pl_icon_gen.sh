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

# Generate Icon Launcher (show in App lists)
base_folder="$mydir/../vector-app/src/main/res/mipmap"

file="$mydir/ic_launcher.png"
export_png_files "ic_launcher.png" 48

file="$mydir/ic_launcher_round.png"
export_png_files "ic_launcher_round.png" 48

file="$mydir/ic_launcher_foreground.png"
export_png_files "ic_launcher_foreground.png" 72

# Generate feature image & store_icon image
convert "$mydir/feature_image.png" -resize "1024x500" "$mydir/../fastlane/metadata/android/en-US/images/featureGraphic.png"
convert "$mydir/store_icon.png" -resize "500x500" "$mydir/../fastlane/metadata/android/en-US/images/icon.png"

base_folder="$mydir/../vector/src/main/res/drawable"

file="$mydir/privateline_splash_white.png"
export_png_files "privateline_splash_white.png" 72

file="$mydir/ic_notification.png"
export_png_files "ic_notification.png" 24

file="$mydir/privateline_logo_orig.png"
export_png_files "privateline_logo_orig.png" 72

# Generate Icon Splash Carousel
base_folder="$mydir/../vector/src/main/res/drawable"
file="$mydir/ic_splash_control.png"
export_png_files "ic_splash_control.webp" 300 208
export_png_files "ic_splash_control_dark.webp" 300 208
