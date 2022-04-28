<?xml version="1.0"?>

<!-- sets the message header reason code to update and service request status to active -->

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

	<xsl:template match="fhir:ServiceRequest/fhir:status/@value">
		<xsl:attribute name="value">active</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-BirthSex']/fhir:valueCode/@value">
		<xsl:attribute name="value">F</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:name/fhir:text/@value">
		<xsl:attribute name="value">Mrs Julie Jones</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:name/fhir:given/@value">
		<xsl:attribute name="value">Julie</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:name/fhir:Prefix/@value">
		<xsl:attribute name="value">Mrs</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:gender/@value">
		<xsl:attribute name="value">female</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:birthDate/@value">
		<xsl:attribute name="value">1959-05-04</xsl:attribute>
	</xsl:template>

		<!-- mark the nnn as not traced so we don't have to align with PDS yet -->
	<xsl:template match="fhir:Patient/fhir:identifier/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-NHSNumberVerificationStatus']/fhir:valueCodeableConcept/fhir:coding[fhir:system/@value='https://fhir.hl7.org.uk/CodeSystem/UKCore-NHSNumberVerificationStatus']/fhir:code/@value">
		<xsl:attribute name="value">number-present-but-not-traced</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:identifier/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-NHSNumberVerificationStatus']/fhir:valueCodeableConcept/fhir:coding[fhir:system/@value='https://fhir.hl7.org.uk/CodeSystem/UKCore-NHSNumberVerificationStatus']/fhir:display/@value">
		<xsl:attribute name="value">Number present but not traced</xsl:attribute>
	</xsl:template>

	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
