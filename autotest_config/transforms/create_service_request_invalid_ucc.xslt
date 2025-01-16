<?xml version="1.0"?>

<!-- modify full service request remove ucc -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>


	<!-- invalidate UCC entry -->
	<xsl:template match="//fhir:ServiceRequest/fhir:category/fhir:coding[fhir:system/@value='https://fhir.nhs.uk/CodeSystem/usecases-categories-bars']/fhir:code/@value">
		<xsl:attribute name="value"><xsl:value-of select="'xxxxxxxxxxxxxxxxxxx'"/></xsl:attribute>
	</xsl:template>	
	
	
</xsl:stylesheet>
