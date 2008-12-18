<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:prosody="http://www.prosody.org" xmlns:TEI="http://www.tei-c.org/ns/1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0">

    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>
    <xsl:preserve-space elements="*"/>

    <xsl:template match="/">
        <xhtml:div id="poem">
        <xsl:apply-templates select="TEI:TEI/TEI:text/TEI:body/*"/>
        </xhtml:div>
    </xsl:template>

    <xsl:template match="TEI:l">
        <xsl:variable name="line-number" select="@n"/>
        <xhtml:div class="prosody:line">
            <!-- first cycle through the segments, constructing shadow syllables -->
            <xhtml:div class="prosody-shadowline" id="prosody:shadow:{$line-number}">
                <xsl:copy-of select="@*"/>
                <xsl:for-each select="TEI:seg">

                    <xsl:variable name="seg-position" select="position()"/>

                    <xsl:for-each select="text()|*/text()">
                        <xsl:variable name="foot-position" select="position()"/>
                        <xsl:variable name="foot-last" select="last()"/>
                        <xsl:for-each select="tokenize(normalize-space(string(.)),' ')">
                            <xhtml:span class="prosody-shadowsyllable" shadow=""
                                id="prosody:shadow:{$line-number}:{$seg-position}:{$foot-position}:{position()}"
                                onclick="switchstress(this);">

                                <xhtml:span class="prosody-placeholder">
                                    <xsl:copy-of select="string(.)"/>
                                </xhtml:span>
                            </xhtml:span>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
            </xhtml:div>

            <xhtml:div class="TEI-l" id="prosody:real:{$line-number}">

                <xsl:copy-of select="@*"/>
                <xsl:for-each select="TEI:seg">
                    <xsl:variable name="sb-flag" select="exists(TEI:sb)"/>
                    <xsl:variable name="seg-position" select="position()"/>
                    <xsl:variable name="seg-last" select="last()"/>
                    <xsl:for-each select="text()|*/text()">
                        <xsl:variable name="foot-position" select="position()"/>
                        <xsl:variable name="foot-last" select="last()"/>
                        <xsl:for-each select="tokenize(normalize-space(string(.)),' ')">
                            <xhtml:span class="prosody-syllable" real=""
                                id="prosody:real:{$line-number}:{$seg-position}:{$foot-position}:{position()}"
                                onclick="switchfoot('prosody:real:{$line-number}:{$seg-position}:{$foot-position}:{position()}');">

                                <!-- <xsl:if test="position()!=last() or $foot-last = $foot-position">
                                    <xsl:attribute name="style" select="'padding-right:1em'"/>
                                </xsl:if> -->


                                <xsl:copy-of select="."/>
                                <!-- add space back -->
                                <xsl:if
                                    test="not(position()=last() and $sb-flag)">
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                            </xhtml:span>
                        </xsl:for-each>
                    </xsl:for-each>
                </xsl:for-each>
                <xhtml:div class="buttons">
                <xhtml:button class="prosody-checkstress" id="checkstress{$line-number}"
                    name="Check stress" onclick="checkstress({$line-number})">Not right yet</xhtml:button>
                <xhtml:label for="checkstress{$line-number}">Check your scansion</xhtml:label>
                <xhtml:button class="prosody-checkfeet" id="checkfeet{$line-number}"
                    name="Check stress" onclick="checkfeet({$line-number})">Not right yet</xhtml:button>
                <xhtml:label for="checkfeet{$line-number}">Check your feet</xhtml:label>
                </xhtml:div>
            </xhtml:div>


        </xhtml:div>
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>

</xsl:stylesheet>
