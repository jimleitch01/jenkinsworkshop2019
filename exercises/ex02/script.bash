#!/bin/bash

set -e
set -x

if [[ ${PETCLINICPORT} == "" ]]
then
	export petClinicPort=9090
fi


mvn test

mvn install

# java -Dserver.port=${PETCLINICPORT} -jar target/spring-petclinic-2.1.0.BUILD-SNAPSHOT.jar 
