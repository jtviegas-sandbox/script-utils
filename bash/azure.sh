this_folder=$(dirname $(readlink -f $0))
if [ -z $this_folder ]; then
  this_folder="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
fi
parent_folder=$(dirname $this_folder)

LOG_TRACE=TRUE

.  "$this_folder"/commons.sh

az storage blob sync --container \$web --source /Users/jtviegas/Documents/bitbucket/online-pricing/pricing-app/app/target/classes/META-INF/resources --account-name pennydevwebsite


deployWebsite()
{
    goin "deployWebsite"
    
    local __aws_url=$1
    local _aws_url_option=""
    if [ ! -z "$__aws_url" ]; then
        _aws_url_option="--endpoint-url=$__aws_url"
    fi
    
    info "current buckets:"
    aws s3 ls
    info "current tables:"
    aws dynamodb --output text list-tables
    info "current policies:"
    aws iam list-policies --output text | grep $PROJ
    
    goout "deployWebsite"
}






