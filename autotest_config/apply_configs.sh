#!/bin/bash
#
# usage $0 '<destination endpoint service id> <tst filename>'
# usage 
# take the BaRS tstp files and perform substitutions to generate tst files in the correct location
# then run the tst file
#

autotest=$TKWROOT/config/FHIR_BaRS/autotest_config
tst=$autotest/tst


if [[ $# == 2 ]]
then
	# this refers to the name of an endpoint config file
	dest_service=$1
	tstfile=$2
else
	echo usage $0 '<destination endpoint service id> <tst filename>'
	exit 1
fi

# endpoint defaults
toservice=TKW0004
fromservice=TKW0004
sendtls=No
truststore=NONE
keystore=NONE

enduserorganization=A1001
requestingpractitioner=100334993514
requestingsoftware=SUPP-APP-1

# not required for EB since it relates to async but is required for TKW
from_ep=http://127.0.0.1
from_ep_port=4000

#============================================================================================================

date_format=+%Y-%m-%dT00:00:00%:z

today=`date $date_format`
today1=`date $date_format --date='+ 1 days'`
today4=`date $date_format --date='+ 4 days'`
todayl1=`date $date_format --date='- 1 days'`

# read in the endpoint config this is the dest service id with .sh appended
if [[ -e $autotest/endpoint_configs/$dest_service.sh ]]
then
	# The script does not expect dos format files
	temp=`mktemp`
	dos2unix -n $autotest/endpoint_configs/$dest_service.sh $temp

	# apply the settings from the endpoint config file
	# this line sets the two env vars fromservice and toservice amongst others
	# typically toservice will be the same as dest service
	. $temp
	rm $temp
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

template_root=$TKWROOT/config/FHIR_BaRS/autotest_config/json_header_templates
# base 64 headers
toserviceb64=`cat $template_root/target_identifier.json | sed -e s!__VALUE__!$toservice! -e s!__SYSTEM__!https://fhir.nhs.uk/Id/dos-service-id! | base64 -w 0`
enduserorganizationb64=`cat $template_root/enduser_organisation.json | sed -e s!__VALUE__!$enduserorganization!  -e s!__SYSTEM__!https://fhir.nhs.uk/Id/ods-organization-code! | base64 -w 0`
requestingpractitionerb64=`cat $template_root/requesting_practitioner.json | sed -e s!__VALUE__!$requestingpractitioner!  -e s!__SYSTEM__!https://fhir.nhs.uk/Id/sds-role-profile-id! | base64 -w 0`
requestingsoftwareb64=`cat $template_root/requesting_software.json | sed -e s!__VALUE__!$requestingsoftware!  -e s!__SYSTEM__!urn:oid:1.2.36.146.595.217.0.1! | base64 -w 0`

echo Writing transformed $tstfile to $tst/$prefix'.tst'

# these need preserving they are handled by substitution tags
sed -e s!__TKWROOT__!$TKWROOT!g \
	-e s!__FROM_SERVICE__!$fromservice!g \
	-e s!__TO_SERVICE__!$toservice!g \
	-e s!__TO_SERVICE_B64__!$toserviceb64!g \
	-e s!__END_USER_ORGANIZATION_B64__!$enduserorganizationb64!g \
	-e s!__REQUESTING_PRACTITIONER_B64__!$requestingpractitionerb64!g \
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

# local point specific change if we are talking to the simulator use a sentinel value otherwise use the to service

if [[ "$toservice" == "TKW0004" ]]
then
    sed -i -e s!__HCS__!2000072489!g $tst/$prefix'.tst'
	sed -i -e s!__HCS_NO_SLOTS__!2000073917!g $tst/$prefix'.tst'
	sed -i -e s!__HCS_SLOTS_ONLY__!2000081825!g $tst/$prefix'.tst'
else
	sed -i -e s!__HCS__!$toservice!g $tst/$prefix'.tst'
	sed -i -e s!__HCS_NO_SLOTS__!$toservice!g $tst/$prefix'.tst'
	sed -i -e s!__HCS_SLOTS_ONLY__!$toservice!g $tst/$prefix'.tst'
fi

echo "writing transformed requests"
# name templates for dest id for reentrancy
for f in book_appt referral_request_01 referral_request_02 referral_request_03 referral_response validation_request validation_response referral_request_01_cancel
do
	echo $f 
	sed -e s!__FROM_SERVICE__!$fromservice!g \
		-e s!__TO_SERVICE__!$toservice!g \
		-e "/<!--.*-->/d" \
		< $autotest/requests/request_templates/$f'_template.xml' > $autotest/requests/$f'_'$toservice.xml
done

if [[ "$TKW_BROWSER" != "" ]]
then
	read -n 1 -p "Press any key to continue..."
	echo
fi

# run the tests ensuring the current folder is correct for relative references in transforms
cd $TKWROOT/config/FHIR_BaRS
$autotest/run_tst.sh $tst/$prefix'.tst'
cd -

# copy the tst file to the target autotests folder
target_autotest_folder=`echo $prefix | sed -e "s/^mergedfile/BaRS/" -e "s/\.tst$//"`
cp $tst/$prefix'.tst' $autotest/auto_tests/$target_autotest_folder/
# copy a statically named version for ease of debugging
cp $tst/$prefix'.tst' $autotest/tst/mergedfile.tst

if [[ ! -e $autotest/auto_tests/$dest_service ]]
then
	mkdir $autotest/auto_tests/$dest_service
fi

# move the folder into a folder named for the target service id
mv $autotest/auto_tests/$target_autotest_folder $autotest/auto_tests/$dest_service/

# create a zip file in the target service id sub folder
cd $autotest/auto_tests/$dest_service/
zip -qr $target_autotest_folder'.zip'  $target_autotest_folder/
cd -

# if there's a browser configured display the results
if [[ "$TKW_BROWSER" != "" ]]
then
	if [[ -e $autotest/auto_tests/$dest_service/$target_autotest_folder/test_log.html ]]
	then
		$TKW_BROWSER $autotest/auto_tests/$dest_service/$target_autotest_folder/test_log.html
	else
		echo Test log file $autotest/auto_tests/$dest_service/$target_autotest_folder/test_log.html not found
	fi
fi
