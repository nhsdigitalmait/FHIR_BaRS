<?xml version="1.0"?>

<!-- modifies a validation request into a validation response to be sent by autotest -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" xmlns="http://hl7.org/fhir" version="1.0">
	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:variable name="bundleid" select="/fhir:Bundle/fhir:id/@value"/>
	<xsl:variable name="newencounterid" select="lower-case(document('http://localhost:8001/getuuid?newencounterid')/uuid/text())"/>
	<xsl:variable name="nnn" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:Patient/fhir:identifier[fhir:system/@value='https://fhir.nhs.uk/Id/nhs-number']/fhir:value/@value"/>

	<!-- sentinel values -->
	<xsl:variable name="full" select="$nnn = '9658499147'"/>
	<xsl:variable name="interim" select="$nnn = '9658499155'"/>

	<!--
	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>
	-->
	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<!-- for testing a different path to the includes -->
	<!--
	<xsl:include href="../../autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="../../autotest_config/transforms/common_message_transforms.xslt"/>
	-->

	<xsl:template match="fhir:MessageHeader">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<!-- appends at end of MessageHeader -->
			<response>
				<!-- Response to the original Validation Request -->
				<identifier value="{$bundleid}"/>
				<code value="ok"/>
			</response>
		</xsl:copy>
	</xsl:template>

	<xsl:template match="fhir:ServiceRequest/fhir:status/@value">
		<xsl:attribute name="value">completed</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:eventCoding/fhir:code/@value">
		<xsl:attribute name="value">servicerequest-response</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:destination/fhir:receiver/fhir:reference/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="//fhir:MessageHeader/fhir:sender/fhir:reference/@value"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:sender/fhir:reference/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="//fhir:MessageHeader/fhir:destination/fhir:receiver/fhir:reference/@value"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:source/fhir:name/@value">
		<xsl:attribute name="value">CAS Emergency service</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:focus/fhir:reference/@value">
		<xsl:attribute name="value">urn:uuid:<xsl:value-of select="$newencounterid"/></xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:meta/fhir:profile/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="'https://fhir.nhs.uk/StructureDefinition/BARSMessageHeader-servicerequest-response'"/>
		</xsl:attribute>
	</xsl:template>

	<!-- NBRS 1775 if the supplier is using http rather than https for the system protocol prefix then fix this for them! -->
	<xsl:template match="fhir:MessageHeader/fhir:source/fhir:endpoint/@value|fhir:MessageHeader/fhir:destination/fhir:endpoint/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="replace(.,'^http:','https:')"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:MessageHeader/fhir:definition/@value">
		<xsl:choose>
			<xsl:when test="$interim">
				<xsl:attribute name="value">
					<xsl:value-of select="'https://fhir.nhs.uk/MessageDefinition/bars-message-servicerequest-response-validation-interim'"/>
				</xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="value">
					<xsl:value-of select="'https://fhir.nhs.uk/MessageDefinition/bars-message-servicerequest-response-validation-full'"/>
				</xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="fhir:Encounter/fhir:status/@value[$full]">
		<xsl:attribute name="value">finished</xsl:attribute>
	</xsl:template>

	<xsl:template match="fhir:Bundle">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
			<!-- appends at end of Bundle -->
			<entry>
				<fullUrl value="{concat('urn:uuid:',$newencounterid)}"/>
				<resource>
					<Encounter>
						<!-- New Encounter for the response -->
						<id value="{$newencounterid}"/>
						<meta>
							<lastUpdated value="2021-11-26T15:15:15+00:00"/>
							<profile value="https://fhir.hl7.org.uk/StructureDefinition/UKCore-Encounter"/>
						</meta>
						<identifier>
							<system value="https://receiver.url/Id/case-number"/>
							<!-- Set by the receiver who is passing the business case number value -->
							<value value="receiver1234"/>
						</identifier>
						<status value="finished"/>
						<class>
							<system value="http://terminology.hl7.org/CodeSystem/v3-ActCode"/>
							<code value="EMER"/>
							<display value="emergency"/>
						</class>
						<subject>
							<reference value="urn:uuid:9589fb37-87a2-48d8-968f-b371429208a8"/>
						</subject>
						<episodeOfCare>
							<!-- Resource reference to an EpisodeOfCare Journey ID -->
							<reference value="urn:uuid:d877b820-e72b-44d1-a627-195f54bfc606"/>
						</episodeOfCare>
						<period>
							<start value="2021-11-26T15:15:00+00:00"/>
						</period>
						<reasonCode>
							<coding>
								<system value="https://fhir.nhs.uk/CodeSystem/message-reason-encounter"/>
								<code value="validation-triage-outcome"/>
								<display value="Validation of triage outcome"/>
							</coding>
						</reasonCode>
					</Encounter>
				</resource>
			</entry>
			<!-- add third encounter for full -->
			<xsl:if test="$full">
				<entry>
					<fullUrl value="urn:uuid:9517b1c8-4dc3-46c3-a183-de6c26f48cde"/>
					<resource>
						<Encounter>
							<!-- New Encounter 3 for the ITK response -->
							<id value="9517b1c8-4dc3-46c3-a183-de6c26f48cde"/>
							<meta>
								<lastUpdated value="2021-11-26T15:25:00+00:00"/>
								<profile value="https://fhir.hl7.org.uk/StructureDefinition/UKCore-Encounter"/>
							</meta>
							<identifier>
								<!-- ITK Ambulance Request response - CAD ID -->
								<system value="urn:oid:2.16.840.1.113883.2.1.3.2.4.18.20"/>
								<value value="S2201240528"/>
								<!-- This is the CAD ID returned in the Ambulance request response -->
							</identifier>
							<status value="finished"/>
							<class>
								<system value="http://terminology.hl7.org/CodeSystem/v3-ActCode"/>
								<code value="EMER"/>
								<display value="emergency"/>
							</class>
							<subject>
								<reference value="urn:uuid:9589fb37-87a2-48d8-968f-b371429208a8"/>
							</subject>
							<episodeOfCare>
								<!-- Resource reference to an EpisodeOfCare Journey ID -->
								<reference value="d877b820-e72b-44d1-a627-195f54bfc606"/>
							</episodeOfCare>
							<period>
								<start value="2021-11-26T15:25:00+00:00"/>
							</period>
						</Encounter>
					</resource>
				</entry>
			</xsl:if>
		</xsl:copy>
	</xsl:template>
</xsl:stylesheet>
