<?xml version="1.0"?>

<!-- sets the message header code to update and servicerequest status to revoked and remove extra elements -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<xsl:template match="fhir:MessageHeader/fhir:reason/fhir:coding/fhir:code/@value">
		<xsl:attribute name="value">update</xsl:attribute>
	</xsl:template>
	
	<xsl:template match="fhir:MessageHeader/fhir:definition/@value">
		<xsl:attribute name="value">https://fhir.nhs.uk/MessageDefinition/bars-message-servicerequest-request-cancelled</xsl:attribute>
	</xsl:template>


	<xsl:template match="fhir:ServiceRequest/fhir:status/@value">
		<xsl:attribute name="value">revoked</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:entry[fhir:resource/fhir:Encounter]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:CarePlan]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:HealthcareService]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:PractitionerRole]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Practitioner]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:MedicationStatement]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:AllergyIntolerance]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Flag]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:QuestionnaireResponse]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Observation]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Consent]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Task]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Condition]"/>

</xsl:stylesheet>
