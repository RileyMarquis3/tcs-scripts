## KConfigTool - Gets and saves running kernel config.
# 
# save-running-kconfig.sh
# This script will save the running kernel config to a file.
#-------------------------------------------------------------------------------------------------------------------------#
## TODO:  -Call BLING Lib
#         -Implement Variables
#         -use 'uname -r' for determining filename
#         -merge into KUtil (combines get and run)
#         -add functions.
#         -enable calling functions as cmdlines.
#-----------------------------------------------------------------------------------------------------------------------------#

### Define Vars ###
KVer="$(uname -r)"  # possibly incorrect definition - Test!
KFolder="/lib/modules/$uname -r)/build" # Needs Sanity Check.
KFileName="$uname -r).config

#-----------------------------------------------------------------------------------------------------------------------------#

### BEGIN Functions ###
function DisplayBanner {
  echo "Kernel Config Utility"
  echo "Kernel Version: $(uname -r)"
}

function GetConfig {
  # cat /lib/modules/$(uname -r)/build/.config | more
  cat $KFolder/.config | more # Test! 
}

function SaveConfig {
  # cat /lib/modules/$(uname -r)/build/.config | tee running-kernel.config
  cat $KFolder/.config | tee $KFileName # Test!  Alternate is below.
  # cp -v $KFolder/.config $KFileName # Alternate implementation here.
  echo "Kernel Config Saved To: $(uname -r).config.
}

### END Functions ###
#----------------------------------------------------------------------------------------------------------------------#

### Run Program ###
DisplayBanner
GetConfig
SaveConfig
