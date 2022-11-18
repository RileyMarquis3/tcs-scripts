#  Taken From
#  https://dev.to/mackr2015/bash-alias-and-functions-3782
#
## Git commands

alias gs='git status'
alias gb='git branch'
alias commit='git commit -m "simple update"'
alias gpush='git push origin master'
# Copy SSH public key
alias sshcopy='clip < ~/.ssh/id_rsa.pub && echo "~/.ssh/id_rsa.pub Copied to clipboard"'
alias sshkey="cat ~/.ssh/id_rsa.pub | pbcopy && echo 'Copied to Clipboard.'"

## Tasks

alias cd..='cd ../'
alias cd2='cd ../../'
alias ll='ls -lha'
alias cls='clear'
alias eval='eval $\(ssh-agent -s\)'

# Start the Wamp Manager
alias wamp='start /f/wamp64/wampmanager.exe'

# MySQL Import/Export
alias slqdump='mysqldump -uroot -p mydatabasename'
alias slqimport='mysql -uroot -p mydatabasename < db/import.sql'


## Tar export with gz command for import/export

### make dir and then export tar into that
alias tarexport='echo provide 2 params, 1 is the tar file and 2 is the dir where tar will be exported'
function tarexport() { mkdir "$2" && tar -xvf "$1" -C "$2"; }

## TAR compress

alias tarmake='echo provide 2 params, 1 is the tar filename \(with gz\) and 2 param is what will be compressed into tar.gz'
function tarmake() { tar -czvf "$1" "$2"; }

