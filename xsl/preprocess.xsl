<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:prosody="http://www.prosody.org" xmlns:TEI="http://www.tei-c.org/ns/1.0"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" version="2.0">

    <xsl:output indent="yes" method="xml" omit-xml-declaration="yes"/>

    <xsl:template match="/">
        <xsl:apply-templates select="TEI:TEI/TEI:text/TEI:body/*"/>
    </xsl:template>

    <xsl:template match="TEI:l">
        <xsl:variable name="line-number" select="@n"/>
        <xhtml:div class="prosody:line">
            <!-- first cycle through the segments, constructing shadow syllables -->
            <xhtml:div class="prosody-shadowline" id="prosody:shadow:{$line-number}">
                <xsl:copy-of select="@*"/>
                <xsl:for-each select="TEI:seg">
                    <xsl:variable name="word-position" select="position()"/>
                    <xsl:for-each select="tokenize(string(.),' ')">
                        <xhtml:span class="prosody-shadowsyllable" shadow=""
                            id="prosody:shadow:{$line-number}:{$word-position}:{position()}">
                            <xhtml:span class="prosody-placeholder">
                                <xsl:copy-of select="string(.)"/>
                            </xhtml:span>
                        </xhtml:span>
                    </xsl:for-each>
                </xsl:for-each>
            </xhtml:div>

            <xhtml:div class="TEI-l" id="prosody:real:{$line-number}">

                <xsl:copy-of select="@*"/>
                <xsl:for-each select="TEI:seg">
                    <xhtml:span class="TEI-seg">
                        <xsl:if test="position()=last()">
                            <xsl:attribute name="style" select="'padding-right:1em'"/>
                        </xsl:if>
                        <xsl:variable name="word-position" select="position()"/>
                        <xsl:for-each select="tokenize(string(.),' ')">
                            <xhtml:span class="prosody-syllable" real=""
                                id="prosody:real:{$line-number}:{$word-position}:{position()}"
                                onclick="switchstress(this.id);">
                                <xsl:if test="position()!=last()">
                                    <xsl:attribute name="style" select="'padding-right:1em'"/>
                                </xsl:if>
                                <xsl:copy-of select="."/>
                                <!-- add space back -->
                                <xsl:if test="position()!=last()">
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                            </xhtml:span>
                        </xsl:for-each>
                    </xhtml:span>
                </xsl:for-each>
                <xhtml:button class="prosody-checkstress" id="checkstress{$line-number}" name="Check stress" onclick="checkstress({$line-number})">Not right yet</xhtml:button>
                
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
