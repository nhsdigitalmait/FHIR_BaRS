<?xml version="1.0"?>

<!-- Transform to create Scenario 2 Message 2 from Template -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	
	<!--- LastUpdateTime - T15:02 -->
	<xsl:template match="//fhir:Bundle/fhir:meta/fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:02.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<!--Alter the SENDER encounter resource lastUpdated-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value]/fhir:resource/fhir:Encounter/fhir:meta/fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:02.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<!--Alter the SENDER encounter resource status-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value]/fhir:resource/fhir:Encounter/fhir:status/@value">
		<xsl:attribute name="value"><xsl:value-of select="'triaged'"/></xsl:attribute>
	</xsl:template>

	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>
