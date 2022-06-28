<?xml version="1.0"?>

<!-- don't remove the ids -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fhir="http://hl7.org/fhir" version="1.0">

	<xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

	<xsl:include href="autotest_config/transforms/patient_not_traced.xslt"/>

	<xsl:include href="autotest_config/transforms/common_message_transforms.xslt"/>

</xsl:stylesheet>
