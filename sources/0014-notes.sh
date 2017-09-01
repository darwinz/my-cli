#!/bin/sh

####################################################
##############  Notes and References  ##############
####################################################

##  Reference on how to use common screen functions
function notes_screen()
{
    echo -e "\nCreate a new screen session:\n  screen -S some_name\n\n"
    echo -e "Detach from screen:\n  Ctrl + A and then d\n\n"
    echo -e "View a shared screen:\n  screen -x some_name\n\n"
    echo -e "Go into previously attached screen:\n  screen -r\n\n"
    echo -e "Other commands:\n  screen -ls\n"
}

##  Reference on the command to use for posting to a remote web form including posting a file
function notes_remote_form_post_with_file()
{
    echo -e '\nPost form, including file, remotely with the following command:\n  curl -v -F "FileInputName=@/path/to/file.gif;OtherInputName=Value;OtherRequestK=Val;" http://formurl.com\n'
}
