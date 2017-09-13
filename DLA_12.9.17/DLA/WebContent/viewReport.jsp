<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
   <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${clientName}</title>
<link rel="stylesheet" href="mycss.css" type="text/css" media="screen">
<jsp:include page="header.jsp"></jsp:include>
</head>
<body>
<c:choose>
<c:when test="${fn:length(sessionScope.finalMap) gt 0}">
   <center><h2>
	License Report for ${clientName}<br></h2>
	<div class="mainDiv">
		<div class="reportDiv">
			<table>
			<c:set var="count" value="1" scope="page" />
				<tr>
					<th>SrNo</th>
					<th>Instance Name</th>
					<th>View Report</th>
					
				</tr>
			<c:forEach items="${sessionScope.finalMap}" var="entry">
			<tr>
				<td>${count}</td>
				<td>${fn:toUpperCase(entry.key)}</td>
				<td><a href="report.jsp?dbname=${entry.key}">View Report</a> </td>
				<c:set var="count" value="${count + 1}" scope="page"/>
			</tr>
	    		
			</c:forEach>
			</table>
		</div>
	</div>
	<br><br>
	<h4>Click <a href="consolidatedReport.jsp">here</a> to view consolidated report.<br>
	You can view your extracted data at the location : "D:/DLA/licenseReport/${clientName}"<br>
	You can download the updated inventory file <a href=<%= session.getAttribute("file") %>>here</a> 
	</h4><br>
			<input type="button" value="Try Again" onClick="document.location.href='uploadExcel.jsp'"/> 
	</center>
	</c:when>
	<c:otherwise>
		<center><h2>
		<br>
		Could not fetch data.. !!!
		<br>
		Please ensure details entered are correct. Read the pre-requisites <a href="prereq.jsp">here.</a></h2><br></center>
		<div class="customer">
		<br>
			<input type="button" value="Try Again" onClick="document.location.href='uploadExcel.jsp'"/> 
		</div>
	</c:otherwise>
</c:choose>
<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>