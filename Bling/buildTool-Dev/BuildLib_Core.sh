### for i in *.txt;do cat $i >> output.txt;done
### cat *.js > merged_`date +%Y%m%d%H%M`.js
#
#
## TODO
# - Implement functions.


FuncDir="functions"
## Sanity Check - Functions Folder ##
if [ ! -d $FuncDir ]; then 
	echo "ERROR!  Folder $FuncDir does not exist.  Quitting..."
	exit 1
fi


# for i in $FuncDir/*.func;do cat $i > $BlingLib;done
cat $FuncDir/*.func > BlingBuild_`date +%Y%m%d%H%M`.blib
echo "BlingLib Rebuild Completed."

