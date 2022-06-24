<?xml version="1.0"?>

<!-- change any rank 2 and lower to rank 1 -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:variable name="newbundleid" select="document('http://localhost:8001/getuuid?bundleid')/uuid/text()"/>

	<xsl:template match="fhir:Bundle/fhir:id/@value">
		<xsl:attribute name="value">
			<xsl:value-of select="$newbundleid"/>
		</xsl:attribute>
	</xsl:template>

	<xsl:include href="autotest_config/transforms/patient_not_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:template match="fhir:Patient">
		<xsl:if test="count(fhir:contact) &lt; 2">
			<xsl:message>WARNING: Template request has fewer than 2 contacts ( <xsl:value-of select="count(fhir:contact)"/> )</xsl:message>
		</xsl:if>
		<xsl:if test="count(fhir:contact) != count(fhir:contact/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank']/fhir:valuePositiveInt/@value)">
			<xsl:message>WARNING: Template request contact count (<xsl:value-of select="count(fhir:contact)"/>) does not match contact rank count (<xsl:value-of select="count(fhir:contact/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank']/fhir:valuePositiveInt/@value)"/>)</xsl:message>
		</xsl:if>

		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>
	
	<xsl:template match="fhir:Patient/fhir:contact/fhir:extension[@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank']/fhir:valuePositiveInt/@value[not(.='1')]">
		<xsl:attribute name="value">1</xsl:attribute>
	</xsl:template>

	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
