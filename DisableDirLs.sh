#!/bin/bash  
source BackupFile.sh        

DisableDirLs(){
    #count=$(cat /etc/apache2/apache2.conf | grep -c Indexes)
    count=$(cat apache2.conf | grep -c Indexes)
    #echo "count = ${count}"

    #if [ ${count} -gt 1 ]; then 
    # echo "too big"; 
    if [ ${count}>=1 ]; then 
        echo "Best practices violation in 'Option Indexes':"
        echo "The '/'' directory (root directory) should not include the 'Option Indexes'."
        echo "Would you like to remove this property? (y/n) "
        read -r answer

        if [ ${answer} == 'y' ]; then
            echo "Backing up apache2.config file....."
            # backup function found in BackupFile.sh
            backup apache2.conf
            echo "...."
            sleep .25
            echo "Updating apache2.config file with best practices choices(s)....."

            #here code to replace the line containing option indexes, with the line not containing option indexes (cut indexes)
            sed -i 's/ Indexes/ -Indexes/' apache2.conf
            sed -i 's/+Indexes/-Indexes/' apache2.conf

            echo "........."
            sleep .25
            echo "apache2.config file successfully updated!"

        elif [ ${answer} == 'n' ]; then
            echo "Best practice not accepted by admin. Option Indexes in root directory will remain unchanged."

        else 
            echo "Please enter y for Yes or n for No" 
        fi;

    fi;
}


