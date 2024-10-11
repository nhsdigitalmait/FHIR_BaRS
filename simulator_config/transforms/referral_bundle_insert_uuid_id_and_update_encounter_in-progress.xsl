<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:fhir="http://hl7.org/fhir" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://exslt.org/math" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:uuid="http://www.uuid.org" version="2.0" exclude-result-prefixes="math xs uuid fhir">
  <xsl:include href="generate_uuid.xsl" />
   <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
 
 <!--Transform used for Updates to CADtoCAD Scenario messages-->
 <!--These will have triggered the SR_FULLURL_CADTOCAD_SC1 simulator rule with the ServiceRequest fullUrl urn:uuid:236bb75d-90ef-461f-b71e-fde7f899802c -->
 
 
  <!-- Add a generated UUID to each resource if not already present -->
  <xsl:template match="//fhir:entry/fhir:resource[not(fhir:ServiceRequest) and not (fhir:MessageHeader)]/*">
    <xsl:copy>
      <xsl:if test="not(fhir:id)">
        <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(.))" />
        <id xmlns="http://hl7.org/fhir" value="{$uuid}" />
      </xsl:if>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
 
 
 <!-- Update the Receivers Encounter last updated and status -->
 <xsl:template match="//fhir:entry[fhir:fullUrl/@value!=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value]/fhir:resource/fhir:Encounter/fhir:meta/fhir:lastUpdated/@value">
         <xsl:attribute name="value">
          <xsl:variable name="now" select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01].[f][Z]')"/>
          <xsl:value-of select="$now" />
        </xsl:attribute>
</xsl:template>

<xsl:template match="//fhir:entry[fhir:fullUrl/@value!=//fhir:ServiceRequest/fhir:encounter/fhir:reference/@value]/fhir:resource/fhir:Encounter/fhir:status/@value">
         <xsl:attribute name="value">in-progress</xsl:attribute>
</xsl:template>

  <!-- match all atts all nodes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>
