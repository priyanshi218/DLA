<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Welcome ${sessionScope.name }</title>
<jsp:include page="header.jsp"></jsp:include>

<link rel="stylesheet" href="mycss.css" type="text/css" media="screen">

<script src="Scripts/loading.js" type="text/javascript"></script>
</head>
<body>
	<div id="container">
		<div id="mainContent">
			<div class="customer">
				<br>
				<!-- <input type="radio" name="dbtype" value="oracle" /> Oracle
			<br>
			<input type="radio" name="dbtype" value="sqlserver" /> SQL Server
			<br> -->
				<input type="button" value="New Customer"
					onClick="document.location.href='NewClientName.jsp'" /> <br> <!-- Redirect to NewClientName.jsp  -->
				<input type="button" value="Existing Customer"
					onClick="document.location.href='uploadExcel.jsp'" />		 <!-- Redirect to uploadExcel.jsp  -->
		
			</div>
				
		</div>
	
		</div>	
			<jsp:include page="footer.jsp"></jsp:include>
</body>

</html>