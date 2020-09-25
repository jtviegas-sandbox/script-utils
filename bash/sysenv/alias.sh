#!/bin/sh

this_folder="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
if [ -z "$this_folder" ]; then
  this_folder=$(dirname $(readlink -f $0))
fi

k8s_folder="$this_folder/k8s"
alias kctx='kubectl config set-context $(kubectl config current-context) --namespace '

