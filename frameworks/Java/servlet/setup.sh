#!/bin/bash

sed -i 's|localhost|'"${DBHOST}"'|g' src/main/webapp/WEB-INF/resin-web.xml

mvn clean compile war:war
rm -rf $RESIN_HOME/webapps/*
cp target/servlet.war $RESIN_HOME/webapps/
$RESIN_HOME/bin/resinctl start