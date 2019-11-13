#!/bin/sh

this_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
parent_folder=$(dirname $this_folder)

#echo "this_folder: ${this_folder}"

if [ ! -f "${this_folder}"/include ]; then
    echo "must provide an include file exporting, at least, variables SYS_SCRIPTS_SRC and SYS_SCRIPTS_TARGET" && return 1;
fi

. "${this_folder}"/include

if [ -z "$SYS_SCRIPTS_SRC" ] || [ -z "$SYS_SCRIPTS_TARGET" ]; then
        echo "include file must export vars SYS_SCRIPTS_SRC and SYS_SCRIPTS_TARGET" && return 1;
fi

for _f in `ls ${SYS_SCRIPTS_SRC}/`
do
    sys_script=${SYS_SCRIPTS_TARGET}/${_f/.sh/}
    source_script=${SYS_SCRIPTS_SRC}/$_f
    if [ ! -e $sys_script ]
    then
        echo "linking ${sys_script} to ${source_script}"
        ln -s ${source_script} ${sys_script}
    else
        echo "${sys_script} already linked to ${source_script}"
    fi
done

if [ command -v pyenv 1>/dev/null 2>&1 ]
then 
    eval "$(pyenv init -)"
fi


