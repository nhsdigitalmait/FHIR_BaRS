<?xml version="1.0"?>

<!-- modify full service request remove ucc -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>


	<!-- remove UCC entries -->
	<xsl:template match="//fhir:ServiceRequest/fhir:category/fhir:coding[fhir:system/@value='https://fhir.nhs.uk/CodeSystem/usecases-categories-bars']"/>
	
</xsl:stylesheet>
