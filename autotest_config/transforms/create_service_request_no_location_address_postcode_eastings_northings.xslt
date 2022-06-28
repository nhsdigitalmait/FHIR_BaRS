<?xml version="1.0"?>

<!-- generic new service request make patient not traced and remove listed ids and location address and eastings/northings -->

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

	<xsl:template match="fhir:Location/fhir:address"/>
	<xsl:template match="fhir:Location/fhir:extension[@url='https://fhir.nhs.uk/StructureDefinition/LocationExtension']/fhir:extension[@url='eastings']"/>
	<xsl:template match="fhir:Location/fhir:extension[@url='https://fhir.nhs.uk/StructureDefinition/LocationExtension']/fhir:extension[@url='northings']"/>

	<!-- match all atts all nodes -->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()"/>
		</xsl:copy>
	</xsl:template>

</xsl:stylesheet>
