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

function notes_k8s()
{
  echo -e "\nkubectl config get-contexts
  kubectl config set-context {context}
  kubectl -n {namespace} get pods
  kubectl -n {namespace} exec -it {pod} -- bash
  kubectl -n {namespace} get deployments
  kubectl -n {namespace} get configmaps
  kubectl -n {namespace} delete pod {pod}
  kubectl -n {namespace} port-forward {pod} {ip}:{ip}
  kubectl -n {namespace} describe pod {pod}
  kubectl -n {namespace} scale --replicas={number} deployment {deployment}
  kubectl -n {namespace} patch pvc {pvc-name} -p '{\"metadata\":{\"finalizers\": []}}' --type=merge
  kubectl cluster-info
  kubectl get secret {secret-name} -n {namespace} -o yaml
  kubectl get secret {secret-name} -n {namespace} -o yaml | grep {some-search-value}
  kubectl cp -c {container} {namespace}/{pod}:{full-remove-file-path} {local-file-path}
  kubectl cp -c {container} {local-file-path} {namespace}/{pod}:{full-remote-file-path}\n\n"
}

function notes_helm()
{
  echo -e "\nhelm search hub prometheus-community --max-col-width 100
  helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
  helm repo add prometheus https://prometheus-community.github.io/helm-charts
  helm show values prometheus-community/prometheus
  helm list -n {k8s-namespace}
  helm delete prometheus -n {k8s-namespace}\n\n"
}

function notes_terraform()
{
  echo -e "\nterraform login
  terraform init
  terraform plan
  terraform plan -out out/file/path
  terraform apply -target module.path
  terraform apply "plan/file/path"
  terraform import module.path [...arguments]
  terraform state list
  terraform state show
  terraform state show module.path
  terraform state mv module.path new.module.path
  terraform state rm module.path
  terraform state pull
  terraform state push
  terraform validate
  terraform fmt
  terraform taint module.path

  # dangerous/caution
  terraform destroy -target module.path
  terraform force-unlock {lock-id}\n\n"
}

function notes_gcloud()
{
  echo -e "\ngcloud init
  gcloud init --console-only
  gcloud auth login
  gcloud config list
  gcloud container clusters get-credentials {gcloud-project-id} --zone us-central1-a
  gcloud components install docker-credential-gcr
  gcloud auth configure-docker
  gcloud container images list
  gcloud container images list --repository={hostname}/{gcr-project-id}
  gcloud container images list-tags
  gcloud container images list-tags gcr.io/true-bit-256021/{gcr-project-id}
  gcloud components install kubectl
  gcloud compute addresses list\n\n"
}

function notes_packer()
{
  echo -e "\npacker init {packer-hcl-file}
  packer build -var-file=./{packer-var-file} [-debug] [-on-error=ask] {packer-hcl-file}\n\n"
}

function notes_blackbox()
{
  echo -e "\nblackbox_initialize
  gpg --list-keys
  blackbox_addadmin {admin-gpg-key}
  blackbox_register_new_file {filename}
  blackbox_edit_start {gpg-encrypted-file-path}
  blackbox_edit_end {edited-file}
  blackbox_diff
  blackbox_decrypt_all_files
  blackbox_shred_all_files
  blackbox_postdeploy\n\n"
}

function notes_jo()
{
  echo -e "\nhttps://github.com/jpmens/jo/blob/master/jo.md\n"
  echo -e "\njo name=Brandon
  {\"name\": \"Brandon\"}
  \njo tst=1457081292 lat=12.3456 cc=FR badfloat=3.14159.26 name=\"JP Mens\" nada= coffee@T
  {\"tst\":1457081292,\"lat\":12.3456,\"cc\":\"FR\",\"badfloat\":\"3.14159.26\",\"name\":\"JP Mens\",\"nada\":null,\"coffee\":true}
  \njo -p -a *
  [\"Makefile\", \"README.md\", \"jo.1\", \"jo.c\", \"jo.pandoc\", \"json.c\", \"json.h\"]
  \njo -p name=JP object=\$(jo fruit=Orange hungry@0 point=\$(jo x=10 y=20 list=\$(jo -a 1 2 3 4 5)) number=17) sunday@0
  {
    \"name\": \"JP\",
    \"object\": {
      \"fruit\": \"Orange\",
      \"hungry\": false,
      \"point\": {
        \"x\": 10,
        \"y\": 20,
        \"list\": [
          1,
          2,
          3,
          4,
          5
        ]
      },
      \"number\": 17
    },
    \"sunday\": false
  }"
}

function notes_termtosvg()
{
  echo -e "\nhttps://github.com/nbedos/termtosvg\n"
  echo -e "\n$ termtosvg
  Recording started, enter "exit" command or Control-D to end
  \n$ exit
  Recording ended, file is /tmp/termtosvg_exp5nsr4.svg"
}

function notes_httpie()
{
  echo -e "\nhttps://httpie.io/docs/cli/examples\n"
  echo -e "\nhttp PUT pie.dev/put X-API-Token:123 name=John
  http -f POST pie.dev/post hello=World
  http -v pie.dev/get
  \n\n// Use https
  https example.org
  \n\n// Build and print a request without sending it
  http --offline pie.dev/post hello=offline
  \n\n// With authentication
  http -a USERNAME POST https://api.github.com/repos/httpie/httpie/issues/83/comments body='HTTPie is awesome! :heart:'
  \n\n// Upload a file
  http pie.dev/post < files/data.json
  \n\n// Download a file
  http pie.dev/image/png > image.png
  \n\n// Using named session to persist between requests
  http --session=logged-in -a username:password pie.dev/get API-Key:123
  http --session=logged-in pie.dev/headers
  \n\n// Use query string params
  http https://api.github.com/search/repositories q==httpie per_page==1"
}

