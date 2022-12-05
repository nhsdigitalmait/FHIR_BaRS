<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" exclude-result-prefixes="fhir" version="1.0">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<!-- mark the nnn as traced and aligned with yet -->
	<!-- gpc 1.2 patient 2 -->
	<xsl:template match="fhir:Patient/fhir:identifier/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-NHSNumberVerificationStatus']/fhir:valueCodeableConcept/fhir:coding[fhir:system/@value='https://fhir.hl7.org.uk/CodeSystem/UKCore-NHSNumberVerificationStatus']/fhir:code/@value">
		<xsl:attribute name="value">number-present-and-verified</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:identifier/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-NHSNumberVerificationStatus']/fhir:valueCodeableConcept/fhir:coding[fhir:system/@value='https://fhir.hl7.org.uk/CodeSystem/UKCore-NHSNumberVerificationStatus']/fhir:display/@value">
		<xsl:attribute name="value">Number present and verified</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:identifier/fhir:value/@value">
		<!-- default -->
		<xsl:attribute name="value">9658218873</xsl:attribute>

		<!-- interim -->
		<!--
		<xsl:attribute name="value">9706161317</xsl:attribute>
		-->

		<!-- full -->
		<!--
		<xsl:attribute name="value">9091510129</xsl:attribute>
		-->
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:name">
		<name xmlns="http://hl7.org/fhir">
			<use value="official" />
			<text value="Mr Mike Meakin" />
			<family value="Meakin" />
			<given value="Mike" />
			<prefix value="Mr" />
		</name>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:gender/@value">
		<xsl:attribute name="value">male</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:birthDate/@value">
		<xsl:attribute name="value">1927-06-19</xsl:attribute>
	</xsl:template>


	<xsl:template match="fhir:Patient/fhir:address">
		<address xmlns="http://hl7.org/fhir">
			<use value="home" />
			<text value="1 Knights Court, Humberside DN16 3PL" />
			<line value="1 Knights Court" />
			<city value="Humberside" />
			<postalCode value="DN16 3PL" />
		</address>
	</xsl:template>

	<!-- telecom -->
	<xsl:template match="fhir:Patient/fhir:contact/fhir:telecom[fhir:system/@value='email']/fhir:value/@value">
		<xsl:attribute name="value">mmeakin@hotmail.co.uk</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Patient/fhir:contact/fhir:telecom[fhir:rank/@value='2']"/>

	<xsl:template match="fhir:Patient/fhir:contact/fhir:telecom[fhir:rank/@value='1' and fhir:system/@value='phone']">
		<telecom xmlns="http://hl7.org/fhir">
			<system value="phone" />
			<value value="01454587554" />
			<use value="home" />
			<rank value="1" />
		</telecom>
	</xsl:template>

</xsl:stylesheet>
