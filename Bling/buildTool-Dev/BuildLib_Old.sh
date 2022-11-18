### for i in *.txt;do cat $i >> output.txt;done

## TODO
# - Implement functions.


FuncDir="functions"
## Sanity Check - Functions Folder ##
if [ ! -d $FuncDir ]; then 
	echo "ERROR!  Folder $FuncDir does not exist.  Quitting..."
	exit 1
fi

BlingLib="Bling_Library"
## Sanity Check - BlingLib ##
### if [ ! -f $BlingLib ]; then
###	echo "ERROR! File $BlingLib does not exist.  Quitting..."
###	exit 2
### fi

BlingBackup="Blink_Library-Backup"
## Backup Library If Exists ###
if [ -f $BlingLib ]; then
	echo "File $BlingLib Exists...Backing Up..."
	cp -v $BlingLib $BlingLibBackup
	echo "Backup Complete."
	echo "Removing existing Library..."
	rm $BlingLib


for i in $FuncDir/*.func;do cat $i > $BlingLib;done
echo "BlingLib Rebuild Completed."

