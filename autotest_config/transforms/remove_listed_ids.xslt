<?xml version="1.0"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<!-- remove the id element from the ServiceRequest and others -->

	<xsl:template match="fhir:ServiceRequest/fhir:id"/>
	<xsl:template match="fhir:Encounter/fhir:id"/>
	<xsl:template match="fhir:CarePlan/fhir:id"/>
	<xsl:template match="fhir:Patient/fhir:id"/>
	<xsl:template match="fhir:Condition/fhir:id"/>
	<xsl:template match="fhir:Task/fhir:id"/>
	<xsl:template match="fhir:Organization/fhir:id"/>
	<xsl:template match="fhir:Practitioner/fhir:id"/>
	<xsl:template match="fhir:PractitionerRole/fhir:id"/>
	<xsl:template match="fhir:Flag/fhir:id"/>
	<xsl:template match="fhir:MedicationStatement/fhir:id"/>
	<xsl:template match="fhir:Observation/fhir:id"/>
	<xsl:template match="fhir:Consent/fhir:id"/>
	<xsl:template match="fhir:HealthcareService/fhir:id"/>
	<xsl:template match="fhir:Location/fhir:id"/>
	<xsl:template match="fhir:AllergyIntolerance/fhir:id"/>
	<xsl:template match="fhir:Questionnaire/fhir:id"/>
	<xsl:template match="fhir:QuestionnaireResponse/fhir:id"/>
	<xsl:template match="fhir:Procedure/fhir:id"/>
	<xsl:template match="fhir:Communication/fhir:id"/>
</xsl:stylesheet>
