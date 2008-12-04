<?xml version="1.0" encoding="ISO-8859-1" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
	xmlns:prosody="http://www.prosody.com"
	xmlns:x="http://java.sun.com/jsp/jstl/xml"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:TEI="http://www.tei-c.org/ns/1.0">
	<jsp:directive.page language="java"
		contentType="text/xml"/>
	<jsp:output omit-xml-declaration="false" doctype-root-element="html"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<c:import url="poems/${param.poem}" var="poem" />
	<x:parse doc="${poem}" var="poemxml" />

	<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	<meta http-equiv="Content-Type" content="text/html" />
	<title><x:out select="$poemxml//titleStmt/title" /></title>
	<link href="css/main.css" rel="stylesheet" title="Basic TEI style" type="text/css"/>
	<script type="text/javascript" src="scripts/handlers.js"></script>
	</head>
	
	
	<body>
	
	<c:import url="xsl/preprocess.xsl" var="preprocessxsl" />
	<x:transform doc="${poemxml}" xslt="${preprocessxsl}"/>

	</body>
	</html>
</jsp:root>