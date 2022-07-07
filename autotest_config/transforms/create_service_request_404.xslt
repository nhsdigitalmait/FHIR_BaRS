<?xml version="1.0"?>

<!-- generic new service request make patient traced and remove listed ids -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_is_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/remove_listed_ids.xslt"/>

	<xsl:template match="fhir:Patient/fhir:identifier/fhir:value/@value">
		<xsl:attribute name="value">9976150288</xsl:attribute>
	</xsl:template>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

</xsl:stylesheet>