function notes_lsd()
{
  echo -e "\nhttps://github.com/Peltoche/lsd\n"
}

function notes_rip()
{
  echo -e "\nhttps://github.com/nivekuil/rip\n"
}

function notes_zoxide()
{
  echo -e "\nhttps://github.com/ajeetdsouza/zoxide\n"
  echo -e "\n\nZoxide (z) remembers each time you cd into a directory and ranks them for next time\n"
  echo -e "\n\nUse <space>+<tab> to pull up the prompt\n"
}

function notes_dust()
{
  echo -e "\nhttps://github.com/bootandy/dust\n"
  echo -e "\n\nUsage: dust
  Usage: dust <dir>
  Usage: dust <dir>  <another_dir> <and_more>
  Usage: dust -p (full-path - Show fullpath of the subdirectories)
  Usage: dust -s (apparent-size - shows the length of the file as opposed to the amount of disk space it uses)
  Usage: dust -n 30  (Shows 30 directories instead of the default [default is terminal height])
  Usage: dust -d 3  (Shows 3 levels of subdirectories)
  Usage: dust -D (Show only directories (eg dust -D))
  Usage: dust -r (reverse order of output)
  Usage: dust -H (si print sizes in powers of 1000 instead of 1024)
  Usage: dust -X ignore  (ignore all files and directories with the name 'ignore')
  Usage: dust -x (Only show directories on the same filesystem)
  Usage: dust -b (Do not show percentages or draw ASCII bars)
  Usage: dust -i (Do not show hidden files)
  Usage: dust -c (No colors [monochrome])
  Usage: dust -f (Count files instead of diskspace)
  Usage: dust -t (Group by filetype)
  Usage: dust -z 10M (min-size, Only include files larger than 10M)
  Usage: dust -e regex (Only include files matching this regex (eg dust -e \"\.png$\" would match png files))
  Usage: dust -v regex (Exclude files matching this regex (eg dust -v \"\.png$\" would ignore png files))\n"
}

function notes_fd()
{
  echo -e "\nFind replacement\n"
  echo -e "\n\nhttps://github.com/sharkdp/fd\n"
  echo -e "\n\nfd sometext\n"
  echo -e "\nfd sometext --type f\n"
  echo -e "\nfd sometext --type d\n"
  echo -e "\nregex: fd '^x.*rc$'\n"
  echo -e "\specify root in 2nd arg: fd passwd /etc\n"
}

function notes_sd()
{
  echo -e "\nSed replacement\n"
  echo -e "\n\nhttps://github.com/chmln/sd\n"
  echo -e "\n\nsd text replacement dump.json\n"
  echo -e "\nsd \"\\\"\" \"'\" *.json >/dev/null\n"
  echo -e "\necho 'lots((([]))) of special chars' | sd -s '((([])))' ''\n"
  echo -e "\necho 'lorem ipsum 23   ' | sd '\s+$' ''\n"
}

function notes_procs()
{
  echo -e "\nps replacement\n"
  echo -e "\n\nhttps://github.com/dalance/procs\n"
  echo -e "\n\nprocs\n"
  echo -e "\nprocs zsh\n"
  echo -e "\nprocs --or 6000 60000 60001 16723\n"
  echo -e "\nprocs --and docker nerd\n"
  echo -e "\nprocs --tree\n"
  echo -e "\nSORT: procs --sortd cpu\n"
  echo -e "\nSORT ASC: procs --sorta cputime\n"
}

function notes_bottom()
{
  echo -e "\ncomplementary to top\n"
  echo -e "\n\nhttps://github.com/ClementTsang/bottom\n"
  echo -e "\n\nbtm\n"
  echo -e "\nbtm --help\n"
}

function notes_topgrade()
{
  echo -e "\nKeeping your system up to date\n"
  echo -e "\n\nhttps://github.com/topgrade-rs/topgrade\n"
  echo -e "\n\ntopgrade\n"
}

function notes_broot()
{
  echo -e "\nTree alternative - with interactivity and file previewing\n"
  echo -e "\n\nhttps://github.com/Canop/broot\n"
}

function notes_tokei()
{
  echo -e "\ndisplays statistics about your code\n"
  echo -e "\n\nhttps://github.com/XAMPPRocky/tokei\n"
  echo -e "\n\ntoken ./foo\n"
  echo -e "\ntokei ./foo, ./bar, ./baz\n"
  echo -e "\ntokei ./foo --exclude *.rs\n"
}

function notes_eva()
{
  echo -e "\nCLI REPL calculator\n"
  echo -e "\n\neva\n"
  echo -e "\n2 ^ 5 ^ 2\n"
  echo -e "\n33,554,432.0\n"
  echo -e "\nlog(sqrt(100))\n"
  echo -e "\nsin(45 + 5 * 9)\n"
  echo -e "\n 1.0 \n"
}

function notes_op()
{
  echo -e "\nCLI for 1Password\n"
  echo -e "\n\nhttps://github.com/1Password/shell-plugins\n"
  echo -e "\nop item list | grep <item name>\n"
  echo -e "\nop get item <item name>\n"
  echo -e "\nop get item <item name> --fields <field name>\n"
  echo -e "\nop document list | grep <item name>\n"
  echo -e "\nop get document <document name>\n"
}
