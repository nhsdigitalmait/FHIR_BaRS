<?xml version="1.0"?>

<!-- sets the appointment status to cancelled -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:variable name="newbundleid" select="document('http://localhost:8001/getuuid?bundleid')/uuid/text()"/>

	<xsl:template match="fhir:Bundle/fhir:id/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="$newbundleid"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:reason/fhir:coding/fhir:code/@value">
		<xsl:attribute name="value">update</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Appointment/fhir:status/@value">
		<xsl:attribute name="value">cancelled</xsl:attribute>
	</xsl:template>

	<xsl:include href="autotest_config/transforms/patient_not_traced.xslt"/>

	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
