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


