<?xml version="1.0"?>

<!-- generic basic validation request make patient traced and remove listed ids -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_not_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<!-- remove telecom [1] and [3] -->
	<xsl:template match="//fhir:Patient/fhir:contact[1]/fhir:telecom[1]"/>
	<xsl:template match="//fhir:Patient/fhir:contact[1]/fhir:telecom[3]"/>

	<!-- remove contact [2] -->
	<xsl:template match="//fhir:Patient/fhir:contact[2]"/>

	<!-- remove Location eastings -->
	<xsl:template match="//fhir:Location/fhir:extension[@url='https://fhir.nhs.uk/StructureDefinition/LocationExtension']/fhir:extension[@url='eastings']"/>

	<!-- remove Location northings -->
	<xsl:template match="//fhir:Location/fhir:extension[@url='https://fhir.nhs.uk/StructureDefinition/LocationExtension']/fhir:extension[@url='northings']"/>

	<!-- remove Location position -->
	<xsl:template match="//fhir:Location/fhir:position"/>

	<!-- remove all Observations -->
	<xsl:template match="//fhir:entry[fhir:resource/fhir:Observation]"/>

	<!-- remove Flag[2]-->
	<xsl:template match="//fhir:entry[fhir:resource/fhir:Flag][2]"/>

</xsl:stylesheet>
