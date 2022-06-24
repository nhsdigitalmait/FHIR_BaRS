<?xml version="1.0"?>

<!-- set scene safety to unknown -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:variable name="newbundleid" select="document('http://localhost:8001/getuuid?bundleid')/uuid/text()"/>

	<xsl:template match="fhir:Bundle/fhir:id/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="$newbundleid"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:include href="autotest_config/transforms/patient_not_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<!-- valrq scene safety unknown -->
	<xsl:template match="fhir:Flag[fhir:category/fhir:coding/fhir:system/@value='https://fhir.nhs.uk/CodeSystem/flag-categories-bars' and fhir:category/fhir:coding/fhir:code/@value='SS']/fhir:code[fhir:coding/fhir:system/@value='https://fhir.nhs.uk/flag-codes-bars']/fhir:coding/fhir:code/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="'UNK'"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Flag[fhir:category/fhir:coding/fhir:system/@value='https://fhir.nhs.uk/CodeSystem/flag-categories-bars' and fhir:category/fhir:coding/fhir:code/@value='SS']/fhir:code[fhir:coding/fhir:system/@value='https://fhir.nhs.uk/flag-codes-bars']/fhir:coding/fhir:display/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="'Unknown'"/>
		</xsl:attribute>
	</xsl:template>

	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
