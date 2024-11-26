<?xml version="1.0"?>

<!-- remove appt id for initial booking and transform for basic booking request add another appointment resource-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="2.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>


	<xsl:variable name="created_timestamp" select="format-dateTime(current-dateTime(),'[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z]')"/>
	<xsl:variable name="appointment_start" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:Appointment/fhir:start/@value"/>
	<xsl:variable name="appointment_end" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:Appointment/fhir:end/@value"/>

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


<xsl:template match="fhir:Bundle">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<!-- appends at end of Bundle -->
		<entry xmlns="http://hl7.org/fhir">
			<fullUrl value="urn:uuid:74b9bc9c-9c26-434c-abe8-571fd22934d4"/>
			<resource>
				<Appointment>
					<meta>
						<lastUpdated value="2021-10-11T15:01:30.8185338+00:00"/>
						<profile value="http://hl7.org/fhir/StructureDefinition/Appointment"/>
						<profile value="https://fhir.hl7.org.uk/StructureDefinition/UKCore-Appointment"/>
					</meta>
					<status value="booked"/>
					<description value="Reason for calling-"/>
					<start value="{$appointment_start}"/>
					<end value="{$appointment_end}"/>
					<slot>
						<reference value="Slot/urn:uuid:deb4c4b3-870b-4599-84df-5e54cef7afda"/>
					</slot>
					<created value="{$created_timestamp}"/>
					<participant>
						<actor>
							<reference value="urn:uuid:788660eb-d2c9-4773-abd4-318484673fb2"/>
						</actor>
						<status value="accepted"/>
					</participant>
				</Appointment>
			</resource>
		</entry>
				</xsl:copy>
	</xsl:template>







</xsl:stylesheet>

