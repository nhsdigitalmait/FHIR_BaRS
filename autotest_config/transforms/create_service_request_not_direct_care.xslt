<?xml version="1.0"?>

<!-- generic new service request make patient traced and remove listed ids amend the consent coding to not direct care -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<xsl:template match="fhir:Consent/fhir:category/fhir:coding[fhir:system/@value='https://fhir.nhs.uk/CodeSystem/consent-categories-bars']/fhir:code/@value">
		<xsl:attribute name="value">NDRC</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Consent/fhir:category/fhir:coding[fhir:system/@value='https://fhir.nhs.uk/CodeSystem/consent-categories-bars']/fhir:display/@value">
		<xsl:attribute name="value">Not Direct Care</xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
