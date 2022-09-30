#!/bin/bash
# build docker image for BaRS provider simulator
# usage build_provider_simulator_Docker.sh [<userid>]
# if no user id is provided it defaults to 1000 and the tag is just the version number
#
TAG=0.4.1

if [[ "$1" == "" ]]
then
	USER_ID=1000
else
	USER_ID=$1
	TAG+=-$USER_ID
fi

IMAGENAME=tkw_bars_provider_simulator
PROJECT=FHIR_BaRS

echo "Building $IMAGENAME:$TAG"
grep 'VALIDATION-RULESET-VERSION' validator_config/provider_simulator_validator.conf
grep 'VALIDATION-RULESET-TIMESTAMP' validator_config/provider_simulator_validator.conf
read -n 1 -p "Check the versions agree, then Press any key to continue..."
echo building

# put the git commit hash and date into a text file
echo "BaRS Provider Simulator Version: $TAG"  > version_string.txt
echo "BaRS Github repository shortcode:" `git show -s --format="$PROJECT %h %cI"` >> version_string.txt


#Update the docker ignore sim link
ln -fs .dockerignore.provider.simulator .dockerignore
#Build the docker image
docker build --build-arg USER_ID=$USER_ID -f Dockerfile.provider.simulator -t nhsdigitalmait/$IMAGENAME:$TAG -t nhsdigitalmait/$IMAGENAME:latest .
echo Docker Image tagged with $TAG
