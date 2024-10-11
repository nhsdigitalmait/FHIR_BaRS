<?xml version="1.0"?>

<!-- Transform to create Scenario 1 Message 2 from Template -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<!--- LastUpdateTime - T15:00:04 -->
	<xsl:template match="//fhir:Bundle/fhir:meta/fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:02.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<!--Alter the SENDER encounter resource lastUpdated-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value]/fhir:resource/fhir:Encounter/fhir:meta/fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:02.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<!--Alter the SENDER encounter resource status-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value]/fhir:resource/fhir:Encounter/fhir:status/@value">
		<xsl:attribute name="value"><xsl:value-of select="'in-progress'"/></xsl:attribute>
	</xsl:template>
	<!--Alter the SENDER encounter resource statusHistory-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value]/fhir:resource/fhir:Encounter/fhir:statusHistory[fhir:status/@value='in-progress']/fhir:period/fhir:start/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:00+00:00'"/></xsl:attribute>
	</xsl:template>
	<!-- CarePlan lastUpdated-->
	<xsl:template match="//fhir:entry/fhir:resource/fhir:CarePlan/fhir:meta/fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:00.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<!-- Remove CarePlan activity -->
	<xsl:template match="//fhir:entry/fhir:resource/fhir:CarePlan/fhir:activity">
	</xsl:template>
	<!-- Patient lastUpdated-->
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:meta/fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:02.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-EthnicCategory']"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:extension[@url='http://hl7.org/fhir/StructureDefinition/patient-religion']"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:identifier"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:address"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:contact[fhir:extension/fhir:valuePositiveInt/@value=2]"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:communication"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:generalPractitioner"/>
	<!--Remove the Organisation resource the patient/generalPractitioner references-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:Patient/fhir:generalPractitioner/fhir:reference/@value]"/>
	<!--Remove the PractitionerRole resource that references this Organisation-->
	<xsl:template match="//fhir:entry[fhir:resource/fhir:PractitionerRole[fhir:organization/fhir:reference/@value=//fhir:Patient/fhir:generalPractitioner/fhir:reference/@value]]"/>
	<!--Remove the Practitioner resource that is referenced by the PractitonerRole that is referenced by the Patient-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:entry[fhir:resource/fhir:PractitionerRole[fhir:organization/fhir:reference/@value=//fhir:Patient/fhir:generalPractitioner/fhir:reference/@value]]/fhir:resource/fhir:PractitionerRole/fhir:practitioner/fhir:reference/@value]"/>
	<!-- Remove Rendezvous Location-->
	<xsl:template match="//fhir:entry[fhir:resource/fhir:Location[fhir:type/fhir:coding[fhir:system/@value='https://fhir.nhs.uk/CodeSystem/location-types-bars']/fhir:code[@value='RLOC']]]">
	</xsl:template>
	<!--Scene Safety Flag-->
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Flag/fhir:meta/fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:02.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Flag/fhir:code/fhir:coding/fhir:code/@value">
		<xsl:attribute name="value"><xsl:value-of select="'UNK'"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Flag/fhir:code/fhir:coding/fhir:display/@value">
		<xsl:attribute name="value"><xsl:value-of select="'Unknown'"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Flag/fhir:code/fhir:coding/fhir:display/@value">
		<xsl:attribute name="value"><xsl:value-of select="'Unknown'"/></xsl:attribute>
	</xsl:template>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Flag/fhir:code/fhir:text"/>
	
	
	
	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
</xsl:stylesheet>
