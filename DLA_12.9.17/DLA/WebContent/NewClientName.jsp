<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Welcome ${sessionScope.name }</title>
<link rel="stylesheet" href="mycss.css" type="text/css" media="screen">
<jsp:include page="header.jsp"></jsp:include>
<script type="text/javascript" src="DLANewCustomer.js"></script>
</head>
<body>
<a href="customer.jsp">BACK</a>
	<form name="clientDetails" action="NewCust"  method="POST">
		<div class="clientName" id="div1">
			<table>
			<tr>
				<th>Client Name :</th>
				<td><input type="text" placeholder = "ENTER CLIENT NAME" name="clientName" /></td>
			</tr>
			</table>
			<input type="submit" value="Proceed" >
		</div>
	</form>
</body>
</html>