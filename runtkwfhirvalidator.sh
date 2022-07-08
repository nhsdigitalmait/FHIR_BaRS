#Report the version numbers

PROJECT=FHIR_BaRS

if [[ -e /home/service/TKW/config/$PROJECT/version_string.txt ]]
then
	cat /home/service/TKW/config/$PROJECT/version_string.txt
fi
java -jar /home/service/TKW/TKW-x.jar -version | grep -v "starting on"

if [ "$1" == '--version' ]
then
	exit 0
fi

echo "Running as UID $UID"
echo "trustStore = " $trustStore
echo "trustStorePassword = " $trustStorePassword
echo "keyStore = " $keyStore
echo "keyStorePassword = " $keyStorePassword
echo "TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT = " $TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT
echo "INHIBIT_RESPONSE_IMPORTER = " $INHIBIT_RESPONSE_IMPORTER

cd /home/service

if [ -f "$TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT/fhir_terminology_server_access_token.txt" ]
then
	javastring="-Djava.net.preferIPv4Stack=true -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/$PROJECT/tkw-x_provider_simulator.properties"
else
	javastring="-Djava.net.preferIPv4Stack=true -Duk.nhs.digital.mait.tkwx.tk.internalservices.validation.hapifhir.r4.terminologyserveraccesstokenlocation=$TERMINOLOGY_SERVER_ACCESS_TOKEN_ROOT/fhir_terminology_server_access_token.txt -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/$PROJECT/tkw-x_provider_simulator.properties"
fi

if [ "$INHIBIT_RESPONSE_IMPORTER" != 'true' ]
then
	java -cp $TKWROOT/TKW-x.jar uk.nhs.digital.mait.tkwx.tk.boot.BARSResponseImporter $PROJECT &
	echo "Starting BaRS Response Importer"
fi

# decide whether its TLSMA or not
if [ "$trustStore" == 'default' ]
then
	#ClearText
	java -version
	echo java $javastring
	java $javastring
else
	#TLSMA
	java -version
	java -Djavax.net.ssl.trustStore=$trustStore -Djavax.net.ssl.trustStorePassword=$trustStorePassword -Djavax.net.ssl.keyStore=$keyStore -Djavax.net.ssl.keyStorePassword=$keyStorePassword $javastring
fi

