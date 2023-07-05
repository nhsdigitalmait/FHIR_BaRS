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
  <xsl:template match="/fhir:Bundle">
    <Bundle xmlns="http://hl7.org/fhir">
      <xsl:apply-templates select="@* | *"/>
      <entry xmlns="http://hl7.org/fhir">
        <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(.))"/>
        <fullUrl xmlns="http://hl7.org/fhir" value="urn:uuid:{$uuid}"/>
        <resource xmlns="http://hl7.org/fhir">
          <Encounter xmlns="http://hl7.org/fhir">
            <xsl:variable name="uuid" select="lower-case(uuid:get-uuid(..))"/>
            <id xmlns="http://hl7.org/fhir" value="{$uuid}"/>
            <meta xmlns="http://hl7.org/fhir">
               <xsl:variable name="now" select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01].[f][Z]')"/>
               <lastUpdated xmlns="http://hl7.org/fhir" value="{$now}"/>
               <profile xmlns="http://hl7.org/fhir" value="https://fhir.hl7.org.uk/StructureDefinition/UKCore-Encounter"/>
            </meta>
            <identifier xmlns="http://hl7.org/fhir">
              <system xmlns="http://hl7.org/fhir" value="https://receiver.url/Id/case-number"/>
              <xsl:variable name="day" select="number(format-dateTime(current-dateTime(), '[D]'))"/>
              <xsl:variable name="sec" select="number(format-dateTime(current-dateTime(), '[s]'))"/>
              <xsl:variable name="frac" select="number(format-dateTime(current-dateTime(), '[f]'))"/>
              <xsl:variable name="readableIdentifier" select="(number(9) + $sec) * (number(99) + $day) * (number(999) + $frac) mod 100000"/>
              <value xmlns="http://hl7.org/fhir" value="10{$readableIdentifier}"/>
            </identifier>
            <status xmlns="http://hl7.org/fhir" value="planned"/>
            <class xmlns="http://hl7.org/fhir">
              <system xmlns="http://hl7.org/fhir" value="http://terminology.hl7.org/CodeSystem/v3-ActCode"/>
              <code xmlns="http://hl7.org/fhir" value="EMER"/>
              <display xmlns="http://hl7.org/fhir" value="emergency"/>
            </class>
            <subject xmlns="http://hl7.org/fhir">
              <xsl:variable name="reference" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:ServiceRequest/fhir:subject/fhir:reference/@value"/>
              <reference xmlns="http://hl7.org/fhir" value="{$reference}"/>
            </subject>
            <episodeOfCare xmlns="http://hl7.org/fhir">
              <xsl:variable name="reference" select="//fhir:episodeOfCare/fhir:reference/@value"/>
              <reference xmlns="http://hl7.org/fhir" value="{$reference}"/>
            </episodeOfCare>
            <period xmlns="http://hl7.org/fhir">
              <xsl:variable name="now" select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01]T[H01]:[m01]:[s01][Z]')"/>
              <start xmlns="http://hl7.org/fhir" value="{$now}"/>
            </period>
          </Encounter>
        </resource>
      </entry>
    </Bundle>
  </xsl:template>
</xsl:stylesheet>
