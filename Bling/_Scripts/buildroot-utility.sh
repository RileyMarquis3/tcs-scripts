### BuildRoot Utility ###
#   Version 0.1
#   This utility will check the size of the buildroot and clean it when needed.
#
BuildRoot_Root="/root/buildroot"
## TODO: Add amiroot.sh fucntionality as function
#
BuildRoot_Kbuild="/home/kbuild/buildroot"
# Needs testing - Can be removed upon implementation and testing of BuildRoot_CurrentUser.
#
BuildRoot_CurrentUser="~/buildroot"
# Needs Testing.  Can supercede other options once testing completed.
#
### TODO: 	Introduce Sanity Checks.
#		Finish and test variable functionality.
#		Add buildroot backup function.
#		Integrate functions into program.

### Variable Definitions ###
FolderList="BUILD BUILDROOT"

Size_BuildRoot() {
	du -sh BUILD
	du -sh BUILDROOT
}

Clean_BuildRoot() {  ## Add Y/N Sanity Check before deleting.
	rm -rfv BUILD/*
	rm -rfv BUILDROOT/*
}

Backup_BuildRoot() {  ## Can call TarMonster when ready.
	## TODO: Add date utility functionality.
	tar -cvf Build.tar BUILD
	tar -cvf BuildRoot.tar BUILDROOT


