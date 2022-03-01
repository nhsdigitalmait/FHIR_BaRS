#!/bin/bash
#
# take the BaRS tstp files and perform substitutions to generate tst files in the correct location
# then run the tst file
#

autotest=$TKWROOT/config/FHIR_BaRS/autotest_config
tst=$autotest/tst


if [[ $# == 2 ]]
then
	dest_service=$1
	tstfile=$2
else
	echo usage $0 '<destination asid> <tst filename>'
	exit 1
fi

# endpoint defaults
toservice=NHS0001
fromservice=NHS0001
sendtls=No
truststore=NONE
keystore=NONE

enduserorganization=org1
requestingpractitioner=prac1
requestingperson=person1
requestingsoftware=software1

# not required for EB since it relates to async but is required for TKW
from_ep=http://127.0.0.1
from_ep_port=4000

#============================================================================================================

date_format=+%Y-%m-%dT00:00:00%:z

today=`date $date_format`
today1=`date $date_format --date='+ 1 days'`
today4=`date $date_format --date='+ 4 days'`
todayl1=`date $date_format --date='- 1 days'`

# read in the endpoint config
if [[ -e $autotest/endpoint_configs/$dest_service.sh ]]
then
	# The script does not expect dos format files
	dos2unix -n $autotest/endpoint_configs/$dest_service.sh $autotest/endpoint_configs/temp.sh
	. $autotest/endpoint_configs/temp.sh
	rm $autotest/endpoint_configs/temp.sh
	#. $autotest/endpoint_configs/$dest_service.sh
else
	echo "Unrecognised endpoint $dest_service"
	if [[ "$TKW_BROWSER" != "" ]]
	then
		read -n 1 -p "Press any key to exit..."
		echo
	fi
	exit 1
fi

prefix=`basename $tstfile .tstp`
prefix=$prefix'_'`date +%Y%m%d%H%M%S`
# base 64 headers
toserviceb64=`cat $TKWROOT/config/FHIR_BaRS/autotest_config/target_identifier.json | sed -e s!__VALUE__!$toservice! -e s!__SYSTEM__!http://directoryofservices.nhs.uk! | base64 -w 0`
enduserorganizationb64=`cat $TKWROOT/config/FHIR_BaRS/autotest_config/target_identifier.json | sed -e s!__VALUE__!$enduserorganization!  -e s!__SYSTEM__!s2! | base64 -w 0`
requestingpractitionerb64=`cat $TKWROOT/config/FHIR_BaRS/autotest_config/target_identifier.json | sed -e s!__VALUE__!$requestingpractitioner!  -e s!__SYSTEM__!s3! | base64 -w 0`
requestingpersonb64=`cat $TKWROOT/config/FHIR_BaRS/autotest_config/target_identifier.json | sed -e s!__VALUE__!$requestingperson!  -e s!__SYSTEM__!s4! | base64 -w 0`
requestingsoftwareb64=`cat $TKWROOT/config/FHIR_BaRS/autotest_config/target_identifier.json | sed -e s!__VALUE__!$requestingsoftware!  -e s!__SYSTEM__!s5! | base64 -w 0`

echo Writing transformed $tstfile to $tst/$prefix'.tst'

# these need preserving they are handled by substitution tags
sed -e s!__TKWROOT__!$TKWROOT!g \
	-e s!__FROM_SERVICE__!$fromservice!g \
	-e s!__TO_SERVICE__!$toservice!g \
	-e s!__TO_SERVICE_B64__!$toserviceb64!g \
	-e s!__END_USER_ORGANIZATION_B64__!$enduserorganizationb64!g \
	-e s!__REQUESTING_PRACTITIONER_B64__!$requestingpractitionerb64!g \
	-e s!__REQUESTING_PERSON_B64__!$requestingpersonb64!g \
	-e s!__REQUESTING_SOFTWARE_B64__!$requestingsoftwareb64!g \
	-e s!__TO_ENDPOINT__!$to_ep!g \
	-e s!__FROM_ENDPOINT__!$from_ep!g \
	-e s!__FROM_ENDPOINT_PORT__!$from_ep_port!g \
	-e s!__TRUSTSTORE__!$truststore!g \
	-e s!__KEYSTORE__!$keystore!g \
	-e s!__SEND_TLS__!$sendtls!g \
	-e s!__TODAY1__!$today1!g \
	-e s!__TODAY4__!$today4!g \
	-e s!__TODAYl1__!$todayl1!g \
	< $tstfile  > $tst/$prefix'.tst'

if [[ "$TKW_BROWSER" != "" ]]
then
	read -n 1 -p "Press any key to continue..."
	echo
fi

# run the tests
$autotest/run_tst.sh $tst/$prefix'.tst'

# copy the tst file to the latest autotests folder
latest_autotest_folder=`ls -t $autotest/auto_tests | head -n 1`
cp $tst/$prefix'.tst' $autotest/auto_tests/$latest_autotest_folder/
# copy a statically named version for ease of debugging
cp $tst/$prefix'.tst' $autotest/tst/mergedfile.tst

# move the folder into a folder named for the target service id
if [[ ! -e $autotest/auto_tests/$dest_service ]]
then
	mkdir $autotest/auto_tests/$dest_service
fi

mv $autotest/auto_tests/$latest_autotest_folder $autotest/auto_tests/$dest_service/

cd $autotest/auto_tests/$dest_service/
zip -qr $latest_autotest_folder'.zip'  $latest_autotest_folder/
cd -

# if there's a browser configured display the results
if [[ "$TKW_BROWSER" != "" ]]
then
	if [[ -e $autotest/auto_tests/$dest_service/$latest_autotest_folder/test_log.html ]]
	then
		$TKW_BROWSER $autotest/auto_tests/$dest_service/$latest_autotest_folder/test_log.html
	else
		echo Test log file $autotest/auto_tests/$dest_service/$latest_autotest_folder/test_log.html not found
	fi
fi
