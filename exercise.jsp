<?xml version="1.0" encoding="ISO-8859-1" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
	xmlns:prosody="http://www.prosody.org"
	xmlns:x="http://java.sun.com/jsp/jstl/xml"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:TEI="http://www.tei-c.org/ns/1.0">
	<jsp:directive.page language="java" contentType="text/xml" />
	<jsp:output omit-xml-declaration="false" doctype-root-element="html"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<c:import url="poems/${param.poem}" var="poem" />
	<x:parse doc="${poem}" var="poemxml" />

	<xhtml:html xmlns:xhtml="http://www.w3.org/1999/xhtml">
	<xhtml:head>
		<xhtml:meta http-equiv="Content-Type" content="text/html" />
		<xhtml:title id="title">
			<c:out value="${param.poem}" />
		</xhtml:title>
		<xhtml:link href="css/main.css" rel="stylesheet" title="Basic TEI style" type="text/css" />
	
		<xhtml:script type="text/javascript" src="scripts/prototype.js"></xhtml:script>
		<xhtml:script type="text/javascript" id="scriptaculous" src="scripts/effects.js"></xhtml:script>
		<xhtml:script type="text/javascript" src="scripts/handlers.js"></xhtml:script>
	</xhtml:head>


	<xhtml:body onload="init()">
		<xhtml:div id="main">
			<c:import url="xsl/preprocess.xsl" var="preprocessxsl" />
			<x:transform doc="${poemxml}" xslt="${preprocessxsl}" />
		</xhtml:div>
		<xhtml:div id="utils">
			<xhtml:a id="togglestress" class="on" onclick="togglestress();">Hide stresses</xhtml:a>
			</xhtml:div>
	</xhtml:body>
	</xhtml:html>
</jsp:root>