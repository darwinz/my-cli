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

function notes_forgit()
{
  echo -e "\ncommands\n\n"
  echo -e "Interactive git diff viewer (gd)\n
Interactive git reset HEAD <file> selector (grh)\n
Interactive git checkout <file> selector (gcf)\n
Interactive git checkout <branch> selector (gcb)\n
Interactive git checkout <commit> selector (gco)\n
Interactive git stash viewer (gss)\n
Interactive git clean selector (gclean)\n
Interactive git cherry-pick selector (gcp)\n
Interactive git rebase -i selector (grb)\n
Interactive git commit --fixup && git rebase -i --autosquash selector (gfu)\n\n"

  echo -e "\n\n⌨ Keybinds
Key	Action
Enter	Confirm
Tab	Toggle mark and move up
Shift - Tab	Toggle mark and move down
?	Toggle preview window
Alt - W	Toggle preview wrap
Ctrl - S	Toggle sort
Ctrl - R	Toggle selection
Ctrl - Y	Copy commit hash*
Ctrl - K / P	Selection move up
Ctrl - J / N	Selection move down
Alt - K / P	Preview move up
Alt - J / N	Prn\n\n"

  echo -e "\nforgit_log=glo
forgit_diff=gd
forgit_add=ga
forgit_reset_head=grh
forgit_ignore=gi
forgit_checkout_file=gcf
forgit_checkout_branch=gcb
forgit_checkout_commit=gco
forgit_clean=gclean
forgit_stash_show=gss
forgit_cherry_pick=gcp
forgit_rebase=grb
forgit_fixupn\n\n"
}
