<?xml version="1.0" encoding="ISO-8859-1" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
	xmlns:prosody="http://www.prosody.org"
	xmlns:x="http://java.sun.com/jsp/jstl/xml"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:TEI="http://www.tei-c.org/ns/1.0"
	xmlns="http://www.w3.org/1999/xhtml">
	<jsp:directive.page language="java" contentType="text/html" />
	<jsp:output omit-xml-declaration="false" doctype-root-element="html"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<c:import url="poems/${param.poem}" var="poem" />
	<x:parse doc="${poem}" var="poemxml" />
	
	<jsp:scriptlet>
		String ua = request.getHeader( "User-Agent" );
		boolean isFirefox = ( ua.indexOf( "Firefox/" ) != -1 );
		boolean isIE7orless = false;
		boolean isIE8 = false;
		
		if ( ua.indexOf( "MSIE" ) != -1 ) {
			String ieversion = ua.split( "MSIE" )[1].split(" ")[1].substring(0,3);
			isIE7orless = ( Float.valueOf(ieversion) &lt; 8 );
			isIE8 = ( Float.valueOf(ieversion).longValue() == 8);
		}
		
		response.setHeader( "Vary", "User-Agent" );
	</jsp:scriptlet>
	
	<html >
	<head>
		<meta http-equiv="Content-Type" content="text/html" />
		<title id="title">
			<c:out value="${param.poem}" />
		</title>
		<link href="css/main.css" rel="stylesheet" title="Basic TEI style" type="text/css" />
		<link href="css/themes/default.css" rel="stylesheet" type="text/css" />
		<link href="css/themes/mac_os_x.css" rel="stylesheet" type="text/css" />

		<jsp:scriptlet>if ( isFirefox ) { </jsp:scriptlet>
			<style type="text/css">
			  @import "css/ff.css";
			</style>
		<jsp:scriptlet>}</jsp:scriptlet>
		<jsp:scriptlet>if ( isIE7orless ) { </jsp:scriptlet>
			<link href="css/ie7.css" rel="stylesheet" title="IE7 CSS" type="text/css" />
		<jsp:scriptlet>}</jsp:scriptlet>
		<jsp:scriptlet>if ( isIE8 ) { </jsp:scriptlet>
			<link href="css/ie8.css" rel="stylesheet" title="IE8 CSS" type="text/css" />
		<jsp:scriptlet>}</jsp:scriptlet>
		
		
		<script type="text/javascript">debugflag=false;</script>
		<script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.js"><!--this--></script>
		<script type="text/javascript" src="http://www.prototypejs.org/assets/2009/6/16/prototype.js"><!--this--></script>
		<script type="text/javascript" id="scriptaculous" src="scripts/effects.js"><!--this--></script>
		<script type="text/javascript" id="window" src="scripts/window.js"><!--this--></script>
		<script type="text/javascript" src="scripts/handlers.js"><!--this--></script>
	</head>


	<body onload="init()">
		<script type="text/javascript" src="scripts/wz_tooltip.js"><!--this--></script>
		<div id="main">
			
			<c:import url="xsl/preprocess.xsl" var="preprocessxsl" />
		
			<x:transform doc="${poemxml}" xslt="${preprocessxsl}" />
		</div>
		<div id="utils">
			Show 
			<span>Stress <input id="togglestress" class="on" onclick="togglestress();" name="togglestress" value="on" type="checkbox" checked="checked"/></span> 
			<span>&#160;&#160;&#160;Foot division <input id="togglefeet" class="on" onclick="togglefeet();" name="togglefeet" value="on" type="checkbox" checked="checked"/></span> 
			<span>&#160;&#160;&#160;Caesura <input id="togglecaesura" class="on" onclick="togglecaesura();" name="togglecaesura" value="on" type="checkbox"/></span> 
			<span id="toggle-discrepancies" style="display:none">&#160;&#160;&#160;Syncopation <input id="togglediscrepancies" onclick="toggledifferences(this)" name="togglediscrepancies" value="off" type="checkbox"/></span>
		</div>
	</body>
	</html>
</jsp:root>
