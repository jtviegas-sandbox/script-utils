#!/bin/sh


this_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
parent_folder=$(dirname $this_folder)

# parameter check
usage()
{
        cat <<EOM
        usage:
        $(basename $0) <encoded encrypted msg>
EOM
        exit 1
}

[ -z "$1" ] && { usage; }

#echo "$msg" | base64 | keybase pgp encrypt | keybase pgp decrypt | base64 --decode

__msg="$@"
__r=0
__out=`keybase pgp decrypt -m "$__msg" | base64 --decode`
__r=$?

if [ ! "$__r" -eq "0" ] ; then
    echo "!!! no luck !!!"
    exit $__r
fi

echo "$__out"
