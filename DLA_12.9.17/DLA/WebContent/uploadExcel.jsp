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

	<!-- <div class="logout">
<a href="logout">LogOut</a>
</div> -->
	<form action="calculateReport" name="Welcome"
		enctype="multipart/form-data" method="post" id="upload"
		onsubmit="return Validate(this);">

		<div class="uploadExcel">
			
			<table>
				<tr>
					<td>Client Name :</td>
					<td><input type="text" placeholder="ENTER CLIENT NAME"
						name="clientName" required oninput="setCustomValidity('')"
						oninvalid="this.setCustomValidity('Please Enter valid clientName')" />
					</td>
				</tr>
				<tr>
					<td>License Type :</td>
					<td><select name="licType" required
						oninput="setCustomValidity('')"
						oninvalid="this.setCustomValidity('Please select license type')" />
						<option selected="selected" value="">License Type</option>
						<option value="named">User</option>
						<option value="cpu">Processor</option> </select></td>
				</tr>
				<tr>
					<td>Purpose :</td>
					<td><textarea rows="4" cols="30" name="purpose" style="font-family:Arial"
							placeholder="ENTER SOME PURPOSE"></textarea></td>
				</tr>
				<tr>
					<td>Upload Inventory :</td>
					<td><input type="file" name="inventory" title="Select File"
						accept=".xlsx" required oninput="setCustomValidity('')"
						oninvalid="this.setCustomValidity('It is mandatory to Upload a File')" /></td>
				</tr>
				<tr>
					<td>Sudo Username :</td>
					<td><input type="text" placeholder="ENTER SUDO USER"
						name="sudoUser" required oninput="setCustomValidity('')"
						oninvalid="this.setCustomValidity('Please Enter valid OS user')" /></td>
				</tr>
				<tr>
					<td>Sudo Password :</td>
					<td><input type="password" placeholder="ENTER SUDO PASSWORD"
						name="sudoPass" required oninput="setCustomValidity('')"
						oninvalid="this.setCustomValidity('Please Enter valid OS password')" /></td>
				</tr>
				<tr>
					<td>DB Username :</td>
					<td><input type="text" placeholder="ENTER DB USER"
						name="dbUser" required oninput="setCustomValidity('')"
						oninvalid="this.setCustomValidity('Please Enter valid database user')" /></td>
				</tr>
				<tr>
					<td>DB Password :</td>
					<td><input type="password" placeholder="ENTER DB PASSWORD"
						name="dbPass" required oninput="setCustomValidity('')"
						oninvalid="this.setCustomValidity('Please Enter valid database password')" /></td>
				</tr>
			</table>
			<input type="submit" value="Upload" id="submit" />
			<!--for validating .xlsx file it will call validate() of loading.js and for other it will redirect to calculatereport.java-->

			</td>
			<center>
				<div id="loading2" style="display: none; margin-top: 16px;">
					<img src="images/page-loader.gif" height="45px" width="45px" />
				</div>
			</center>
		</div>

	</form>

	<jsp:include page="footer.jsp"></jsp:include>
</body>
</html>