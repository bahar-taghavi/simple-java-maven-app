#!/usr/bin/env bash

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
mvn jar:jar install:install help:evaluate -Dexpression=project.name

echo 'The following command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
NAME=`mvn -Dstyle.color=never -q -DforceStdout help:evaluate -Dexpression=project.name | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'`

echo 'The following command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
VERSION=`mvn -Dstyle.color=never -q -DforceStdout help:evaluate -Dexpression=project.version | sed $'s,\x1b\\[[0-9;]*[a-zA-Z],,g'`

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'

echo Name:
echo ${NAME}
echo Version:
echo ${VERSION}

chmod 777 ./target/${NAME}-${VERSION}.jar
java -jar ./target/${NAME}-${VERSION}.jar
