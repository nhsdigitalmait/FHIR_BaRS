<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:fhir="http://hl7.org/fhir" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://exslt.org/math" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:uuid="http://www.uuid.org" version="2.0" exclude-result-prefixes="math xs uuid fhir">
  <xsl:include href="generate_uuid.xsl" />
  <xsl:param name ="appointment_uuid" select="'33333333-3333-3333-3333-333333333333'" />
  <xsl:param name ="slot_uuid" select="'11111111-1111-1111-1111-111111111111'" />
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
  <!-- Add a generated UUID to each resource if not already present -->
  <xsl:template match="//fhir:entry/fhir:resource/*">
    <xsl:copy>
      <xsl:if test="not(fhir:id)">
        <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(.))" />
        <id xmlns="http://hl7.org/fhir" value="{$uuid}" />
      </xsl:if>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <!-- Substitute a specific id for Appointment -->
  <xsl:template match="//fhir:entry/fhir:resource[fhir:Appointment]/*">
    <xsl:copy>
      <xsl:if test="not(fhir:id)">
        <id xmlns="http://hl7.org/fhir" value="{$appointment_uuid}" />
      </xsl:if>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <!-- If there is already a Appointment/id then replace the value  -->
  <xsl:template match="//fhir:entry/fhir:resource/fhir:Appointment/fhir:id/@value">
    <xsl:attribute name="value">
      <xsl:value-of select="$appointment_uuid" />
    </xsl:attribute>
  </xsl:template>
  <!-- Substitute a specific id for Slot -->
  <xsl:template match="//fhir:entry/fhir:resource[fhir:Slot]/*">
    <xsl:copy>
      <xsl:if test="not(fhir:id)">
        <id xmlns="http://hl7.org/fhir" value="{$slot_uuid}" />
      </xsl:if>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <!-- If there is already a Slot/id then replace the value  -->
  <xsl:template match="//fhir:entry/fhir:resource/fhir:Slot/fhir:id/@value">
    <xsl:attribute name="value">
      <xsl:value-of select="$slot_uuid" />
    </xsl:attribute>
  </xsl:template>
  <!-- match all atts all nodes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>