#!/bin/sh

BUNDLE_TOMCAT=$(find "$HOME/Portals/liferay.com/build" -name "tomcat-*" | head -1)
SOURCE="$HOME/Projects/liferay.com/portal/master"
java -cp "$BUNDLE_TOMCAT/webapps/ROOT/WEB-INF/lib/*:$BUNDLE_TOMCAT/lib/ext/*:$SOURCE/portal-service/*" com.liferay.portal.tools.sourceformatter.SourceFormatter
