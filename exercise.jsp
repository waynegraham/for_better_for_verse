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
		if ( ua.indexOf( "MSIE" ) != -1 ) {
			String ieversion = ua.split( "MSIE" )[1].split(" ")[1].substring(0,3);
			isIE7orless = ( Float.valueOf(ieversion) &lt; 8 );
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
		
		<jsp:scriptlet>if ( isIE7orless ) { </jsp:scriptlet>
			<link href="css/ie.css" rel="stylesheet" title="IE junk" type="text/css" />
		<jsp:scriptlet>}</jsp:scriptlet>
		
		<script type="text/javascript">debugflag=true;</script>
		<script type="text/javascript" src="http://jqueryjs.googlecode.com/files/jquery-1.3.2.js"><!--this--></script>
		<script type="text/javascript" src="http://www.prototypejs.org/assets/2009/6/16/prototype.js"><!--this--></script>
		<script type="text/javascript" id="scriptaculous" src="scripts/effects.js"><!--this--></script>
		<script type="text/javascript" id="window" src="scripts/window.js"><!--this--></script>
		<script type="text/javascript" src="scripts/handlers.js"><!--this--></script>
		
	</head>


	<body onload="init()">
		<div id="main">
		
			<c:import url="xsl/preprocess.xsl" var="preprocessxsl" />
			
		
			<x:transform doc="${poemxml}" xslt="${preprocessxsl}" />
		</div>
		<div id="utils">
			<button id="togglestress" class="on" onclick="togglestress();">Hide/show stresses</button>
			</div>
	</body>
	</html>
</jsp:root>
