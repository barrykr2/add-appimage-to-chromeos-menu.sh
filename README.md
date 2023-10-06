# add-appimage-to-chromeos-menu.sh
Linux on chromeOS.   Take an downloaded AppImage and make it executable and menu-ed 

Created by Barry Kruyssen 5th October 2023

This script does the following:
   Copies an AppImage to /home/barry/bin/appimages
   Cleans up previous link and desktop file (while preserving the Icon file)
   Creates a link to a generic <programName> and a link to the /home/barry/bin directory
   Creates an entry so the program is listed in the 'Linux apps' menus on the Chrome OS
Usage: /home/barry/bin/add-appimage-to-chromeos-menu.sh <programName> <downloadedFileName.AppImage>

All comments and improvements welcome

Reasoning:
    I run a chromebook with chromeOS and Linux containers.
    I use several Linux apps that I download as AppImages and manually create desktop files so the chromeOS will be listed in the "Linux apps" menu.
    I got sick of editing the desktop file every time I downloaded a new version.
    Oh! and I like coding.
