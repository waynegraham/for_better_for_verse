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

	<html >
	<head>
		<meta http-equiv="Content-Type" content="text/html" />
		<title id="title">
			<c:out value="${param.poem}" />
		</title>
		<link href="css/main.css" rel="stylesheet" title="Basic TEI style" type="text/css" />
		<link href="css/ie.css" rel="stylesheet" title="IE hacks" type="text/css" />
		<script type="text/javascript">debugflag=false;</script>
		<script type="text/javascript" src="http://www.prototypejs.org/assets/2009/3/27/prototype.js"><!--this--></script>
		<script type="text/javascript" id="scriptaculous" src="scripts/effects.js"><!--this--></script>
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
