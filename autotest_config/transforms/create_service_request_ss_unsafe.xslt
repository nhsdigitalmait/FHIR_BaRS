<?xml version="1.0"?>

<!-- set scene safety to unsafe -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_not_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<!-- valrq scene safety unsafe -->
	<xsl:template match="fhir:Flag[fhir:category/fhir:coding/fhir:system/@value='https://fhir.nhs.uk/CodeSystem/flag-categories-bars' and fhir:category/fhir:coding/fhir:code/@value='SS']/fhir:code[fhir:coding/fhir:system/@value='https://fhir.nhs.uk/flag-codes-bars']/fhir:coding/fhir:code/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="'U'"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Flag[fhir:category/fhir:coding/fhir:system/@value='https://fhir.nhs.uk/CodeSystem/flag-categories-bars' and fhir:category/fhir:coding/fhir:code/@value='SS']/fhir:code[fhir:coding/fhir:system/@value='https://fhir.nhs.uk/flag-codes-bars']/fhir:coding/fhir:display/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="'The scene is unsafe'"/>
		</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
