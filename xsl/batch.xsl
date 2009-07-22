<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" version="2.0" exclude-result-prefixes="#all"
    xmlns:TEI="http://www.tei-c.org/ns/1.0">

    <xsl:output method="xml" indent="no"
        doctype-system="http://localhost:8080/prosody/poems/tei_all.dtd"
        doctype-public="-//TEI P5//DTD Main Document Type//EN"/>

    <xsl:preserve-space elements="*"/>

    <xsl:template match="TEI:l">
        <l xmlns="http://www.tei-c.org/ns/1.0">
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="met" select="string-join(TEI:seg/@met,'')"/>
            <xsl:attribute name="real"
                select="string-join(for $i in TEI:seg return if ($i/@real) then $i/@real else $i/@met,'')"/>
            <xsl:apply-templates/>
        </l>

    </xsl:template>


    <!-- identity template -->
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>
