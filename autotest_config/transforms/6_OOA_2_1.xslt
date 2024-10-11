<?xml version="1.0"?>

<!-- Transform to create Scenario 2 Message 1 from Template -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <!--Remove all ids resourceids-->
	<xsl:template match="//fhir:entry/fhir:resource/fhir:*/fhir:id"/>
	<!--Remove the Encounter that is not the Sender Encounter i.e. the one NOT referenced by the ServiceRequest-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value!=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value][fhir:resource/fhir:Encounter]"/>
	<!--Set all lastUpdated times to '2023-12-26T15:00:00.8185338+00:00'-->
	<xsl:template match="//fhir:lastUpdated/@value">
		<xsl:attribute name="value"><xsl:value-of select="'2023-12-26T15:00:00.8185338+00:00'"/></xsl:attribute>
	</xsl:template>
	<!-- Remove CarePlan activity -->
	<xsl:template match="//fhir:entry/fhir:resource/fhir:CarePlan/fhir:activity"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:identifier"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:communication"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:communication"/>
	<xsl:template match="//fhir:entry/fhir:resource/fhir:Patient/fhir:generalPractitioner"/>
	<!--Remove the Organisation resource the patient/generalPractitioner references-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:Patient/fhir:generalPractitioner/fhir:reference/@value]"/>
	<!--Remove the PractitionerRole resource that references this Organisation-->
	<xsl:template match="//fhir:entry[fhir:resource/fhir:PractitionerRole[fhir:organization/fhir:reference/@value=//fhir:Patient/fhir:generalPractitioner/fhir:reference/@value]]"/>
	<!--Remove the Practitioner resource that is referenced by the PractitonerRole that is referenced by the Patient-->
	<xsl:template match="//fhir:entry[fhir:fullUrl/@value=//fhir:entry[fhir:resource/fhir:PractitionerRole[fhir:organization/fhir:reference/@value=//fhir:Patient/fhir:generalPractitioner/fhir:reference/@value]]/fhir:resource/fhir:PractitionerRole/fhir:practitioner/fhir:reference/@value]"/>
	<!-- Generate new BundleID and run identity transform -->
	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>
</xsl:stylesheet>
