<%--This is the first page which takes parameters like username & Password and pass it to myLogin servlet  --%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>DLA</title>

<style>
body {
	margin: 0;
	padding: 0;
	background: #fff;
	color: #fff;
	font-family: Arial;
	font-size: 12px;
}

.body {
	position: absolute;
	top: -20px;
	left: -20px;
	right: -40px;
	bottom: -40px;
	width: auto;
	height: auto;
	background-image: url("images/backgroundImage.jpg");
	background-size: cover;
	-webkit-filter: blur(5px);
	z-index: 0;
}

.grad {
	position: absolute;
	top: -20px;
	left: -20px;
	right: -40px;
	bottom: -40px;
	width: auto;
	height: auto;
	background: -webkit-gradient(linear, left top, left bottom, color-stop(0%, rgba(0, 0
		, 0, 0)), color-stop(100%, rgba(0, 0, 0, 0.65)));
	/* Chrome,Safari4+ */
	z-index: 1;
	opacity: 0.7;
}

.header {
	position: absolute;
	top: calc(50% - 35px);
	left: calc(30% - 255px);
	z-index: 2;
}

.header div {
	float: left;
	color: #fff;
	font-family: 'Exo', sans-serif;
	font-size: 38px;
	font-weight: 200;
}

.header1 {
	position: absolute;
	top: calc(5% - 35px);
	left: calc(25% - 255px);
	z-index: 2;
}

.error {
	position: absolute;
	top: calc(70% - 40px);
	left: calc(90% - 260px);
	z-index: 2;
}

footer {
	position: absolute;
	top: calc(97% - 35px);
	left: calc(25% - 255px);
	height: 20px;
	width: 100%;
	margin: -5px auto;
	margin-bottom: -5px;
	background-color: #333333;
}

p.copyright {
	position: absolute;
	width: 100%;
	color: #fff;
	line-height: 1px;
	font-size: 1.0em;
	text-align: center;
	bottom: 0;
}

.header div span {
	color: #5379fa !important;
}

.login {
	position: absolute;
	top: calc(50% - 75px);
	left: calc(66% - 50px);
	height: 150px;
	width: 350px;
	padding: 10px;
	z-index: 2;
}

.login input[type=text] {
	width: 250px;
	height: 30px;
	background: transparent;
	border: 1px solid rgba(255, 255, 255, 0.6);
	border-radius: 2px;
	color: #fff;
	font-family: 'Exo', sans-serif;
	font-size: 16px;
	font-weight: 400;
	padding: 4px;
}

.login input[type=password] {
	width: 250px;
	height: 30px;
	background: transparent;
	border: 1px solid rgba(255, 255, 255, 0.6);
	border-radius: 2px;
	color: #fff;
	font-family: 'Exo', sans-serif;
	font-size: 16px;
	font-weight: 400;
	padding: 4px;
	margin-top: 10px;
}

.login input[type=submit] {
	width: 260px;
	height: 35px;
	background: #fff;
	border: 1px solid #fff;
	cursor: pointer;
	border-radius: 2px;
	color: #a18d6c;
	font-family: 'Exo', sans-serif;
	font-size: 16px;
	font-weight: 400;
	padding: 6px;
	margin-top: 10px;
}

.login input[type=submit]:hover {
	opacity: 0.8;
}

.login input[type=submit]:active {
	opacity: 0.6;
}

.login input[type=text]:focus {
	outline: none;
	border: 1px solid rgba(255, 255, 255, 0.9);
}

.login input[type=password]:focus {
	outline: none;
	border: 1px solid rgba(255, 255, 255, 0.9);
}

.login input[type=submit]:focus {
	outline: none;
}

::-webkit-input-placeholder {
	color: rgba(255, 255, 255, 0.6);
}

::-moz-input-placeholder {
	color: rgba(255, 255, 255, 0.6);
}
</style>
</head>

<body>

	<div class="header1">
		<img id="logo" src="images/header1.png" width="300px" height="280px"
			alt="logo" />
	</div>

	<form action="myLogin" method="post">   

		<div class="error">
			<c:if test="${loginResult}">
				<p style="color: red">Login Failed. Enter valid credentials.</p>
			</c:if>

			<c:if test="${timeout}">
				<p style="color: red">Session expired. Please login again.</p>
			</c:if>
		</div>



		<div class="body"></div>
		<div class="grad"></div>
		<div class="header">
			<div>Database License Assessment</div>
		</div>
		<br>

		<div class="login">
			<input type="text" placeholder="username" name="username" required
				oninput="setCustomValidity('')"
				oninvalid="this.setCustomValidity('Please Enter valid username')"><br>
			<input type="password" placeholder="password" name="password"
				required oninput="setCustomValidity('')"
				oninvalid="this.setCustomValidity('Please Enter valid Password')"><br>
			<input type="submit" value="Sign In">
		</div>

	</form>



	<footer>
		<p class="copyright">@Confidential and for internal use only.
			Copyright ©2017. All rights reserved.</p>
	</footer>

</body>

</html>