<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="mycss.css" type="text/css" media="screen">
<jsp:include page="header.jsp"></jsp:include>
<title>Insert title here</title>
</head>
<body>

<div class="myreadme">
Database licensing is a time consuming task which can lead to serious financial penalties if not done right.  This tool makes it easy to calculate the licensing cost of database servers just by providing minimal inputs. 
	Broadly, the following objectives are achieved using the DATABASE LICENSE ASSESSMENT (DLA) tool-
	<ol>
	<li>To avoid unexpected licensing liabilities on high-cost products</li>
	<li>Identify Software license and maintenance pricing issues</li>
	<li>Proactively identify current License Utilization</li>
	<li>To Provide insight information for options installed</li>
	<li>To Provide insight for Names user License cost</li>
	<li>To Provide insight information for process based License cost</li>
	<li>To identify support cost based on option installed </li>
	<li>To generate reports in PDF format with required information</li>
	<li>Evaluates ball parking cost for License requirement</li>
	</ol>
This tool will help in significantly improving customers operational capabilities. Customers that optimized licensing in their environments will get better Return On Investment. Customers will also be benefited in reducing the support cost by license consolidation based on option installed.
make sure you fulfill these prerequisites before running this tool.
	<ol>
	<li>The inventory file must have three mandatory columns 'MachineName' , 'OperatingSystem' and 'Flag'.</li>
	<li>Check the usernames and passwords you enter.</li>
	<li>The path 'D:\DLA\LicenseReport' must exist.</li>
	<li>The file masterTables.xls must exist in the path D:\DLA</li>
	<li>Check the logs generated in 'D:\DLA\LicenseReport\[ClientName]'.</li>
	<li>You can check the data extracted for each client generated in 'D:/DLA/LicenseReport/[ClientName]'.</li>
	</ol>
</div>
</body>
</html>