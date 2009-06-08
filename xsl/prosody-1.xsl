<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:TEI="http://www.tei-c.org/ns/1.0"
    version="1.0">
    
    
    <xsl:output method="xml" 
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" 
        indent="yes" />
    
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
            <head>
                <meta content="text/html" http-equiv="Content-Type"/>
                
                <title>
                    <xsl:value-of select="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title"/> -
                    <xsl:value-of select="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author"/>
                </title>
                
               <script type="text/javascript">debugflag=false;</script>    
               <script type="text/javascript" src="http://wwww.prototypejs.org/assets/2009/3/27/prototype.js"><xsl:text> </xsl:text></script>
               <script type="text/javascript" id="scriptaculous" src="http://sds1.itc.virginia.edu:8080/prosody/scripts/effects.js"><xsl:text> </xsl:text></script>
                <script type="text/javascript" id="handlers" src="http://sds1.itc.virginia.edu:8080/prosody/scripts/handlers.js"><xsl:text> </xsl:text></script> 
                
               <link href="../css/reset.css" rel="stylesheet" type="text/css" /> 
               <link href="../css/main.css" rel="stylesheet" type="text/css" />
               <link href="../css/ie.css" rel="stylesheet" type="text/css"/> 
            </head>
            <body onload="init();">
                <div id="main">
                    <div id="poem">
                        <div id="title">
                            <h2><xsl:value-of select="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:title"/></h2>
                            
                            <xsl:if test="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author">
                                <h4>
                                    <xsl:value-of select="/TEI:TEI/TEI:teiHeader/TEI:fileDesc/TEI:titleStmt/TEI:author"/>
                                </h4>
                            </xsl:if>
                        </div>
                    
                        <xsl:apply-templates select="TEI:TEI/TEI:text/TEI:body/*" />
                    </div>
                    <button id="toggle-discrepancies" value="off" onclick="toggledifferences(this)">Toggle
                        metrical discrepancies</button>
                </div>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="TEI:body">
        <xsl:apply-templates />
    </xsl:template>
    
    <xsl:template match="TEI:lg">
        <xsl:for-each select="TEI:l">
            <xsl:apply-templates select=".">
                <xsl:with-param name="linegroupindex" select="position()"/>
            </xsl:apply-templates>
        </xsl:for-each>
        <br/>
    </xsl:template>
    
    <xsl:template match="TEI:l">
        <xsl:param name="linegroupindex"/>
        <xsl:variable name="line-number" select="@n"/>
        
        <div class="prosody:line">
            <!-- first cycle through the segments, constructing shadow syllables -->
            <div class="prosody-shadowline" id="prosody:shadow:{$line-number}">
                <xsl:copy-of select="@*"/>
                <xsl:for-each select="TEI:seg">
                    
                    <xsl:variable name="seg-position" select="position()"/>
                    
                    <xsl:for-each select="text()|*/text()">
                        <xsl:variable name="foot-position" select="position()"/>
                        <xsl:variable name="foot-last" select="last()"/>
                        <!-- <xsl:for-each select="tokenize(string(.),' ')">
                            <xsl:if test="string(.)">
                                <span class="prosody-shadowsyllable" shadow=""
                                    id="prosody:shadow:{$line-number}:{$seg-position}:{$foot-position}:{position()}"
                                    onclick="switchstress(this);">
                                    <span class="prosody-placeholder">
                                        <xsl:copy-of select="string(.)"/>
                                    </span>
                                </span>
                            </xsl:if>
                        </xsl:for-each> -->
                    </xsl:for-each>
                </xsl:for-each>
            </div>
            
            <div class="TEI-l" id="prosody:real:{$line-number}">
                
                <xsl:copy-of select="@*"/>
                
                <span style="display:none;" linegroupindex="{$linegroupindex}" answer="{../@met}"
                    >Meter</span>
                
                <xsl:for-each select="TEI:seg">
                    <!-- if the following flag gets set, this indicates that there is a discrepancy in the line which must be later
                        highlighted -->
                    <!-- <xsl:variable name="discrepant-flag" select="exists(@real) and exists(@met)"/> -->
                    
                    <!-- if the following flag gets set, this indicates that there is a sb element in the line and the
                        segment ends with a space -->
                    
                    <xsl:variable name="seg-position" select="position()"/>
                    
                    <xsl:for-each select="text()|*/text()">
                        <xsl:variable name="foot-position" select="position()"/>
                        <xsl:variable name="foot-last" select="last()"/>
                        
                        <xsl:call-template name="tokenize">
                            <xsl:with-param name="string" select="." />
                            <xsl:with-param name="delimiters" select="''" />
                        </xsl:call-template>
                        
                        <!--<xsl:for-each select="tokenize(.,' ')">
                            <xsl:if test="string(.)">
                                <span class="prosody-syllable" real=""
                                    id="prosody:real:{$line-number}:{$seg-position}:{$foot-position}:{position()}"
                                    onclick="switchfoot('prosody:real:{$line-number}:{$seg-position}:{$foot-position}:{position()}');">
                                    <xsl:if test="$discrepant-flag">
                                        <xsl:attribute name="discrepant"/>
                                    </xsl:if>
                                    <xsl:copy-of select="."/>
                                    -->
                                    <!-- add space back
                                    
                                    <xsl:if test="not(position()=last())">
                                        <xsl:text> </xsl:text>
                                    </xsl:if>
                                    
                                </span>
                            </xsl:if>
                        </xsl:for-each> -->
                    </xsl:for-each>
                </xsl:for-each>
                
            </div>
            <div class="buttons">
                <xsl:if test="TEI:note">
                    <span class="button">
                        <button class="prosody-note-button" id="displaynotebutton{$line-number}"
                            name="Note about this line" onclick="">
                            <img alt="blank" src="images/blank.gif"/>
                        </button>
                        <p class="prosody-note" id="hintfor{$line-number}">
                            <span>Note on line number <xsl:value-of select="$line-number"/>:</span>
                            <xsl:copy-of select="TEI:note"/>
                        </p>
                    </span>
                </xsl:if>
                <span class="button">
                    <button class="prosody-checkstress" id="checkstress{$line-number}"
                        name="Check stress" onclick="checkstress({$line-number})">
                        <img alt="stress" src="../images/stress-default.png"/>
                    </button>
                </span>
                <span class="button">
                    <button class="prosody-checkfeet" id="checkfeet{$line-number}" name="Check feet"
                        onclick="checkfeet({$line-number})">
                        <img alt="foot" src="../images/feet-default.png"/>
                    </button>
                </span>
                <span class="button">
                    <button class="prosody-meter" id="checkmeter{$line-number}" name="Check meter"
                        onclick="checkmeter({$line-number},{$linegroupindex})">
                        <img alt="meter" src="../images/meter-default.png"/>
                    </button>
                </span>
            </div>
            
        </div>
    </xsl:template>
    
    <xsl:template match="caesura"/>
    
    <!-- functions -->
    <xsl:template name="tokenize">
        <xsl:param name="string" select="''" />
        <xsl:param name="delimiters" select="' &#x9;&#xA;'" />
        <xsl:choose>
            <xsl:when test="not($string)" />
            <xsl:when test="not($delimiters)">
                <xsl:call-template name="_tokenize-characters">
                    <xsl:with-param name="string" select="$string" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="_tokenize-delimiters">
                    <xsl:with-param name="string" select="$string" />
                    <xsl:with-param name="delimiters" select="$delimiters" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="_tokenize-characters">
        <xsl:param name="string" />
        <xsl:param name="len" select="string-length($string)"/>
        <xsl:choose>
            <xsl:when test="$len = 1">
                <token><xsl:value-of select="$string"/></token>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="_tokenize-characters">
                    <xsl:with-param name="string" select="substring($string, 1, floor($len div 2))" />
                    <xsl:with-param name="len" select="floor($len div 2)"/>
                </xsl:call-template>
                <xsl:call-template name="_tokenize-characters">
                    <xsl:with-param name="string" select="substring($string, floor($len div 2) + 1)" />
                    <xsl:with-param name="len" select="ceiling($len div 2)"/>
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template name="_tokenize-delimiters">
        <xsl:param name="string" />
        <xsl:param name="delimiters" />
        <xsl:param name="last-delimit"/> 
        <xsl:variable name="delimiter" select="substring($delimiters, 1, 1)" />
        <xsl:choose>
            <xsl:when test="not($delimiter)">
                <token><xsl:value-of select="$string"/></token>
            </xsl:when>
            <xsl:when test="contains($string, $delimiter)">
                <xsl:if test="not(starts-with($string, $delimiter))">
                    <xsl:call-template name="_tokenize-delimiters">
                        <xsl:with-param name="string" select="substring-before($string, $delimiter)" />
                        <xsl:with-param name="delimiters" select="substring($delimiters, 2)" />
                    </xsl:call-template>
                </xsl:if>
                <xsl:call-template name="_tokenize-delimiters">
                    <xsl:with-param name="string" select="substring-after($string, $delimiter)" />
                    <xsl:with-param name="delimiters" select="$delimiters" />
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:call-template name="_tokenize-delimiters">
                    <xsl:with-param name="string" select="$string" />
                    <xsl:with-param name="delimiters" select="substring($delimiters, 2)" />
                </xsl:call-template>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
