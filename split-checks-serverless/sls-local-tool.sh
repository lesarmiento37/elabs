#!/bin/bash

set +x

if [ $# == 0 ]; then
	SHOW_HELP=YES
elif [ $# == 1 ] && [ $1 == "--help" ]; then
	SHOW_HELP=YES
fi

# Process parameters
while [[ $# > 1 ]]
do
key="$1"

case $key in
 -p|--profile)
    PROFILE="$2"
    shift # past argument
    ;;
esac
shift # past argument or value
done

run_help(){
	echo "Usage: $0 [options] "
	echo "Options:"
	echo "  -p  , --profile : The aws profile to use"
	echo ""
    exit 0
}

if [ "$PROFILE" == "" ]; then
    echo "ERROR: The --profile/-p flag is required...."
    exit 1
fi

sls_install(){
    npm install
}

sls_deploy(){
    sls_install
    npm run deploy ---awsProfile=$PROFILE --awsEnv=$PROFILE
}

sls_install
sls_deploy