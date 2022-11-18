### for i in *.txt;do cat $i >> output.txt;done
### cat *.js > merged_`date +%Y%m%d%H%M`.js
#
## TODO
# - Implement functions.


FuncDir="functions"
CheckFunc() {
## Sanity Check - Functions Folder ##
if [ ! -d $FuncDir ]; then 
	echo "ERROR!  Folder $FuncDir does not exist.  Quitting..."
	exit 1
fi
}

BlingLib="Bling_Library"
CheckLib() {
## Sanity Check - BlingLib ##
if [ ! -f $BlingLib ]; then
	echo "ERROR! File $BlingLib does not exist.  Quitting..."
	exit 2
fi
}

BlingBackup="Blink_Library-Backup"
BackupLib() {
## Backup Library If Exists ###
if [ -f $BlingLib ]; then
	echo "File $BlingLib Exists...Backing Up..."
	cp -v $BlingLib $BlingLibBackup_`date +%Y%m%d%H%M`.blib
	echo "Backup Complete."
	echo "Removing existing Library..."
	rm $BlingLib
}

BuildLib() {
# for i in $FuncDir/*.func;do cat $i > $BlingLib;done
cat $FuncDir/*.func > BlingBuild_`date +%Y%m%d%H%M`.blib
Echo BlingLib Rebuild Completed.
}

### Main Program ###
# CheckLib
BackupLib
BuildLib

