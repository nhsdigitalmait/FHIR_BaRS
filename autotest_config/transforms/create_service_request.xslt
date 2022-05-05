<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:variable name="newbundleid" select="document('http://localhost:8001/getuuid?bundleid')/uuid/text()"/>

	<xsl:template match="fhir:Bundle/fhir:id/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="$newbundleid"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:include href="autotest_config/transforms/patient_not_traced.xslt"/>

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
