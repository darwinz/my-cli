#!/bin/sh

####################################################
##############  File-Related Functions #############
####################################################

##  Search in a specified path for files containing text content specified while ignoring files in .svn and .idea folders
##  @argument  $1 path to search
##  @argument  $2 content to search for
srch() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nsrch\n\nSearch in a specified path for files containing text content specified while ignoring files in .svn and .idea folders\n  @argument  \$1 path to search\n  @argument  \$2 content to search for\n  Usage example:  srch . sometext"
        kill -INT $$
    fi

    find "$1" -type f -not -path '*.svn*' -and -not -path '*.idea*' -exec grep -rn "$2" {} \;;
}

##  Override builtin cd - display specified path, change working directory to specified path, and then list all files in that directory
##  @argument  $@ path to cd into
cd() {
    builtin cd "$@"
    if [ -d "$@" ]; then
        pwd
    fi
    ll
}

##  Change working directory to specified path without showing the list of files in that directory (as opposed to cd which lists all files)
##  @argument  $@ path to cd into
cdnl() { builtin cd "$@"; }

##  Create directory at specified path and change working directory to that specified path
##  @argument  $1 path to mkdir and cd into
mcd() { mkdir -p "$1" && cd "$1"; }

##  Move specified path to Trash
##  @argument  $@ path to move to Trash
trash() { command mv "$@" ~/.Trash ; }

##  Change directory to frontmost window of MacOS Finder
cdf() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\ncdf\n\nChange directory to frontmost window of MacOS Finder\n  No arguments\n  Usage example:  cdf"
        kill -INT $$
    fi

    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
                set currFolder to (folder of the front window as alias)
            on error
                set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

##  Change directory to frontmost window of MacOS Path Finder
cdpf() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\ncdpf\n\nChange directory to frontmost window of MacOS Path Finder\n  No arguments\n  Usage example:  cdpf"
        kill -INT $$
    fi

    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Path Finder"
            try
                set currFolder to the POSIX path of the target of the front finder window
            on error
                set currFolder to "~/Projects"
            end try
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

##  Extract most known archives with one command
##  @argument  $1 Filepath to archive to be extracted
extract() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nextract\n\nExtract most known archives with one command\n  @argument  \$1 filepath to archive to be extracted\n  Usage example:  extract file.tar.gz"
        kill -INT $$
    fi

    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

##  Create a file that contains random contents with a specified size and filepath as prompted by the program
file_create() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nfile_create\n\nCreate a file that contains random contents with a specified size and filepath as prompted by the program\n  No arguments - prompts for user input\n  Usage example:  file_create"
        kill -INT $$
    fi

    read -p "How large should the file be in MB? " filesize
    bytes=$(($filesize*2**10))

    read -p "Please enter the full path for the new file " filepath

    dd if=/dev/random of=${filepath} bs=1 count=${bytes}
}

##  Encrypt a file using a DES3 hash
##  @argument  Filepath of file to be encrypted
encrypt() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nencrypt\n\nEncrypt a file using a DES3 hash\n  @argument  \$1 Filepath of file to be encrypted\n  Usage example:  encrypt file.txt"
        kill -INT $$
    fi

    if [ -f ${1} ]; then
        openssl des3 -salt -in ${1} -out ${1}.des3
        rm ${1}
    fi
}

##  Decrypt a file that was encrypted using a DES3 hash
##  @argument  Filepath of file to be decrypted
decrypt() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\ndecrypt\n\nDecrypt a file that was encrypted using a DES3 hash\n  @argument  \$1 Filepath of file to be decrypted\n  Usage example:  decrypt file.txt.des3"
        kill -INT $$
    fi

    if [ -f ${1} ]; then
        openssl des3 -salt -d -in ${1} -out ${1%?????}
    fi
}

##  Search for a file using MacOS Spotlight's metadata
##  @argument  $@ Name or partial name of file
spotlight() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nspotlight\n\nSearch for a file using MacOS Spotlight's metadata\n  @argument  \$@ Name or partial name of file\n  Usage example:  spotlight somefile.php"
        kill -INT $$
    fi

    mdfind "kMDItemDisplayName == '$@'wc";
}

##  Find file under the current working directory
##  @argument  Name or partial name of file
ff() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nff\n\nFind file under the current working directory\n  @argument  \$1 Name or partial name of file\n  Usage example:  ff somefile.php"
        kill -INT $$
    fi

    /usr/bin/find . -name "$@" ;
}

##  Find file whose name starts with a given string under the current working directory
##  @argument  Name or partial name of file
ffs() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nffs\n\nFind file whose name starts with a given string under the current working directory\n  @argument  \$1 Name or partial name of file\n  Usage example:  ffs somefile.php"
        kill -INT $$
    fi

    /usr/bin/find . -name "$@"'*' ;
}

##  Find file whose name ends with a given string
##  @argument  Name or partial name of file
ffe() {
    if [ "${1}" == "-help" ] || [ "${1}" == "help" ] || [ "${1}" == "--help" ]; then
        echo -e "\nffs\n\nFind file whose name ends with a given string under the current working directory\n  @argument  \$1 Name or partial name of file\n  Usage example:  ffe somefile.php"
        kill -INT $$
    fi

    /usr/bin/find . -name '*'"$@" ;
}

file_get_wherefrom(){
    xattr -p com.apple.metadata:kMDItemWhereFroms "${1}" | xxd -r -p | \
	plutil -convert xml1 -o - - | xmllint --xpath "/plist/array/string/text()" -
	echo "$SUFFIX\c"
}

########################################################
##############  End File-Related Functions #############
########################################################
