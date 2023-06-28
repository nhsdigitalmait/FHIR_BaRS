<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:fhir="http://hl7.org/fhir" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://exslt.org/math" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:uuid="http://www.uuid.org" version="2.0" exclude-result-prefixes="math xs uuid fhir">
  <xsl:include href="generate_uuid.xsl" />
  <xsl:param name ="servicerequest_uuid" select="'22222222-2222-2222-2222-222222222222'" />
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
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
  <!-- Substitute a specific id for ServiceRequest -->
  <xsl:template match="//fhir:entry/fhir:resource[fhir:ServiceRequest]/*">
    <xsl:copy>
      <xsl:if test="not(fhir:id)">
        <id xmlns="http://hl7.org/fhir" value="{$servicerequest_uuid}" />
      </xsl:if>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <!-- If there is already a ServiceRequest/id then replace the value  -->
  <xsl:template match="//fhir:entry/fhir:resource/fhir:ServiceRequest/fhir:id/@value">
    <xsl:attribute name="value">
      <xsl:value-of select="$servicerequest_uuid" />
    </xsl:attribute>
  </xsl:template>
  <!-- If id is present then update only when "new" -->
  <xsl:template match="//fhir:entry/fhir:resource[not(fhir:ServiceRequest)]/*/fhir:id/@value">
    <xsl:choose>
      <xsl:when test="/fhir:Bundle/fhir:entry/fhir:resource/fhir:MessageHeader/fhir:reason/fhir:coding/fhir:code/@value='new'">
        <xsl:attribute name="value">
          <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(.))" />
          <xsl:value-of select="$uuid" />
        </xsl:attribute>
      </xsl:when>
      <xsl:otherwise>
        <xsl:attribute name="value">
          <xsl:value-of select="." />
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- match all atts all nodes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
