### for i in *.txt;do cat $i >> output.txt;done
### cat *.js > merged_`date +%Y%m%d%H%M`.js
#
## TODO
# - Implement functions.

## Define Folder Variables ##
FuncDir="functions"
BackupDir="_Backups"

CheckFuncDir() {
## Sanity Check - Functions Folder ##
if [ ! -d $FuncDir ]; then 
	echo "ERROR!  Folder $FuncDir does not exist.  Quitting..."
	exit 1
fi
}

CheckBackupDir() {
## Sanity Check - Backups Folder ##
if [ ! -d $BackupDir ]; then
	echo "ERROR! Folder $BackupDir does not exist.  Quitting..."
	exit 2
fi
}

BlingLib="Bling_Library"
CheckLib() {
## Sanity Check - BlingLib ##
if [ ! -f $BlingLib ]; then
	echo "ERROR! File $BlingLib does not exist.  Quitting..."
	exit 3
fi
}

BlingBackup="BlingLibBackup"
BackupLib() {
## Backup Library If Exists ###
if [ -f $BlingLib ]; then
	echo "File $BlingLib Exists...Backing Up..."
	cp -v $BlingLib ./$BackupDir/$BlingBackup_`date +%Y%m%d%H%M`.blib
	echo "Backup Complete."
	echo "Removing existing Library..."
	rm $BlingLib
fi
}


BuildLib() {
# for i in $FuncDir/*.func;do cat $i > $BlingLib;done
cat $FuncDir/*.func > BlingBuild_`date +%Y%m%d%H%M`.blib
echo "BlingLib Rebuild Completed."
}

### Main Program ###
CheckFuncDir
CheckBackupDir
# CheckLib
BackupLib
BuildLib

