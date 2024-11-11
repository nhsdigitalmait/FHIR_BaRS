<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fhir="http://hl7.org/fhir" version="2.0">
	<xsl:output method="html" indent="yes" omit-xml-declaration="yes"/>
	<xsl:variable name="epoch_start" select="xs:dateTime('1970-01-01T00:00:00')"/>
	<xsl:variable name="seconds" select="xs:dayTimeDuration('PT1S')"/>
	<xsl:variable name="now" select="current-dateTime()"/>
	<xsl:variable name="epoch_to_now" select="($now - $epoch_start)    div     $seconds"/>
	<xsl:template match="/">
		<table border="0">
			<xsl:variable name="careplan_start" select="/fhir:Bundle/fhir:entry/fhir:resource/fhir:CarePlan/fhir:period/fhir:start/@value"/>
			<xsl:choose>
				<xsl:when test="count($careplan_start)=1">
					<xsl:choose>
						<xsl:when test="$careplan_start castable as xs:dateTime">
							<xsl:variable name="careplanstart_dateTime" select="xs:dateTime($careplan_start)"/>
							<xsl:variable name="careplanstart_to_now" select="($careplanstart_dateTime - $epoch_start)    div     $seconds"/>
							<xsl:choose>
								<xsl:when test="$epoch_to_now &lt; $careplanstart_to_now">
									<xsl:call-template name="reportError">
										<xsl:with-param name="resultString" select="'CarePlan period start value is not in the past'"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:when test="$epoch_to_now &gt; $careplanstart_to_now">
									<xsl:call-template name="reportPass">
										<xsl:with-param name="resultString" select="'CarePlan period start value is in the past'"/>
									</xsl:call-template>
								</xsl:when>
							</xsl:choose>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="reportError">
								<xsl:with-param name="resultString" select="'CarePlan period start value present but not a valid dateTime'"/>
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>
				<xsl:when test="count($careplan_start)=0">
					<xsl:call-template name="reportError">
						<xsl:with-param name="resultString" select="'No CarePlan period start value is present'"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="reportError">
						<xsl:with-param name="resultString" select="'Multiple CarePlan period start values detected'"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</table>
	</xsl:template>
	<!-- REPORTING TEMPLATES -->
	<xsl:template name="reportPass">
		<xsl:param name="resultString"/>
		<tr>
			<td style="color:#008000">
				<xsl:text>Pass -- </xsl:text>
				<xsl:value-of select="$resultString"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="reportError">
		<xsl:param name="resultString"/>
		<tr>
			<td style="color:#900000">
				<xsl:text>Failed -- </xsl:text>
				<xsl:value-of select="$resultString"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template name="reportInfo">
		<xsl:param name="resultString"/>
		<tr>
			<td style="color:#008080">
				<xsl:text>Information -- </xsl:text>
				<xsl:value-of select="$resultString"/>
			</td>
		</tr>
	</xsl:template>
</xsl:stylesheet>
