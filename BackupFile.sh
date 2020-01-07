#!/usr/bin/env bash

#save a backup of file to the backup directory
backup(){
    
    #Checks for the backup_config directory
    if [[ -d "backup_config" ]]; then 
        echo "backup directory exists"
    else
        mkdir backup_config
        echo "Backup directory created"
        ls 
    fi

    #Creates a new file name for the backup file. This file name contains time of it's creation.
    fileName="$1"
    newFileName=($(date +%m%d%Y%H%M%S)$fileName)
    echo "new file: $newFileName"

    #Copies current file into the Backup directory under the new file name
    echo "cp ${fileName} backup_config/${newFileName}"
    cp $fileName backup_config/${newFileName}
    ls backup_config/
}


 backup "$1"