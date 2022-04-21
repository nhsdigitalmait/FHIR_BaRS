#!/bin/bash
#
# run tst tests
# usage $0 <tstfile>+
#
#OPTIONS=-Djavax.net.debug=all
# need more heap space
OPTIONS=-Xmx2048m

for f in $*
do
	echo "Running tst file $f"
	ts=`echo $f | sed -e "s/^.*_//" -e "s/\.tst$//"`
	$JAVA_HOME/bin/java $OPTIONS -Dtkw.internal.autotest.timestamp=$ts -jar $TKWROOT/TKW-x.jar -autotest $TKWROOT/config/FHIR_BaRS/autotest_config/tkw-x-autotest.properties $f
done
