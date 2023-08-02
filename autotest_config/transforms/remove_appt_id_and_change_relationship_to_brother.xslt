<?xml version="1.0"?>

<!-- remove appt id for initial booking change rank1 contact relationship to brother from oneself -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<!-- remove the id -->
	<xsl:template match="fhir:Appointment/fhir:id"/>
	<xsl:template match="fhir:Patient/fhir:id"/>

	<!-- don't send any empty id fields -->
	<xsl:template match="//fhir:id[@value='' and not(../../(fhir:Appointment|fhir:Patient))]"/>

	<!--
	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>
	-->

	<xsl:template match="fhir:Appointment/fhir:created/@value">
		<xsl:attribute name="value"><xsl:value-of select="format-dateTime(current-dateTime(),'[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z]')"/></xsl:attribute>
	</xsl:template>

	<!-- change the rank 1 relationship to BRO -->
	<xsl:template match="fhir:Patient/fhir:contact[fhir:extension/@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank'][fhir:extension/fhir:valuePositiveInt/@value='1']/fhir:relationship/fhir:coding[fhir:system/@value='http://terminology.hl7.org/CodeSystem/v3-RoleCode']/fhir:code/@value">
		<xsl:attribute name="value"><xsl:value-of select="'BRO'"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="fhir:Patient/fhir:contact[fhir:extension/@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank'][fhir:extension/fhir:valuePositiveInt/@value='1']/fhir:relationship/fhir:coding[fhir:system/@value='http://terminology.hl7.org/CodeSystem/v3-RoleCode']/fhir:display/@value">
		<xsl:attribute name="value"><xsl:value-of select="'brother'"/></xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
