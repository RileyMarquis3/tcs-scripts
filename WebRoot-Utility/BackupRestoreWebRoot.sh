## Taken From
#https://stackoverflow.com/questions/6212219/passing-parameters-to-a-bash-function

## This can assist with the development of TarMonster.
#
#
# Bash style declaration for all you PHP/JavaScript junkies. :-)
# $1 is the directory to archive
# $2 is the name of the tar and zipped file when all is done.
#

### Declare Our Variables ###
WebRootDir='/var/www/html'           # This will change based on distro; need to auto-detect and change based on which distro.
BackupDir='/home/webrootbackups'  # EXAMPLE - change to something more useful.

##### Backup Functions #####

function BackupWebRoot ()
{
    tar -cvf - "$1" | zip -n .jpg:.gif:.png "$2" - 2>> $errorlog &&
        echo -e "\nTarball created!\n"
}


# sh style declaration for the purist in you. ;-)
# $1 is the directory to archive
# $2 is the name of the tar and zipped file when all is done.
BackupWebRoot ()
{
    tar -cvf - "$1" | zip -n .jpg:.gif:.png "$2" - 2>> $errorlog &&
        echo -e "\nTarball created!\n"
}


# In the actual shell script
# $0               $1            $2

BackupWebRoot $WebRootDir/ webSite.tar.zip

##### Restore Functions #####
function RestoreWebRoot ()
{
    tar -xvf - "$1" | zip -n .jpg:.gif:.png "$2" - 2>> $errorlog &&
        echo -e "\nTarball created!\n"
}


# sh style declaration for the purist in you. ;-)
# $1 is the directory to archive
# $2 is the name of the tar and zipped file when all is done.
RestoreWebRoot ()
{
    tar -xvf - "$1" | zip -n .jpg:.gif:.png "$2" - 2>> $errorlog &&
        echo -e "\nTarball created!\n"
}


# In the actual shell script
# $0               $1            $2

RestoreWebRoot $WebRootDir/ webSite.tar.zip
