<?xml version="1.0"?>

<!-- remove appt id for initial booking and transform for basic booking request -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<xsl:template match="fhir:Appointment/fhir:id"/>
	<xsl:template match="fhir:Patient/fhir:id"/>

	<!-- don't send any empty id fields -->
	<xsl:template match="//fhir:id[@value='']"/>

	<!-- remove these elements -->
	<xsl:template match="fhir:basedOn"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:ServiceRequest]"/>
	<xsl:template match="fhir:generalPractitioner"/>
	
	<!-- patient's surgery -->
	<xsl:template match="fhir:entry[fhir:resource/fhir:Organization/fhir:identifier/fhir:system/@value='ods-organization-code']"/>

	<xsl:template match="fhir:Schedule/fhir:actor[fhir:reference/@value='urn:uuid:52428e73-0a5c-455d-8ff5-cd080e557082']"/>
	<xsl:template match="fhir:Schedule/fhir:actor[fhir:reference/@value='urn:uuid:6daaadd8-56e0-4d74-8350-1632331c5452']"/>
	<xsl:template match="fhir:location"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Practitioner]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:PractitionerRole]"/>
	<xsl:template match="fhir:entry[fhir:resource/fhir:Location]"/>

	<!--
	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>
	-->

	<xsl:template match="fhir:Appointment/fhir:created/@value">
		<xsl:attribute name="value"><xsl:value-of select="format-dateTime(current-dateTime(),'[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z]')"/></xsl:attribute>
	</xsl:template>

</xsl:stylesheet>

