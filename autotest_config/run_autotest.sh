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
#  VALRQ => Validation Request
#  VALRP => Validation Response
#  999_REFRQ => 999 to CAS Referral Request
#  111_REFRQ => 111 to ED Referral Request
#  GP_REFRQ => GP to Pharm Referral Request
#  REFRP => Referral Response
#  No Parameter => All
#

usage() 
{
	>&2 echo usage: $0 '--version |  ( -s  <endpoint name> [<testname> *]) |  ( [<endpoint name> <A|S|B|C|>*] )'
	exit 1
}

tidy()
{
	if [[ -e "$MERGED_TSTP_FILE" ]]
	then
		rm -f $MERGED_TSTP_FILE
		exit 1
	fi
}

trap 'tidy' SIGINT

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

# arg list individual test names not test groups
if [[ "$1" == '-s' ]]
then
	OPTION=$1
	shift
fi

# local
ENDPOINT_NAME=TKW0004   # acts as a label (endpoint name) for an endpoint config in endpoint_configs
if [[ $# != 0 ]]
then
	ENDPOINT_NAME=$1
	shift
fi

if [[ "$OPTION" == '-s' || $# == 0 ]]
then
	TSTP_FILES+=" BaRS_Capability.tstp \
		BaRS_SearchForFreeSlots.tstp \
		BaRS_BookAppointment.tstp \
		BaRS_CancelAppointment.tstp \
		BaRS_999_ReferralRequest.tstp \
		BaRS_111_ReferralRequest.tstp \
		BaRS_GP_ReferralRequest.tstp \
		BaRS_CADtoCAD_ReferralRequest.tstp \
		BaRS_ValidationRequest.tstp \
		BaRS_ReferralResponse.tstp \
		BaRS_ValidationResponse.tstp \
		BaRS_Simulator.tstp \
		BaRS_Extractor.tstp"
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
			999_REFRQ|999_refrq)
			TSTP_FILES+=' BaRS_999_ReferralRequest.tstp'
			;;

			111_REFRQ|111_refrq)
			TSTP_FILES+=' BaRS_111_ReferralRequest.tstp'
			;;

			GP_REFRQ|gp_refrq)
			TSTP_FILES+=' BaRS_GP_ReferralRequest.tstp'
			;;

			CADtoCAD|cadtocad)
			TSTP_FILES+=' BaRS_CADtoCAD_ReferralRequest.tstp'
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

		#   Simulator Tests only, not of use against real systems
			SIM|sim)
			TSTP_FILES+=' BaRS_Simulator.tstp'
			;;

			*)
			>&2 echo "unrecognised group parameter $t"
			exit 1
			;;
		esac
	done
fi

SCRIPT_NAME=BaRS

ROOT=$TKWROOT/config/FHIR_BaRS/autotest_config
# 17 digit timestamp
MERGED_TSTP_FILE=$ROOT/mergedfile_"$ENDPOINT_NAME"_`date +%Y%m%d%H%M%S%N | cut -b -17`.tstp
TSTP_FOLDER=$ROOT/tstp/

# merge the tstp files into a single file
#   <input folder> <output tst file> <script file name> <input tstp file>+
java -cp $TKWROOT/TKWAutotestManager.jar TKWAutotestManager.TestFileMerger $TSTP_FOLDER $MERGED_TSTP_FILE $SCRIPT_NAME $TSTP_FILES

# change title of merged tstp script
sed -i $MERGED_TSTP_FILE -r -e 's/SCRIPT .+/SCRIPT '$SCRIPT_NAME'_'$ENDPOINT_NAME'/'


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
			>&2 echo "Unrecognised test $test"
			exit 1
		fi
	done
	# post edit to filter out any tests not specified
	sed -i -r -e '/BEGIN SCHEDULES/,/END SCHEDULES/s/^/#/' -e "s/^#(BEGIN|END$TESTS) /\1 /" $MERGED_TSTP_FILE
fi


# transform the merged file into a tst file to resolve substitution tags and then runs the script
$ROOT/apply_configs.sh $ENDPOINT_NAME $MERGED_TSTP_FILE

rm -f $MERGED_TSTP_FILE
