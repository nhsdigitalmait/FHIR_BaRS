#!/bin/bash
#
#  Script for TKWATM test script generation and execution for Booking and referral system
#
#  usage ./run_autotest.sh --version | ( -s  <endpoint id> [<testname> *]) |  ( [endpoint id> <A|S|B|C|>*] )
#
#  A => Capability
#  S => Search for free slots
#  B => Book appointment
#  C => Cancel appointment
#  No Parameter => All
#

usage() 
{
	echo usage: $0 '--version |  ( -s  <endpoint id> [<testname> *]) |  ( [<endpoint id> <A|S|B|C|>*] )'
	exit 1
}

VERSION_FILE=$TKWROOT/config/FHIR_BaRS/version_string.txt
if [[ "$1" == "--version" ]]
then
	if [[ -e $VERSION_FILE ]]
	then
		cat $VERSION_FILE
	fi
	java -jar $TKWROOT/TKW-x.jar -version | grep -v "starting on"
	exit 
fi

TSTP_FILES=BaRS_Common.tstp

if [[ "$1" == '-s' ]]
then
	OPTION=$1
	shift
fi

# local
ENDPOINT_ID=NHS0001   # acts as a label for an endpoint config in endpoint_configs
if [[ $# != 0 ]]
then
	ENDPOINT_ID=$1
	shift
fi

if [[ "$OPTION" == '-s' || $# == 0 ]]
then
	TSTP_FILES+=" BaRS_Capability.tstp \
		BaRS_SearchForFreeSlots.tstp \
		BaRS_BookAppointment.tstp \
		BaRS_CancelAppointment.tstp \
		BaRS_ReferralRequest.tstp \
		BaRS_ValidationRequest.tstp \
		BaRS_ReferralResponse.tstp \
		BaRS_ValidationResponse.tstp"

else
	for t in $*
	do
		case "$t" in
			A|a)
			TSTP_FILES+=' BaRS_Capability.tstp'
			;;

			S|s)
			TSTP_FILES+=' BaRS_SearchForFreeSlots.tstp'
			;;

			B|b)
			TSTP_FILES+=' BaRS_BookAppointment.tstp'
			;;

			C|c)
			TSTP_FILES+=' BaRS_CancelAppointment.tstp'
			;;

			# new BARS messages
			REFRQ|refrq)
			TSTP_FILES+=' BaRS_ReferralRequest.tstp'
			;;

			VALRQ|valrq)
			TSTP_FILES+=' BaRS_ValidationRequest.tstp'
			;;

			REFRP|refrp)
			TSTP_FILES+=' BaRS_ReferralResponse.tstp'
			;;

			VALRP|valrp)
			TSTP_FILES+=' BaRS_ValidationResponse.tstp'
			;;

		#	SIM|sim)
		#	TSTP_FILES+=' BaRS_SimulatorTests.tstp'
		#	;;

			*)
			echo "unrecognised group parameter $t"
			exit 1
			;;
		esac
	done
fi

SCRIPT_NAME=BaRS

ROOT=$TKWROOT/config/FHIR_BaRS/autotest_config
# 17 digit timestamp
MERGED_TSTP_FILE=$ROOT/mergedfile_"$ENDPOINT_ID"_`date +%Y%m%d%H%M%S%N | cut -b -17`.tstp
TSTP_FOLDER=$ROOT/tstp/

# merge the tstp files into a single file
#   <input folder> <output tst file> <script file name> <input tstp file>+
java -cp $TKWROOT/TKWAutotestManager.jar TKWAutotestManager.TestFileMerger $TSTP_FOLDER $MERGED_TSTP_FILE $SCRIPT_NAME $TSTP_FILES

# change title of merged tstp script
sed -i $MERGED_TSTP_FILE -r -e 's/SCRIPT .+/SCRIPT '$SCRIPT_NAME'_'$ENDPOINT_ID'/'


if [[ "$OPTION" == '-s' ]]
then
	# create an exclamation mark separated string containing all the tests
	valid_tests=`sed -r -e '1,/BEGIN SCHEDULES/d' -e '/END SCHEDULES/,$d' -e 's/\s+.*$/!/' <  $MERGED_TSTP_FILE`
	valid_tests=`echo $valid_tests | sed -e 's/\s*//g'`
	#
	#  remove unselected tests
	#
	for test in $*
	do
		if [[  $valid_tests =~ ((^|!)$test($|!)) ]]
		then
			TESTS+='|'$test
		else
			echo "Unrecognised test $test"
			exit
		fi
	done
	# post edit to filter out any tests not specified
	sed -i -r -e '/BEGIN SCHEDULES/,/END SCHEDULES/s/^/#/' -e "s/^#(BEGIN|END$TESTS) /\1 /" $MERGED_TSTP_FILE
fi


# transform the merged file into a tst file to resolve substitution tags and then runs the script
$ROOT/apply_configs.sh $ENDPOINT_ID $MERGED_TSTP_FILE

rm -f $MERGED_TSTP_FILE
