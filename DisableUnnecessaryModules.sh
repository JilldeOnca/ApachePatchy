#Disable Unnecessary Modules script
#This script will present the user with a list of currently enable modules on the Apache server.
#After receiving the user's selection, will then disable the selected modules

#!/usr/bin/env bash
#source EnableModslist.sh

#Returns an array of enabled module
function GenerateEnableModsList() {
    ModuleOutput=$(apache2ctl -M)
    modsOnly=$(echo $ModuleOutput | cut -d ":"  -f 2)
    #ModulesList=() #Array of enabled modules
    IFS=')' 
    read -ra ModulesList <<< $modsOnly 
    #return $ModulesList
}


Intro(){
  echo "Best security practice suggest that Unnecessary or Unused modules be disabled.
}

Here is a list of modules currently enabled on your web server:"

#Display list of enabled modules
GenerateEnableModsList
#$EnabledMods="$(GenerateEnableModsList)"
#echo ${ModulesList[@]}


for ((i = 0 ; i < ${#ModulesList[@]} ; i++)); do
  echo $( expr $i + 1 )  ${ModulesList[i]::-8} 
done

echo "Which modules would you like to disable? Enter Corresponding numbers separated by spaces( ) i.e. 3 11 15 23"

#Read in selection into list
IFS=' ' read -ra Mods2Enable
#echo ${Mods2Enable[1]}

#Confirm selection
echo "You want to disable the following modules? Enter Y to confirm or N to reenter your selection"
for ((i = 0 ; i < ${#Mods2Enable[@]} ; i++)); do
  echo "${ModulesList[ $( expr  ${Mods2Enable[i]} - 1) ]::-8}"
done



#loop through list, executing disabling module
for ((i = 0 ; i < ${#Mods2Enable[@]} ; i++)); do
  echo "Disabling ${ModulesList[ $( expr  ${Mods2Enable[i]} - 1) ]::-8}"

  #Disable command
  # a2dismod <Module>
done