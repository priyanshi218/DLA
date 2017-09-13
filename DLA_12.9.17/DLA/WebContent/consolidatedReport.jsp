<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>

<style>
body { 
	background-image: url("images/backgroundImage1.jpg");
    background-repeat: no-repeat;
    height: 500px; 
    background-attachment: fixed;
    background-position: center;
    background-size: cover;}
.consreport{
	
	margin: 40px auto;
	width : inherit;
	border-style: inset;
	border-width: 0.5px;
}
.title
{
	font-size:xx-large;
	text-align: center;
   color: #214695; 
   margin: 5px auto;
}
h4{
	font-size: 19px;
	text-align: center;
   color: black; 
   font-weight: 500;
   font-family: Arial;
   
}
h1{
  background-color: powderblue;
  color: #214695;
  display: block;
  height: 43px;
  font: 1000 14px/1 'Arial', Arial;
  padding-top: 3px;
}
.innertable
{
	margin: 10px auto;
	width : inherit;
}
tr
{
	border: 1;
}

td,th{
	
	padding: 10px 30px;
	text-align: center;
	background-color: powderblue;
	font-family:Arial;
 	font-size:16px;
  	font-weight:500;
}
.mainDiv
{
	margin: 20px auto;
	display: flex;
}
th{
	font-size:20px;
	
	text-align: center; 
	font-weight:bold;
}
.reportDiv
{
	margin : 0px auto;
	float:left;
	height: auto;
}

#downloadBtn{
	margin-right: 270px;
	float: right;
	
}
#backBtn{
margin-left:270px;
	float: left;
	
}
</style>
</head>
<body>
<a href="viewReport.jsp">BACK</a>
<div class="mainDiv">

<div class="reportDiv">

<h3 class="title"><center>${clientName}</center></h3>
	<table class="consreport">
	<c:set var="count" value="1" scope="page" />
	<c:set var="total" value="0" scope="page" />
		<tr>
			<th>Sr.No</th>
			<th>Database Name</th>
			<th>MachineName</th>
			<th>OptionsInstalled-SupportCost</th>
			<th>Total Cost ($)</th>
		</tr>
		<c:forEach items="${finalMap}" var="entry">
		<c:set var="dbname" value="${entry.key}" scope="page" />
			 
			 <tr>
			 <td>${count}</td>
			 <td>${dbname}</td>
			 <td>${finalMap[dbname][0].machineName}</td>
			 <c:set var="dbtotal" value="${finalMap[dbname][0].productCost}" scope="page" />
			 <td><table class="innertable">
			 <c:forEach items="${entry.value}" var="options">
			 	<c:if test="${options.currentStatus == 'USED'}">
			 				<tr>
							<td>${options.optionName} - ${options.supportCost}</td></tr>
							<c:set var="dbtotal" value="${dbtotal + options.supportCost}" scope="page"/>
						</c:if>
			 </c:forEach>
			 <c:set var="dbtotal" value="${dbtotal*finalMap[dbname][0].licCount}" scope="page"/>
			 <c:set var="count" value="${count + 1}" scope="page"/>
			 </table>
			 	</td>
			 	<td>${dbtotal}</td>
			 	<c:set var="total" value="${total+dbtotal}" scope="page" />
			 </tr>
		</c:forEach>
	</table>
	<center><h4><b>Total cost ($) : ${total} $</b></h4>
	<h4><b>Observation :</b> During Oracle installation, all the components which are licensed under 'Enterprise Edition' get installed by default.<br> 
 		<b>Recommendation :</b> Depending on the functionality, need to enable or disable the specific component functionality at the binary level.
	</h4></center>
	</div>
	</div>
</body>
</html>