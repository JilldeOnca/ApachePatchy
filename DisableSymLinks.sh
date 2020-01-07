#!/bin/bash  
source BackupFile.sh        

DisableSymLinks(){
    #count=$(cat /etc/apache2/apache2.conf | grep -c Indexes)
    count=$(cat apache2.conf | grep -c FollowSymLinks)
    #echo "count = ${count}"

    #if [ ${count} -gt 1 ]; then 
    # echo "too big"; 
    if [ ${count}>=1 ]; then 
        echo "Best practices violation in 'Option FollowSymLinks':"
        echo "The '/'' directory (root directory) should not include the 'Option FollowSymLinks'."
        echo "Would you like to remove this property? (y/n) "
        read -r answer

        if [ ${answer}=='y' ]; then
            echo "Backing up apache2.config file....."
            # backup function found in BackupFile.sh
            backup apache2.conf
            echo "...."
            sleep .25
            echo "Updating apache2.config file with best practices choices(s)....."

            #here code to replace the line containing option indexes, with the line not containing option indexes (cut indexes)
            sed -i 's/FollowSymLinks/-FollowSymLinks/' apache2.conf
            sed -i 's/+FollowSymLinks/-FollowSymLinks/' apache2.conf

            echo "........."
            sleep .25
            echo "apache2.config file successfully updated!"
        elif [ ${answer}=='n' ]; then
            echo "Best practice not accepted by admin. Option Indexes in root directory will remain unchanged."
        fi;

    fi;
}


