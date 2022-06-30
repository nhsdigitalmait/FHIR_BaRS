<?xml version="1.0"?>

<!-- remove any rank 1 contacts completely -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<!-- remove the rank 1 contact altogether -->
	<xsl:template match="fhir:Patient/fhir:contact[fhir:extension/@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank'][fhir:extension/fhir:valuePositiveInt/@value='1']"/>

</xsl:stylesheet>
