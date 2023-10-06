#!/bin/bash

binDir="$HOME/bin"
appimageBaseDir="$HOME/bin/appimages"

# Check for the correct number of arguments
if [ "$#" -ne 2 ]; then
  echo "This script does the following:"
  echo "   Copies an AppImage to $appimageBaseDir"
  echo "   Cleans up previous link and desktop file (while preserving the Icon file)"
  echo "   Creates a link to a generic <programName> and a link to the $binDir directory"
  echo "   Creates an entry so the program is listed in the 'Linux apps' menus on the Chrome OS"
  echo "Usage: $0 <programName> <downloadedFileName.AppImage>"
  exit 1
fi

programName="$1"
downloadedFileName="$2"

appimageDir="$appimageBaseDir/$programName"
desktopFile="$HOME/.local/share/applications/$programName.desktop"
iconLine="Icon=$appimageDir/$programName.png"

# Create the directory to store AppImage files if it doesn't exist
mkdir -p "$appimageBaseDir"
mkdir -p "$appimageDir"

# Copy the downloaded AppImage to the program directory
if ! cp "$downloadedFileName" "$appimageDir/"; then
  echo "Failed to copy $downloadedFileName to $appimageDir"
  exit 1
fi

# Remove any symbolic links prior to creating new ones
rm -f "$binDir/$programName"

# Create a symbolic link with the desired name
ln -s "$appimageDir/$downloadedFileName" "$binDir/$programName"

# Check if desktop entry exists
if [ -f "$desktopFile" ]; then
  iconLineTmp=$(grep Icon "$desktopFile")

  if [ "x$iconLineTmp" != "x" ]; then
    iconLine=$(echo "$iconLineTmp")
  fi

  rm "$desktopFile"
fi

# Create the desktop entry file
cat <<EOL > "$desktopFile"
[Desktop Entry]
Type=Application
Name=$programName
Exec=$binDir/$programName
$iconLine
Categories=Utility;
EOL

# Make the desktop entry file executable
chmod +x "$desktopFile" "$appimageDir/$downloadedFileName" 

echo "AppImage '$downloadedFileName' for '$programName' has been added to the Chrome OS menu."
echo "    Edit the file $desktopFile"
echo "    to point to an Icon file (default is $iconLine)"

