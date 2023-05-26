# add-fcontext-mediafiles.sh
# This script will allow files in $MediaFilesDir to be accessible via Samba shares,
#  and files in WebRootDir to be accessible as web pages.
#
# This script can be called via cron when ready.

## Define Vars - Folders ###
## TODO: Add Sanity Checks via BLING.
MediaFilesDir="/home/mediafiles"
WebRootDir="/var/www/html"

## Define Vars - Contexts ##
Type_SMB="samba_share_t"
Type_HTTPD="httpd_sys_content_t"

## Define Vars - ProgName & CmdLine ###
ProgName="semanage"
CmdLines=" --add --type"

## Main Program ##
# semanage --fcontext --add --type samba_share_t /home/mediafiles
# semanage --fcontext --add --type samba_share_t $MediaFilesDir
## Testing 11-2022 ##
## TODO: Allow variables to be passed as cmdlines args.
  e.g. 'add-fcontext SMB MediaFiles'
$ProgName $CmdLines $Type_SMB $MediaFilesDir
$ProgName $CmdLines $$Type_HTTPD $WebRootDir
echo "SELinux context type(s) applied successfully."
