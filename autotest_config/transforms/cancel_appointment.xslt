<?xml version="1.0"?>

<!-- sets the appointment status to cancelled and remove extra elements -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<xsl:template match="fhir:MessageHeader/fhir:reason/fhir:coding/fhir:code/@value">
		<xsl:attribute name="value">update</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:definition/@value">
		<xsl:attribute name="value">https://fhir.nhs.uk/MessageDefinition/bars-message-booking-request-cancelled</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Appointment/fhir:status/@value">
		<xsl:attribute name="value">cancelled</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:entry[fhir:resource/fhir:Slot]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Schedule]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:HealthcareService]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:PractitionerRole]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Practitioner]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Location]"/>

</xsl:stylesheet>
