<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:prosody="http://www.prosody.com" xmlns:TEI="http://www.tei-c.org/ns/1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0">

    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="TEI:TEI/TEI:text/TEI:body/*"/>
    </xsl:template>

    <xsl:template match="TEI:l">
        <!-- first cycle through the segments, constructing shadow syllables -->
        <xhtml:span class="prosody:shadowline">
            <xsl:copy-of select="@*"/>
            <xsl:for-each select="TEI:seg">
                <xhtml:span class="prosody:shadowsyllable" id="{concat('shadow',../@n,':',position())}"> </xhtml:span>
            </xsl:for-each>
        </xhtml:span>
        <TEI:l>
            <xhtml:span class="TEI:l">
                <xsl:copy-of select="@*"/>
                <xsl:for-each select="TEI:seg">
                    <TEI:seg>
                        <xsl:copy-of select="@*"/>
                        <xhtml:span class="prosody:syllable" id="{concat('real',../@n,':',position())}"
                            onclick="stress(this.id);">
                            <xsl:copy-of select="."/>
                        </xhtml:span>
                    </TEI:seg>
                </xsl:for-each>
            </xhtml:span>
        </TEI:l>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
