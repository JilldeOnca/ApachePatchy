#!/bin/bash  
source BackupFile.sh        
#SECURITYCONFIG='/etc/apache2/conf-available/security.conf'
SECURITYCONFIG='security.conf'

DisableServerSig(){
    count=$(cat ${SECURITYCONFIG} | grep  -c "ServerSignature On")
    echo ${count}

    if [ ${count} = 1 ]; then 
        echo "Best practices violation 'ServerSignature' is on:"
        echo "Your website should not display the server details."
        echo "Would you like to remove this property? (y/n) "
        read -r answer

        if [ ${answer} == 'y' ]; then
            echo "Backing up security.config file....."
            # backup function found in BackupFile.sh
            backup security.conf
            echo "...."
            sleep .25
            echo "Updating security.config file....."
            sleep .25
            echo "Disabling server signature for website....."
            sleep .25
            #here code to replace the line containing option indexes, with the line not containing option indexes (cut indexes)
            sed -i 's/ServerSignature On/ServerSignature Off/' ${SECURITYCONFIG}
            #sed -i 's/+FollowSymLinks/-FollowSymLinks/' apache2.conf
            echo "........."
            sleep .25
            echo "security.config file successfully updated!"
            
        elif [ ${answer} == 'n' ]; then
            echo "Best practice not accepted by admin. ServerSignature will remain unchanged ('On')."
        else 
            echo "Please enter y for Yes or n for No" 
        fi;
    else
        echo "The website is not configured to display server details. Your server is already in compliance, no changes made."
    fi;
}
