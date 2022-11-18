# save-running-kconfig.sh
# This script will save the running kernel config to a file.

## TODO:  -Call BLING Lib
#         -Implement Variables
#         -use 'uname -r' for determining filename
#         -merge into KUtil (combines get and run)
#
### Define Vars ###
KVer="$(uname -r)"  # possibly incorrect definition - Test!
KFolder="/lib/modules/$uname -r)/build" # Needs Sanity Check.
KFileName="$uname -r).config
#
### Main Program ###
echo "Kutil: Save Kernel Config Utility"
echo "Kernel Version: $(uname -r)"
# cat /lib/modules/$(uname -r)/build/.config | tee running-kernel.config
cat $KFolder/.config | tee $KFileName # Test!  Alternate is below.
# cp -v $KFolder/.config $KFileName # Alternate implementation here.
echo "Kernel Config Saved To: $(uname -r).config.
