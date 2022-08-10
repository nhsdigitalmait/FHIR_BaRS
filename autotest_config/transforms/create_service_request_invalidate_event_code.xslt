<?xml version="1.0"?>

<!-- generic new service request make patient traced and remove listed ids -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:template match="fhir:MessageHeader/fhir:eventCoding[fhir:system/@value='https://fhir.nhs.uk/CodeSystem/message-events-bars']/fhir:code/@value">
		<xsl:attribute name="value"><xsl:value-of select="'servicerequest-destruction'"/></xsl:attribute>
	</xsl:template>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

</xsl:stylesheet>
