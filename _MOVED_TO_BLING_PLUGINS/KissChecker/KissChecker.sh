echo "Kernel Indepth Static Sanity (KISS) Checker Tool"
echo "Version 0.1.2 - Developed by TCS Research."
# This script will run various static analyser checks on the Linux kernel, as per the Makefile.
#
### Core Commands- no logging ###
# make checkstack
# make versioncheck
# make includecheck
# make export_report
# make headerdep
# make coccicheck
# make clang-analyzer
# make clang-tidy

### TODO:###
#	Add Log By Date Capability
#	Add -a option to tee command as command line option?
#	Include cecho as library for fancy output.
#	Use colorized output from cecho.
#	[PENDING] Configure where log files will be stored.
#	Should we grep for certain major flaws that could be exposed by the logfiles?
#		e.g. instead of scanning for x, tool can do it for us.	



## --- Define Variables --- ###
LogDir="testlogs"

## Define Test Variable For Loop
## TestList=("checkstack versioncheck includecheck export_report headerdep coccicheck clang-analyzer clang-tidy")
## Disabled coccicheck due to length of time required to run
TestList=("checkstack versioncheck includecheck export_report headerdep clang-analyzer clang-tidy")
#
## FIXME: Program fails when testlogs folder and files not present; introduce sanity check.
#		if statement not working, does not create $LogDir.

if [ ! -d ${LogDir} ]
then
    mkdir -p ${LogDir}
fi

#
# Temp Fix For if Statement
## mkdir -p testlogs


### --- Main Program --- ###
for TestName in $TestList
do
	echo Running Static Analyzer Test $TestName... 
	make $TestName > $LogDir/$TestName.log
	echo Completed.  See $LogDir/$TestName.log For Results.
done
