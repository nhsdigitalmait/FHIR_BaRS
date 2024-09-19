#!/bin/bash
#
# run tst tests
# usage $0 <tstfile>+
#
# need more heap space
OPTIONS=-Xmx2048m

# if called by BaRS response importer this envt var will be set and must be passed to TKW
if [[ "$CorrelationID" != "" ]]
then
	OPTIONS+=" -Dtks.internal.autotest.correlationid=$CorrelationID"
fi

#OPTIONS+=" -Djavax.net.debug=all"

OPTIONS+=" -Djava.net.preferIPv4Stack=true -XX:+UseContainerSupport"
#OPTIONS+=" -Djavax.net.debug=all"
#OPTIONS+=" -Djavax.net.debug=ssl"
#OPTIONS+=" -Djavax.net.debug=ssl:handshake"
OPTIONS+=" -Djavax.net.ssl.trustStore=$TKWROOT/config/FHIR_BaRS/autotest_config/endpoint_configs/certs/nis.jks"
OPTIONS+=" -Djavax.net.ssl.trustStorePassword=password"

echo "TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT is $TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT"

#keytool  -keystore $JAVA_HOME/lib/security/cacerts -list -rfc -storepass changeit -alias entrustrootcertificationauthority-g2

for f in $*
do
	echo "Running tst file $f"
	# extract timetamp from filename
	ts=`echo $f | sed -e "s/^.*_//" -e "s/\.tst$//"`

	if [ -f "$TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT/fhir_terminology_server_access_token.txt" ]
	then
		$JAVA_HOME/bin/java $OPTIONS \
			-Dtkw.internal.autotest.timestamp=$ts \
			-jar $TKWROOT/TKW-x.jar \
			-autotest $TKWROOT/config/FHIR_BaRS/autotest_config/tkw-x-autotest.properties $f
	else
		$JAVA_HOME/bin/java $OPTIONS \
			-Dtkw.internal.autotest.timestamp=$ts \
			-Duk.nhs.digital.mait.tkwx.tk.internalservices.validation.hapifhir.r4.terminologyserveraccesstokenlocation=$TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT/fhir_terminology_server_access_token.txt \
			-jar $TKWROOT/TKW-x.jar \
			-autotest $TKWROOT/config/FHIR_BaRS/autotest_config/tkw-x-autotest.properties $f
	fi
done
