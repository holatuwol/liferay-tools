#!/opt/local/bin/bash

case "$PWD" in
	*liferay-faces-alloy*|\
		*liferay-faces-bridge-ext*|\
		*liferay-faces-generator*|\
		*liferay-faces-maven*|\
		*liferay-faces-metal*|\
		*liferay-faces-portal*)
		PROFILE_ARG="--profile=liferay-faces"
	;;
	*liferay-faces-*)
		PROFILE_ARG=""
	;;
	*)
		PROFILE_ARG="--profile=liferay-faces"
	;;
esac

~/Tools/jalopy-1.9.5/bin/jalopy.sh $PROFILE_ARG "$@"
