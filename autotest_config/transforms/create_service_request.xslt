<?xml version="1.0"?>

<!-- sets the message header reason code to update and service request status to active -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<!-- remove the id element from the ServiceRequest -->
	<xsl:template match="fhir:ServiceRequest/fhir:id"/>
	<xsl:template match="fhir:HealthcareService/fhir:id"/>
	<xsl:template match="fhir:Encounter/fhir:id"/>
	<xsl:template match="fhir:CarePlan/fhir:id"/>
	<xsl:template match="fhir:Patient/fhir:id"/>
	<xsl:template match="fhir:Organization/fhir:id"/>
	<xsl:template match="fhir:Location/fhir:id"/>
	<xsl:template match="fhir:Practitioner/fhir:id"/>
	<xsl:template match="fhir:PractitionerRole/fhir:id"/>
	<xsl:template match="fhir:Observation/fhir:id"/>
	<xsl:template match="fhir:Flag/fhir:id"/>
	<xsl:template match="fhir:Consent/fhir:id"/>

	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>