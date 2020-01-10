#!/bin/bash  
source BackupFile.sh   
#APACHECONFIG='/etc/apache2/apache2.conf'
APACHECONFIG='apache2.conf'      

UnfollowSymLinks(){
    count=$(cat ${APACHECONFIG} | grep  -B 1 FollowSymLinks | grep -c "<Directory />")
    #echo "count = ${count}"

    if [ ${count} = 1 ]; then 
        echo "Best practices violation using 'Option FollowSymLinks':"
        echo "The root directory ('/') should not include the 'Option FollowSymLinks'."
        echo "Would you like to remove this property? (y/n) "
        read -r answer

        if [ ${answer} == 'y' ]; then
            echo "Backing up apache2.config file....."
            # backup function found in BackupFile.sh
            backup apache2.conf
            echo "...."
            sleep .25
            echo "Updating apache2.config file....."
            sleep .25
            echo "Disabling symbolic links for root directory......"
            sleep .25
            #here code to replace the line containing option indexes, with the line not containing option indexes (cut indexes)
            sed -i 's/ FollowSymLinks//' ${APACHECONFIG}
            #sed -i 's/+FollowSymLinks/-FollowSymLinks/' apache2.conf
            echo "........."
            sleep .25
            echo "apache2.config file successfully updated!"
            echo "........."
            sleep .25
            echo "Restarting Apache Server...."
            sleep .25
            system apache2 restart
            echo "Apache Server restarted. New configuration activated!"
            
        elif [ ${answer} == 'n' ]; then
            echo "Best practice not accepted by admin. Option FollowSymLinks in root directory will remain unchanged."

        else 
            echo "Please enter y for Yes or n for No" 
        fi;
    else
        echo "The root directory is not configured to follow symbolic links. Your server is already in compliance! No changes made."
    fi;
}
