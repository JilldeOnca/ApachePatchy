#Disable Unnecessary Modules script
#This script will present the user with a list of currently enable modules on the Apache server.
#After receiving the user's selection, will then disable the selected modules

#!/usr/bin/env bash
#source EnableModslist.sh

#Returns an array of enabled module
GenerateEnableModsList() {
    ModuleOutput=$(apache2ctl -M)
    modsOnly=$(echo $ModuleOutput | cut -d ":"  -f 2)
    IFS=')' read -ra ModulesList <<< $modsOnly 
}

#loop through list, executing disabling module
DisableMods(){
  for i in ${Mods2Disable[@]}; do
  echo "Disabling $i ${ModulesList[ $( expr  $i - 1 ) ]::-8}"

  #Disable module
  a2dismod -q ${ModulesList[ $( expr $i - 1 ) ]::-15}
  service apache2 restart
  echo "Done."
done
}

#main function
DisableUnnecessaryModules(){
echo "Best security practice suggest that Unnecessary or Unused modules be disabled."
echo "Here is a list of modules currently enabled on your web server:"

#Display list of enabled modules
GenerateEnableModsList

#Display list enabled modules on the screen
for ((i = 0 ; i < ${#ModulesList[@]} ; i++ )); do
  echo $( expr $i + 1 )  ${ModulesList[i]::-8} 
#  echo "i is $i"
#  echo -e "$( expr $i + 1 )  ${ModulesList[i]::-8} \t $( expr $i + 2 )  ${ModulesList[ $( expr $i + 1 ) ]::-8} \t $( expr $i + 3 )  ${ModulesList[ $( expr $i + 2 ) ]::-8} "
done

echo "Which modules would you like to disable? Enter Corresponding numbers separated by spaces( ) i.e. 3 11 15 23"

#Read in selection into list
IFS=' ' read -ra Mods2Disable

#Confirm selection
echo "You want to disable the following modules? Enter y to confirm or n to reenter your selection"
for ((i = 0 ; i < ${#Mods2Disable[@]} ; i++)); do
  echo "${Mods2Disable[i]} ${ModulesList[ $( expr  ${Mods2Disable[i]} - 1) ]::-8}"
done

IFS=' ' read -ra answer

if [ ${answer}=='y' ]; then
  DisableMods  
elif [ ${answer}=='n' ]; then
  echo "Here is a list of modules currently enabled on your web server:"
  for ((i = 0 ; i < ${#ModulesList[@]} ; i++)); do
    echo $( expr $i + 1 )  ${ModulesList[i]::-8} 
  done

  echo "Which modules would you like to disable? Enter Corresponding numbers separated by spaces, i.e. 3 11 15 23"

  #Read in selection into list
  IFS=' ' read -ra Mods2Disable
fi;
}