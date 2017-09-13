<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript" src="DLANewCustomer.js"></script>
<link rel="stylesheet" href="mycss.css" type="text/css" media="screen">
<style>
/* body { background-image: radial-gradient( cover, rgba(92,100,111,1) 0%,rgba(31,35,40,1) 100%) } */

table{
	text-align: center;
	margin: 0 70px;
	width : 80%;
}
 
h5{
	font-size:large;
	text-align: center;
	background-color: silver;
	
} 
 td{
	
	/* border-style: solid;
	border-color: black; */
	padding: 10px;
	text-align: center;
	width: auto;
	background-color: powderBlue;
} 
th{
	color: black;
	padding: 10px;
	text-align: center;
	width: auto;
	background-color: powderBlue;
	
}
tr{
border: 1;
border-color: black;
}


h1{
	
background-image: linear-gradient(top, #f1f3f3, #d4dae0);
  color: #727678;
  display: block;
  height: 43px;
  font: 1000 14px/1 'Open Sans', sans-serif;
  padding-top: 3px;
	
}	

</style>
</head>
<body>
<a href="customer.jsp">BACK</a>
 <form>
  
  <div class="clientInfo">
  	<center><h4><b>Client Name : </b>${sessionScope.cname}</h4></center>
  </div>                            
 <div class="dbInfo">
 

  <table>
  	<tr><th>Sl No.</th>
  	    <th>Operating System</th> 
  	    <th>Environment</th>
  	    <th>No Of Servers</th>
  	    <th>Database Product</th>
  	    <th>Product Price</th>
  	    <th>Options</th>
  	    <th>Total Cost</th>
  	</tr>
  	<tr></tr>
  	<tr></tr>
  	<c:set var="count" value="1" scope="page" />
  	<c:set var="y1cost" value="0" scope="page" />
  	<c:set var="y2cost" value="0" scope="page" />
  	<c:set var="y3cost" value="0" scope="page" />
  	<c:forEach items="${dbList}" var="tmp0">
	   <tr>
		<td>${count}</td>
		<td>${tmp0.operatingSystem}</td>
		<td>${tmp0.environment}</td>
		<td>${tmp0.dbNo}</td>
		<td>${tmp0.prodType}</td>
		<td>${tmp0.prodPrice}</td>
		<td>
		<table>
		<tr>
		<th>Name</th>
		<th>Price</th>
		</tr>
		<c:set var="i" value="0" scope="page" />
		<c:forEach items="${tmp0.optInstalled}" var="tmp1">
			<tr>
				<td>${tmp1}</td>
				<td>${tmp0.optCost[i]}</td>
				<c:set var="i" value="${i + 1}" scope="page"/>
			</tr>
		</c:forEach>
		</table>
		</td>
		
		<td>${tmp0.totPrice}</td>
	   </tr>
	   <c:set var="count" value="${count + 1}" scope="page"/>
	   <c:set var="y1cost" value="${y1cost + tmp0.totPrice}" scope="page" />
	   <c:set var="y2cost" value="${y2cost + tmp0.prodSuppCost +tmp0.optSuppCost}" scope="page" />
	   <c:set var="y3cost" value="${y3cost + tmp0.prodSuppCost +tmp0.optSuppCost}" scope="page" />
	  </c:forEach>
	
</table>
<hr/>
    Total Cost :<table>
    <tr><th>Year 1 cost :</th><td id="y1cost"> ${y1cost}</td></tr>
    <tr><th>Year 2 cost :</th><td> ${y2cost}</td></tr>
    <tr><th>Year 3 cost :</th><td> ${y3cost}</td></tr>
    			</table>
    **Capgemini Discounted Cost :<table>
    <tr><th>Discount Rate :</th><td><select name="discountRate"  id="discRate" onchange="calcDiscCost();">
										<option value="">Select Type</option>
										<option value="10">10 %</option>
										<option value="20">20 %</option>
										<option value="30">30 %</option>
										<option value="40">40 %</option>
										<option value="50">50 %</option>
										<option value="60">60 %</option>
										<option value="70">70 %</option>
									  </select></td></td></tr>
									  <tr><th>Discounted year 1 cost : </th><td id="discounted"></td>
    
    			</table>
 
<!--   <h4><a href="javascript:doit()">Save to PDF</a></h4> -->
  <h6>** The Discount is given by the Capgemini Procurement Team </h6>
<!-- 	<h4><a href="http://www.web2pdfconvert.com/convert">Save to PDF</a></h4> -->
 </div>
</form>
</body>
</html>