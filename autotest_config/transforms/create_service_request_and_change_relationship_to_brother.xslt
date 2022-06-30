<?xml version="1.0"?>

<!-- generic new service request make patient traced, remove listed ids change rank 1 relationship to brother -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<xsl:template match="fhir:Patient">
		<xsl:if test="not (fhir:contact[fhir:extension/@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank'][fhir:extension/fhir:valuePositiveInt/@value='1'])">
			<xsl:message>WARNING Rank 1 contact does not exist in template</xsl:message>
		</xsl:if>
		<xsl:if test="not(fhir:contact[fhir:extension/@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank'][fhir:extension/fhir:valuePositiveInt/@value='1']/fhir:relationship)">
			<xsl:message>WARNING Rank 1 contact does not contain relatationship in template</xsl:message>
		</xsl:if>

		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

	<!-- change the rank 1 relationship to BROTHER -->
	<xsl:template match="fhir:Patient/fhir:contact[fhir:extension/@url='https://fhir.hl7.org.uk/StructureDefinition/Extension-UKCore-ContactRank'][fhir:extension/fhir:valuePositiveInt/@value='1']/fhir:relationship/fhir:coding[fhir:system/@value='https://fhir.hl7.org.uk/ValueSet/UKCore-PersonRelationshipType']/fhir:code/@value">
		<xsl:attribute name="value"><xsl:value-of select="'BROTHER'"/></xsl:attribute>
	</xsl:template>

</xsl:stylesheet>
