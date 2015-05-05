#!/opt/local/bin/bash

LIFERAY_FACES_MASTER="$HOME/Projects/liferay.com/faces/master"
LIFERAY_VERSION=$(xml-strings ~/Projects/liferay.com/faces/master/pom.xml :/project/properties/liferay.version)
JSF_VERSION=$(xml-strings ~/Projects/liferay.com/faces/master/pom.xml :/project/properties/faces.spec.version)

for portlet in $(gfind "$LIFERAY_FACES_MASTER/demos" "$LIFERAY_FACES_MASTER/issues" -name *-portlet | egrep $1); do

	cd $portlet && deploy.sh "${@:2}"
	mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
	echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
done

if [[ test-setup-hook =~ "$1" ]]; then

	cd $LIFERAY_FACES_MASTER/test/test-setup-hook && deploy.sh "${@:2}"
	mv ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/
	echo "Moving ~/Portals/liferay.com/liferay-portal-$LIFERAY_VERSION-jsf-$JSF_VERSION/deploy/${portlet##*/}* to ~/Portals/liferay.com/${LIFERAY_VERSION:0:3}/deploy/"
fi
