<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:fhir="http://hl7.org/fhir" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://exslt.org/math" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:uuid="http://www.uuid.org" version="2.0" exclude-result-prefixes="math xs uuid fhir">
	<xsl:include href="generate_uuid.xsl"/>
    <xsl:param name ="messageheader_uuid" select="'11111111-1111-1111-1111-111111111111'"/>
    <xsl:param name ="servicerequest_uuid" select="'22222222-2222-2222-2222-222222222222'"/>
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    <xsl:template match="//fhir:entry/fhir:resource/*">
        <xsl:variable name="uuid" select="uuid:get-uuid(.)"/>
        <xsl:copy>
            <id xmlns="http://hl7.org/fhir" value="{$uuid}"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//fhir:entry/fhir:resource[fhir:MessageHeader]/*">
        <xsl:copy>
            <id xmlns="http://hl7.org/fhir" value="{$messageheader_uuid}"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="//fhir:entry/fhir:resource[fhir:ServiceRequest]/*">
        <xsl:copy>
            <id xmlns="http://hl7.org/fhir" value="{$servicerequest_uuid}"/>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
        <!-- match all atts all nodes -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
	
</xsl:stylesheet>
