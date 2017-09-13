<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Welcome ${sessionScope.name }</title>
<link rel="stylesheet" href="mycss.css" type="text/css" media="screen">
<jsp:include page="header.jsp"></jsp:include>
<script src="Scripts/loading.js" type="text/javascript"></script>
</head>
<body>
	<div class="myreadme">
	<ul style="list-style-type:circle">
	<li>The inventory file must have three mandatory columns 'MachineName' , 'OperatingSystem' and 'Flag'.</li>
	<li>Check the usernames and passwords you entered.</li>
	<li>The path 'D:\DLA\LicenseReport' must exist.</li>
	<li>The file masterTables.xls must exist in the path D:\DLA</li>
	<li>Check the logs generated in 'D:\DLA\LicenseReport\[ClientName]'.</li>
	</ul>
	</div>
	<div class="customer">
		<br>
			<input type="button" value="Back" onClick="document.location.href='viewReport.jsp'"/> 
		</div>
</body>
</html>