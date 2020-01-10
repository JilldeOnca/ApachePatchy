#!/usr/bin/env bash
source DisableDirLs.sh
source DisableCGIScripts.sh
source DisableServerSig.sh
source UnfollowSymLinks.sh
source DisableUnnecessaryModules.sh

APACHECONFIG='/etc/apache2/apache2.conf'
#APACHECONFIG='apache2.conf' 
#SECURITYCONFIG='/etc/apache2/conf-available/security.conf'
SECURITYCONFIG='security.conf'

echo "Welcome to SaferServer!"
echo
echo "Please choose the configuration you would like to make more secure:"
echo -e '\t [A] Disable Directory Listing (Indexing) on your server'
echo -e "\t [B] Disable Following Symbolic Links on your server"
echo -e "\t [C] Disable CGI Script Execution on your server"
echo -e "\t [D] Disable Server Signature on your server"
echo -e "\t [E] Disable Unnecessary Modules on your server"
echo -e "\t [X] to EXIT SaferServer"

read -r selection

#echo $selection
while [[ ($selection != 'X') && ($selection != 'x') ]]; do
#echo $selection

    if [[ ($selection == 'A') || ($selection == 'a') ]]; then
        echo "Scanning configuration for enabled indexing of the root directory....."
        DisableDirLs
        sleep .50
    elif [[ ($selection == 'B') || ($selection == 'b') ]]; then
        echo "Scanning configuration for enabled symbolic linking from the root directory....."
        UnfollowSymLinks
        sleep .50
    elif [[ ($selection == 'C') || ($selection == 'c') ]]; then
        echo "Scanning configuration for enabled CGI execution at the root directory....."
        DisableCGIScripts
        sleep .50
    elif [[ ($selection == 'D') || ($selection == 'd') ]]; then
        echo "Scanning configuration for enabled server signature on your website....."
        DisableServerSig
        sleep .50
    elif [[ ($selection == 'E') || ($selection == 'e') ]]; then
        echo "Scanning configuration for active modules....."
        DisableUnnecessaryModules
        sleep .50
    fi  
    echo    
    echo "Please choose the configuration you would like to make more secure:"
    echo -e '\t [A] Disable Directory Listing (Indexing) on your server'
    echo -e "\t [B] Disable Following Symbolic Links on your server"
    echo -e "\t [C] Disable CGI Script Execution on your server"
    echo -e "\t [D] Disable Server Signature on your server"
    echo -e "\t [E] Disable Unnecessary Modules on your server"
    echo -e "\t [X] to EXIT SaferServer"
    read -r selection
done
sleep .3
echo "Exiting SaferServer - be safe!"
