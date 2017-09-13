<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<jsp:include page="header.jsp"></jsp:include>
<script>
	function doit() {
		window.print();
	}
</script>
<style>
body {
	background-image: url("images/backgroundImage1.jpg");
	background-repeat: no-repeat;
	height: 500px;
	background-attachment: fixed;
	background-position: center;
	background-size: cover;
}

.consreport {
	margin: 40px auto;
	width: inherit;
	border-style: inset;
	border-width: 0.5px;
}

.innertable, table {
	margin: 0 auto;
	width: inherit;
}

h3 {
	font-size: xx-large;
	text-align: center;
	color: #214695;
	background-color: powderblue;
}

h4 {
	font-size: 17px;
	text-align: center;
	color: #214695;
	font-weight: 500;
	font-family: Arial;
}

h1 {
	background-image: linear-gradient(top, #f1f3f3, #d4dae0);
	color: #727678;
	display: block;
	height: 43px;
	font: 1000 14px/1 'Arial', Arial;
	padding-top: 3px;
}

td, th {
	padding: 10px 30px;
	text-align: center;
	background-color: powderblue;
	font-family: Arial;
	font-size: 17px;
	font-weight: 500;
}

.mainDiv {
	margin-left: 10px;
	margin-top: 4px;
	display: flex;
}

th {
	font-size: 23px;
	color: #214695;
	text-align: center;
}

.reportDiv {
	float: left;
	width: auto;
	height: auto;
}

#backBtn {
	margin-left: 270px;
	float: left;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>${dbname}</title>

</head>
<body>
	<c:set var="dbname" value="<%=request.getParameter(\"dbname\")%>" />
	<c:set var="count" value="2" scope="page" />
	<c:set var="total" value="0" scope="page" />
	<c:set var="total" value="${total + finalMap[dbname][0].productCost}"
		scope="page" />
	<div class="mainDiv">
		<div class="reportDiv">
			<h4>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"${dbname}"
				as on
				<%=new java.util.Date()%>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				
				<a href="viewReport.jsp">BACK</a>
			</h4>
			<table>
				<tr>
					<th>SrNo</th>
					<th>Option Name</th>
					<th>Current Status</th>
					<th>Last Used</th>
					<th>Support Cost ($)</th>
				</tr>
				<tr>
					<td>1</td>
					<td>${finalMap[dbname][0].prodType }Edition</td>
					<td>USED</td>
					<td>-</td>
					<td>${finalMap[dbname][0].productCost}</td>
				</tr>
				<c:forEach items="${finalMap[dbname]}" var="options">
					<tr>
						<c:set var="licCount" value="${options.licCount}" scope="page" />
						<td>${count}</td>
						<td>${options.optionName}</td>
						<td>${options.currentStatus}</td>

						<c:if test="${options.currentStatus == 'USED'}">
							<c:set var="total" value="${total + options.supportCost}"
								scope="page" />
						</c:if>
						<td>${options.lastUsed}</td>
						<c:if test="${options.currentStatus == 'USED'}">
							<td>${options.supportCost}</td>
						</c:if>
						<c:if test="${options.currentStatus == 'NOT USED'}">
							<td>*</td>
						</c:if>

					</tr>
					<c:set var="count" value="${count + 1}" scope="page" />
				</c:forEach>
				<c:set var="total" value="${total * licCount}" scope="page" />
			</table>
			<h4>Total Support Cost :  ${total} $  &   CPU Licenses Count : ${licCount}</h4>
			<h5>
				<center>Note: The support cost for the option that are 'NOT
					USED' is not being shown here.</center>
			</h5>
			<h4>
				<a href="javascript:doit()">Save to PDF</a>
			</h4>
		</div>
	</div>
	</div>

</body>
</html>