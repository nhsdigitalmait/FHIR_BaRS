#!/bin/bash
# build docker image for BaRS consumer simulator
# usage build_consumer_simulator_Docker.sh [<userid>]
# if no user id is provided it defaults to 1000 and the tag is just the version number
#
TAG=0.9.3

if [[ "$1" == "" ]]
then
	USER_ID=1000
else
	USER_ID=$1
	TAG+=-$USER_ID
fi

IMAGENAME=tkw_bars_consumer_simulator
PROJECT=FHIR_BaRS
VALIDATION_CONFIG=validator_config/consumer_simulator_validator.conf

echo "Building $IMAGENAME:$TAG"
grep VALIDATION-RULESET-VERSION $VALIDATION_CONFIG
grep VALIDATION-RULESET-TIMESTAMP $VALIDATION_CONFIG
read -n 1 -p "Press any key to continue..."
echo building

echo "BaRS Consumer Simulator Version: $TAG"  > version_string.txt
# put the git commit hash and date into a text file
git show -s --format="$PROJECT %h %cI" >> version_string.txt

#Update the docker ignore sim link
ln -fs .dockerignore.consumer.simulator .dockerignore
#Build the docker image
docker build --build-arg USER_ID=$USER_ID -f Dockerfile.consumer.simulator -t nhsdigitalmait/$IMAGENAME:$TAG .
echo Docker Image tagged with $TAG
