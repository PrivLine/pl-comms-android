#!/bin/bash

set -e

mydir="$(dirname "$(realpath "$0")")"

echo $mydir

pushd "$mydir" > /dev/null

stringdir="$mydir/library/ui-strings/src/main/res"

# Element -> PL Comms
find "$stringdir" -name strings.xml -exec \
    sed -i '' -e  's|Element|PL Comms|g' '{}' \;

# matrix.org -> mtxnode1.privateline.dev
find "$stringdir" -name strings.xml -exec \
    sed -i '' -e  's|matrix\.org|mtxnode1\.privateline\.dev|g' '{}' \;

# Fastlane replace
fastlanedir="$mydir/fastlane"
find "$fastlanedir" -name Appfile -exec \
    sed -i '' -e  's|im\.vector\.app|dev\.privateline\.im|g' '{}' \;

find "$fastlanedir" -name *.txt -exec \
    sed -i '' -e  's|Element|PL Comms|g' '{}' \;

# element_splash_white replace --> plcomms_splash_white
uistylesdir="$mydir/library/ui-styles"
find "$uistylesdir" -name *.xml -exec \
    sed -i '' -e  's|element_splash_white|plcomms_splash_white|g' '{}' \;

find "$uistylesdir" -name *.xml -exec \
    sed -i '' -e  's|element_logo_green|plcomms_logo_orig|g' '{}' \;

# element_logo_green -> plcomms_logo_orig
vectordir="$mydir/vector/src/main"
find "$vectordir" -name *.xml -exec \
    sed -i '' -e  's|element_logo_green|plcomms_logo_orig|g' '{}' \;
find "$vectordir" -name *.kt -exec \
    sed -i '' -e  's|element_logo_green|plcomms_logo_orig|g' '{}' \;

# im.vector.app --> dev.privateline.communicator
build_gradle="$mydir/vector-app/build.gradle"
src_dir="$mydir/vector/src"
app_src_dir="$mydir/vector-app/src"
app_conf_dir="$mydir/vector-config/src"

sed -i '' -e "s|Element|PL Comms|g" "$build_gradle"
sed -i '' -e "s|im\.vector\.app|dev\.privateline\.im|g" "$build_gradle" 

find "$app_src_dir" -name google-services.json -exec \
	sed -i '' -e "s|vector-alpha|pl-comms|g" '{}' \;

find "$app_src_dir" -name google-services.json -exec \
	sed -i '' -e "s|im\.vector\.app|dev\.privateline\.im|g" '{}' \;
	
find "$app_src_dir" -name shortcuts.xml -exec \
	sed -i '' -e "s|im\.vector\.app|dev\.privateline\.im|g" '{}' \;	
	
find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|im\.vector\.app|dev\.privateline\.im|g" '{}' \;

find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|matrix\.org|mtxnode1\.privateline\.dev|g" '{}' \;

find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|riot\.im|im\.privateline\.dev|g" '{}' \;

find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|riot-android|pl-comms-android|g" '{}' \;

find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|element-auto-uisi|pl-comms-auto-uisi|g" '{}' \;

find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|matrix\.gateway\.unifiedpush\.org|gateway\.mtxnode1\.privateline\.dev|g" '{}' \;

find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|im\.vector\.app\.android|dev\.privateline\.im\.android|g" '{}' \;

find "$app_conf_dir" -name config.xml -exec \
	sed -i '' -e "s|element\.io|im\.privateline\.dev|g" '{}' \;

unpatched_strings_file=.tmp_unpatched_strings
new_patched_strings_file=.tmp_new_patched_strings

patch_file_updated=0

# Remove Triple-T stuff to avoid using them in F-Droid
rm -rf "$mydir/vector/src/main/play/listings"

popd > /dev/null

echo "Seems like language is up-to-date :)"
