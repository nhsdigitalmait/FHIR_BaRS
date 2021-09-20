#!/bin/bash
# build docker image for emergency booking consumer simulator
# usage build_provider_simulator_Docker.sh [<userid>]
# if no user id is provided it defaults to 1000 and the tag is just the version number
#
TAG=0.7-1004

if [[ "$1" == "" ]]
then
	USER_ID=1004
else
	USER_ID=$1
	TAG+=-$USER_ID
fi

IMAGENAME=tkw_bars_provider_simulator
PROJECT=FHIR_BaRS

echo "Building $IMAGENAME:$TAG"
read -n 1 -p "Press any key to continue..."
echo building

# the source folder must be in uninstall mode(TKW_ROOT) not inistall mode (with real paths)
cd $TKWROOT/config/$PROJECT
fixtkwroot.sh -u .
cd -

# put the git commit hash and date into a text file
echo "BaRS Provider Simulator Version: $TAG"  > version_string.txt
echo "BaRS Github repository shortcode:" `git show -s --format="$PROJECT %h %cI"` >> version_string.txt


#Update the docker ignore sim link
ln -fs .dockerignore.provider.simulator .dockerignore
#Build the docker image
docker build --build-arg USER_ID=$USER_ID -f Dockerfile.provider.simulator -t nhsdigitalmait/$IMAGENAME:$TAG -t nhsdigitalmait/$IMAGENAME:latest .
echo Docker Image tagged with $TAG
