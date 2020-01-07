#!/usr/bin/env bash
source DisableDirLs.sh
source DisableSymLinks.sh

echo "Welcome to ApachePatchy"
echo "Please choose the configuration you would like to make more secure."
echo "A. Disable Directory Listing on your server"
echo "B. Disable Following Symbolic Links on your server"

read -r selection

echo $selection

if [[ $selection == 'A' ]]; then
    echo "selection Indexes"
    DisableDirLs
elif [[ $selection == 'B' ]]; then
    echo "selection SymLinks"
    DisableSymLinks
fi





