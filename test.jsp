<?xml version="1.0" encoding="UTF-8" ?>
<jsp:root xmlns:jsp="http://java.sun.com/JSP/Page" version="2.0"
	>
	<prosody:response xmlns:prosody="http://www.prosody.com" xmlns:x="http://java.sun.com/jsp/jstl/xml"
		xmlns:c="http://java.sun.com/jsp/jstl/core">
		<c:import url="poems/${param.poem}" var="poem" />
						<x:parse doc="${poem}" var="poem-xml" />
		<c:out value="${poem-xml}" />





	</prosody:response>

</jsp:root>