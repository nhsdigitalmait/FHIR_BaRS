<?xml version="1.0"?>

<!-- generic new service request make patient traced and remove listed ids add UPRN address eastings/northings w3w -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

	<xsl:template match="fhir:Location/fhir:extension">
		<fhir:extension url="https://fhir.nhs.uk/StructureDefinition/LocationExtension">
			<fhir:extension url="what3words">
				<fhir:valueString value="what three words"/>
			</fhir:extension>
			<xsl:copy-of select="fhir:extension[matches(@url,'UPRN|eastings|northings')]"/>
		</fhir:extension>
	</xsl:template>

	<xsl:template match="fhir:Location/fhir:position"/>

</xsl:stylesheet>
