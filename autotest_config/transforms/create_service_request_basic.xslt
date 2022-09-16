<?xml version="1.0"?>

<!-- modify full service request to become basic (minimal) request -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<!-- remove full resource entries -->
	<xsl:template match="fhir:entry[fhir:resource/fhir:Location]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:MedicationStatement]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:AllergyIntolerance]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Flag]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:QuestionnaireResponse]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Observation]"/>

	<xsl:template match="fhir:locationReference"/>
	<xsl:template match="fhir:supportingInfo"/>

</xsl:stylesheet>
