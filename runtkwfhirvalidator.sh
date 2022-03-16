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

cd /home/service

java -cp $TKWROOT/TKW-x.jar uk.nhs.digital.mait.tkwx.tk.boot.BARSResponseImporter $PROJECT &

# decide whether its TLSMA or not
if [ "$trustStore" == 'default' ]
then
	#ClearText
	java -version
	java -XX:+UseContainerSupport -XX:MaxRAMPercentage=80.0 -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/$PROJECT/tkw-x_provider_simulator.properties
else
	#TLSMA
	java -Djavax.net.ssl.trustStore=$trustStore -Djavax.net.ssl.trustStorePassword=$trustStorePassword -Djavax.net.ssl.keyStore=$keyStore -Djavax.net.ssl.keyStorePassword=$keyStorePassword -jar /home/service/TKW/TKW-x.jar -httpinterceptor /home/service/TKW/config/$PROJECT/tkw-x_provider_simulator.properties
fi

