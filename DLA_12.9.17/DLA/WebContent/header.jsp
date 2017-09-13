<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style>

.header {
	position: absolute;
	top: calc(11% - 35px);
	left: calc(55% - 255px);
	z-index: 2;
}

.header div {
	float: left;
	color: #214695;
	font-family: 'Exo', Arial;
	font-size: 38px;
	font-weight: 200;
}


.header1 {
	position: absolute;
	top: calc(-7% - 35px);
	left: calc(25% - 255px);
	z-index: 2;
}
.header2 {
	position: absolute;
	top: calc(11% - 35px);
	left: calc(115% - 255px);
	z-index: 2;
}
p.test {
	margin-top: 11px;
	margin-left: -10px;
	font-size: 12px;
	font-family: serif;
	font-weight: bold;
}
.black
{
  	
    border: 1px solid black;
    opacity: 0.1;
  

}

</style>

</head>
<body>


	<div>
	
	<div class="black">
	<img id="logo1" src="images/black.jpg" width="1120px" height="100px"/>
	</div>
	
	<div class="header1">
		<img id="logo" src="images/header1.png" width="300px" height="280px" alt="logo" />
	</div>
	

	<div class="header">
			<div>Database License Assessment</div>
	</div>
		<div class="header2">
	<%
	if (session.getAttribute("name") != null) {
	%>
		<a href="logout"><img src="images/logout.png" width="30px" height="30x" alt="logout"/></a>
		<a href="logout"><p class="test">LOGOUT</p></a>
	<%} 
	else {%>
		<a href="README.jsp"><img src="images/README.png" width="30px" height="30x" alt="README"/></a>
		<a href="README.jsp"><p class="test">README</p></a>
	<%}%>
		</div>
	</div>
</body>
</html>