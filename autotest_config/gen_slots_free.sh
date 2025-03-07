#!/bin/bash
# generate cfg files and names tdv files one per slot

TARGET=extractor_configs
NOW=`date`

for f in {1..3}
do
	echo $f
	if [[ -e $TARGET/slots_free$f.cfg ]]
	then
		chmod +w $TARGET/slots_free$f.cfg
	fi
	# configure each extractor config file file with correct indices
	sed -e s/__SLOT_NO__/s$f/ \
		-e s/__POSITION__/$(($f))/ \
		-e "s/__NOW__/$NOW/" \
		< slots_free_template.cfg > $TARGET/slots_free$f.cfg

	#  append 7 field titles and underscores for field data item to the associated tdv
	#sed -i -e "/__ID__/s/$/	__APPT_SLOT_ID__	__APPT_IDENTIFIER_SYSTEM__	__APPT_IDENTIFIER_VALUE__	__APPT_SCHEDULE__	__APPT_STATUS__	__APPT_START_DATE__	__APPT_END_DATE__/" $TARGET/slot_$f.tdv
	#sed -i -e "/^s/s/$/	_	_	_	_	_	_	_/" $TARGET/slot_$f.tdv

	#  append 1 field title and underscore for field data item to the associated tdv
	#sed -i -e "/__ID__/s/$/	__APPT_CREATED__/" $TARGET/slot_$f.tdv
	#sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv

	#  append 1 field title and underscore for field data item to the associated tdv
	#sed -i -e "/__ID__/s/$/	__CORRELATION_ID__/" $TARGET/slot_$f.tdv
	#sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv

	#  append 1 field title and underscore for field data item to the associated tdv
	#sed -i -e "/__ID__/s/$/	__REQUEST_ID__/" $TARGET/slot_$f.tdv
	#sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv

	#  append 1 field title and underscore for field data item to the associated tdv
#	sed -i -e "/__ID__/s/$/	__PATIENT_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv

	#  append 1 field title and underscore for field data item to the associated tdv
#	sed -i -e "/__ID__/s/$/	__ORG1_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv
#	sed -i -e "/__ID__/s/$/	__ORG2_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv
#	sed -i -e "/__ID__/s/$/	__ORG3_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv

	#  append 1 field title and underscore for field data item to the associated tdv
#	sed -i -e "/__ID__/s/$/	__HEALTHCARE_SERVICE_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv
#	sed -i -e "/__ID__/s/$/	__PRACTITIONER_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv
#	sed -i -e "/__ID__/s/$/	__PRACTITIONER_ROLE_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv
#	sed -i -e "/__ID__/s/$/	__LOCATION_ID__/" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv

#	sed -i -e "/__ID__/s/$/	__BUNDLE_ID__" $TARGET/slot_$f.tdv
#	sed -i -e "/^s/s/$/	_/" $TARGET/slot_$f.tdv

	chmod -w $TARGET/slots_free$f.cfg
done
