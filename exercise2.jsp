<?xml version="1.0" encoding="ISO-8859-1" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
	xmlns:prosody="http://staging.prosody.lib.virginia.org"
	xmlns:x="http://java.sun.com/jsp/jstl/xml"
	xmlns:c="http://java.sun.com/jsp/jstl/core"
	xmlns:TEI="http://www.tei-c.org/ns/1.0"
	xmlns="http://www.w3.org/1999/xhtml">
	
	<jsp:directive.page language="java" contentType="text/html" />
	

	<c:import url="poems/${param.poem}" var="poem" />
	<x:parse doc="${poem}" var="poemxml" />
	
	<c:import url="xsl/prosody.xsl" var="preprocessxsl" />
	<x:transform doc="${poemxml}" xslt="${preprocessxsl}" />
	
</jsp:root>
