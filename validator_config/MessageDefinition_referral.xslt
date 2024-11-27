<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:fn="http://www.w3.org/2005/xpath-functions" xpath-default-namespace="http://hl7.org/fhir">
	<xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="yes"/>
	<xsl:variable name="messageheader_messagedefinition" select="/Bundle/entry/resource/MessageHeader/definition/@value"/>
	<xsl:variable name="reference_file" select="document('../simulator_config/BaRS_MessageDefinition/BaRS_MessageDefinition-Referral_Receiver.xml')"/>
	<xsl:variable name="spec_name" select="$reference_file/Bundle/entry[1]/resource/MessageDefinition/name/@value"/>
	<xsl:variable name="spec_url" select="$reference_file/Bundle/entry[1]/resource/MessageDefinition/url/@value"/>
	<xsl:variable name="spec_version" select="$reference_file/Bundle/entry[1]/resource/MessageDefinition/version/@value"/>
	<xsl:template match="/">
		<table width="100%" border="1" cellspacing="0" cellpadding="0">
			<xsl:for-each select="//profile/@value">
				<xsl:variable name="profile_name" select="."/>
				<xsl:variable name="check_result" select="boolean($reference_file//MessageDefinition[url/@value='https://fhir.nhs.uk/MessageDefinition/bars-message-servicerequest-request-referral']/focus/profile[@value=$profile_name])"/>
				<xsl:choose>
					<xsl:when test="not($check_result)">
						<tr>
							<td style="color:#900000" colspan="3">
								<xsl:text> Profile: </xsl:text>
								<xsl:value-of select="$profile_name"/>
								<xsl:text> is NOT present in Message Definition: </xsl:text>
								<!--<xsl:value-of select="$spec_name"/>-->
								<xsl:value-of select="$spec_url"/>
								<xsl:text> Version: </xsl:text>
								<xsl:value-of select="$spec_version"/>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
		</table>
	</xsl:template>
</xsl:stylesheet>

