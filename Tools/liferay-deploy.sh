#!/opt/local/bin/bash

################################################################################
#
# Copyright (c) 2000-2017 Liferay, Inc. All rights reserved.
#
# This library is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the Free
# Software Foundation; either version 2.1 of the License, or (at your option)
# any later version.
#
# This library is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
# details.
#
################################################################################

DIRS_TO_SEARCH=()

if [ -d "./demo" ]; then
	DIRS_TO_SEARCH+=("./demo")
fi

if [ -d "./demos" ]; then
	DIRS_TO_SEARCH+=("./demos")
fi

if [ -d "./issue" ]; then
	DIRS_TO_SEARCH+=("./issue")
fi

if [ -d "./issues" ]; then
	DIRS_TO_SEARCH+=("./issues")
fi

if [ -d "./bridge" ]; then
	DIRS_TO_SEARCH+=("./bridge")
fi

if [ -d "./bridge-ext" ]; then
	DIRS_TO_SEARCH+=("./bridge-ext")
fi

if [ -d "./site" ]; then
	DIRS_TO_SEARCH+=("./site")
fi

if [ ${#DIRS_TO_SEARCH[@]} -eq 0 ]; then
	echo "Error: no demos to deploy."
	exit 1
fi

for portlet in $(gfind "${DIRS_TO_SEARCH[@]}" -maxdepth 2 -name *-portlet | egrep "$1"); do

	if [ -e "$portlet/pom.xml" ]; then
		(cd $portlet && deploy.sh "${@:2}" development)
	else
		echo "$portlet missing pom.xml. Ignoring."
	fi
done

if [[ tck =~ $1 ]]; then
	(cd ~/Projects/liferay.com/liferay-faces-bridge-impl/tck/bridge-tck-main-portlet && deploy.sh "${@:2}" development)
fi

if [[ test-setup-hook =~ $1 ]]; then
	(cd ~/Projects/liferay.com/liferay-faces-portal/test/test-setup-hook && deploy.sh "${@:2}" development)
fi
