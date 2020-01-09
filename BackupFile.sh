#!/usr/bin/env bash

#save a backup of file to the "backup_config" directory
#Syntax: backup <file name>
backup(){
    
    #Checks for the backup_config directory
    if [[ ! -d "backup_config" ]]; then 
        mkdir backup_config
    fi

    #Copies current file into the Backup directory
    cp --backup=numbered $1 backup_config/$1

}

#Checks that a file has been passed into this script as the second agrument ($1) in the CLI
#if [[ -e $1 ]]; then 
#    backup "$1"
#else
#    echo "Error: Missing file name"
#    echo "Syntax: ./BackupFile.sh <file name>"
#fi

