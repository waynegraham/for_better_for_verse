<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:prosody="http://www.prosody.org" xmlns:TEI="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml" version="2.0">
    
    <xsl:output indent="no" method="xml" omit-xml-declaration="yes"/>
    <xsl:strip-space elements="*"/>
    <xsl:variable name="scheme"><xsl:value-of select="//TEI:lg/@rhyme"/></xsl:variable>
    
    <xsl:template match="/">
        <div id="rhyme" style="display:none;">
            <div id="rhymespacer"><xsl:text> </xsl:text></div>
            <form name="{$scheme}" id="rhymeform">
            <xsl:for-each select="/TEI:TEI/TEI:text/TEI:body/TEI:lg">
                <xsl:variable name="lgPos"><xsl:value-of select="position()"/></xsl:variable>
                <br/>
                <xsl:for-each select="TEI:l">
                    <div class="lrhyme">
                        <input size="1" maxlength="1" value="a" name="lrhyme-{$lgPos}-{position()}" type="text" onFocus="this.value='';this.style['color'] = '#44FFFF';"/>
                    </div>
                </xsl:for-each>
            </xsl:for-each>
                <div class="lrhyme check"><input type="submit" value="√" size="1" maxlength="1" id="rhymecheck"/></div>
            </form>            
        </div>
        <div id="rhymebar">
            <xsl:text> </xsl:text>
        </div>
        <div id="poem">
            <div id="poemtitle">
                <h2>
                    <xsl:apply-templates
                        select="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title"/>										
												<xsl:apply-templates
		                        select="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:publicationStmt/TEI:date"/>
                </h2>
                <xsl:if test="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                    <h4>
                        <xsl:apply-templates
                            select="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author"/>
                    </h4>
                </xsl:if>
            </div>
            <xsl:apply-templates select="TEI:TEI/TEI:text/TEI:body/*"/>
        </div>
        <div id="rhymeflag">Rhyme</div>
    </xsl:template>

		<xsl:template match="TEI:date">
			<small class="date">
				<xsl:text>(</xsl:text>
					<xsl:value-of select="."/>
				<xsl:text>)</xsl:text>
			</small>
		</xsl:template>
    
    <xsl:template match="TEI:lg">
        <xsl:for-each select="TEI:l">
            <xsl:apply-templates select=".">
                <xsl:with-param name="linegroupindex" select="position()"/>
            </xsl:apply-templates>
        </xsl:for-each>
        <xsl:if test="not(./@rend='nobreak')">
              <br/>
        </xsl:if>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <xsl:param name="linegroupindex"/>
        <xsl:variable name="line-number" select="@n"/>
        
        <div class="prosody-line">
            <!-- first cycle through the segments, constructing shadow syllables -->
            <div class="prosody-shadowline" id="prosody-shadow-{$line-number}">
                <xsl:copy-of select="@*"/>
                <xsl:for-each select="TEI:seg">
                    
                    <xsl:variable name="seg-position" select="position()"/>
                    
                    <xsl:for-each select="text()|*/text()">
                        <xsl:variable name="foot-position" select="position()"/>
                        <xsl:variable name="foot-last" select="last()"/>
                        <xsl:for-each select="tokenize(string(.),' ')">
                            <xsl:if test="string(.)">
                                <span class="prosody-shadowsyllable" shadow=""
                                    id="prosody-shadow-{$line-number}-{$seg-position}-{$foot-position}-{position()}"
                                    onclick="switchstress(this);">
                                    <span class="prosody-placeholder">
                                        <xsl:copy-of select="string(.)"/>
										<xsl:if test="not(position()=last())">
	                                        <xsl:text> </xsl:text>
	                                    </xsl:if>
                                    </span>
                                </span>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                    <xsl:if test="name(following-sibling::*[1]) = 'caesura'">
                        <span class="caesura" style="display:none">//</span>
                    </xsl:if>
                </xsl:for-each>
            </div>
            
            <div class="TEI-l" id="prosody-real-{$line-number}">
                
                <xsl:copy-of select="@*"/>
                
                <span style="display:none;" linegroupindex="{$linegroupindex}" answer="{../@met}"
                    >Meter</span>
                
                <xsl:for-each select="TEI:seg">
                    <!-- if the following flag gets set, this indicates that there is a discrepancy in the line which must be later
                        highlighted -->
                    <xsl:variable name="discrepant-flag" select="exists(@real)"/>

                    <!-- if the following flag gets set, this indicates that there is a sb element in the line and the
                    segment ends with a space -->
                   
                    <xsl:variable name="seg-position" select="position()"/>

                    <xsl:for-each select="text()|*/text()">
                        <xsl:variable name="foot-position" select="position()"/>
                        <xsl:variable name="foot-last" select="last()"/>
                        <xsl:for-each select="tokenize(.,' ')">
                            <xsl:if test="string(.)">
                                <span class="prosody-syllable" real=""
                                    id="prosody-real-{$line-number}-{$seg-position}-{$foot-position}-{position()}"
                                    onclick="switchfoot('prosody-real-{$line-number}-{$seg-position}-{$foot-position}-{position()}');">
                                    <xsl:if test="$discrepant-flag">
                                        <xsl:attribute name="discrepant"/>
                                    </xsl:if>
                                    <xsl:copy-of select="."/>
                                    <!-- add space back -->
                                    
                                    <xsl:if test="not(position()=last())">
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    <!-- <span class="prosody-footmarker">|</span> -->
                                </span>
                            </xsl:if>
                        </xsl:for-each>
                    </xsl:for-each>
                    <xsl:if test="name(following-sibling::*[1]) = 'caesura'">
                        <span class="caesura" style="display:none">//</span>
                    </xsl:if>
                </xsl:for-each>
                
            </div>
            <div class="buttons">
                  <xsl:if test="TEI:note">
                    <span class="button">
                        <button class="prosody-note-button" id="displaynotebutton{$line-number}"
                            name="Note about this line" onclick="">
                            <img src="images/blank.gif"/>
                        </button>
                        <p class="prosody-note" id="hintfor{$line-number}">
                            <span>Note on line <xsl:value-of select="$line-number"/>:</span>
                            <xsl:value-of select="TEI:note"/>
                        </p>
                    </span>
                </xsl:if>
                <span class="button">
                    <button class="prosody-checkstress" id="checkstress{$line-number}"
                        name="Check stress" onclick="checkstress({$line-number})" onmouseover="Tip('Check stress', BGCOLOR, '#676767', BORDERWIDTH, 0, FONTCOLOR, '#FFF')" onmouseout="UnTip()">
                        <img src="images/stress-default.png"/>
                    </button>
                </span>
                <span class="button">
                    <button class="prosody-checkfeet" id="checkfeet{$line-number}" name="Check feet"
                        onclick="checkfeet({$line-number})" onmouseover="Tip('Check feet', BGCOLOR, '#676767', BORDERWIDTH, 0, FONTCOLOR, '#FFF')" onmouseout="UnTip()">
                        <img src="images/feet-default.png"/>
                    </button>
                </span>
                <span class="button">
                    <button class="prosody-meter" id="checkmeter{$line-number}" name="Check meter"
                        onclick="checkmeter({$line-number},{$linegroupindex})" onmouseover="Tip('Check meter', BGCOLOR, '#676767', BORDERWIDTH, 0, FONTCOLOR, '#FFF')" onmouseout="UnTip()">
                        <img src="images/meter-default.png"/>
                    </button>
                </span>
            </div>
            
        </div>
    </xsl:template>
    
    <xsl:template match="caesura"/>
    
</xsl:stylesheet>
