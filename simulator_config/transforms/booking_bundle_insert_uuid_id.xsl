<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:fhir="http://hl7.org/fhir" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://exslt.org/math" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:uuid="http://www.uuid.org" version="2.0" exclude-result-prefixes="math xs uuid fhir">
  <xsl:include href="generate_uuid.xsl" />
  <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(.))" />
  <xsl:param name ="appointment_uuid" select="$uuid" />
  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />
  <!-- Add a generated UUID to each resource if not already present -->
  <xsl:template match="//fhir:entry/fhir:resource[not(fhir:Schedule) and not(fhir:Slot) and not(fhir:HealthcareService) and not(fhir:Practitioner) and not(fhir:PractitionerRole) and not(fhir:Location) and not (fhir:Appointment)][//fhir:MessageHeader/fhir:eventCoding/fhir:code/@value='booking-request']/*">
    <xsl:choose>
      <xsl:when test="not(fhir:id)">
    <xsl:copy>
        <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(.))" />
        <id xmlns="http://hl7.org/fhir" value="{$uuid}" />
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
      </xsl:when>
            <xsl:otherwise>
        <xsl:attribute name="value">
          <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(.))" />
          <xsl:value-of select="$uuid" />
        </xsl:attribute>
      </xsl:otherwise>
    </xsl:choose>
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
  <!-- match all atts all nodes -->
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
