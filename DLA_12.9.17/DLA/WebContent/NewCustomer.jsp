<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<jsp:include page="header.jsp"></jsp:include>
<link rel="stylesheet" href="mycss.css" type="text/css" media="screen">
<script type="text/javascript" src="DLANewCustomer.js"></script>
</head>
<body onload ="populateOptionList();" onchange="popTextArea();">
	<form name="newCustomer" method="POST" onsubmit="return(validate());" >
	<a href="NewClientName.jsp">BACK</a>
<div class="newcustform">
<div>
	<table> 
		<tr>
			<td>Environment :</td>
			<td><select name="environment"  id="env" onchange="environmentType();">
										<option value="">Select Type</option>
										<option value="Virtual">Virtual Environment</option>
										<option value="Physical">Physical Environment</option>
										<option value="AWS">AWS Environment</option>
				</select>
			</td>
		</tr>
		<tr>						  
 			<td><input type="radio" name="envType" value="prod" id="prodEnv" >Production</td><td><input type="radio" name="envType" value="nonprod" id="nonprodEnv" >Non-Production</td> 
		</tr>
	</table>
</div>
	<div id="division1" style="display:none">
		<table>
			<tr>
				<td>vCPU No :</td><td><input type="text" placeholder = "vCPUNo" name="vCPUCount" id="vCPU" onkeypress="return isNumber(event)" onchange="calcCpuLicCount();"></td></tr>
				<tr><td>Hyper Threading :</td><td><input type="radio" name="hyperThread" value="enabled" id="enableHT" onchange="calcCpuLicCount();">Enabled<input type="radio" name="hyperThread" value="Disabled" id="disableHT" onchange="calcCpuLicCount();">Disabled</td>
			</tr>
		</table>
	</div>
	
	<table>
		<tr>
			<td>Operating System :</td><td><select name="oSystem"  id="os">
										   <option>Select Type</option>
 									  		   </select></td>
		</tr>
	</table>						
	<div id="division2" style="display:none">
		<table>
			<tr>
				<td>CPU Type :</td><td><select name="cpuType"  id="cpu" onchange="calcMulFactor();" >
							   		   <option value="">Select Type</option>
		   					           </select></td></tr>
					<tr><td>Multiplication Factor :</td><td name="mulFactor" id="mulFactor"></td></tr>
				
				<tr><td>Core :</td><td><input type="text" placeholder = "No. Of Cores" name="core" id="core" onkeyup="calcCpuLicCount();" onkeypress="return isNumber(event)"/></td>
							
			</tr>
		</table>
	</div>
	<table>
		<tr>			
			<td>CPU License Count :</td><td  name="licenceCount" id="licenceCount"  ></td></tr>
			<tr><td>No Of DB Servers :</td> <td><input type="text" placeholder = "No. Of Servers" name="dbServersCount" id="dbno" onkeypress="return isNumber(event)"/></td>
		</tr>
		<tr>
			<td> License Type :</td><td><select name="lic_type"  id="licence" onchange="calcProdPrice();" >
											<option>Select Type</option>
											<!-- <option value="User">User  </option>
											<option value="Processor">Processor  </option> -->
										  </select></td></tr>	
			
			<tr><td>Database Product :</td> <td><select name="dbProduct"  id="dbproc" onchange="calcProdPrice();" required>
											  	<option>Select Type</option>
									          </select></td></tr>
									          
							          
			<tr><td>Product price :</td><td><input type="text" placeholder = "Product Version Price" name="prodPrice" id="prodPrice" readonly></td>
		</tr>
	</table> 

<div class="dbInfo" id="div2">	
<table>
	<tr>
		<td>Options Installed :	</td>
		<td><textarea name="options" id="txarea" rows="15" cols="60" readonly ></textarea></td>
	</tr>
</table>
</div>
<div id="div4" style="display:none">
		<table>
			<tr>
				<td>Product Support Cost :</td><td><input type="text" name = "ProdSuppCost" id = "prodSuppCost"></td>
				<td>Options Support Cost :</td><td><input type="text" name= "OptionSuppCost" id= "optSuppCost"></td>
			</tr>
		</table>
</div>
<div class="calcInfo" id="div3">
	<table>
	<tr></tr>
		<tr>
			<td>Total Cost :</td><td><input type="text" placeholder = "Total Cost" name="totalCost" id="totalCost" /></td>
		</tr>
	</table>
	<input type="submit" value="Add New" onclick="form.action='SecondServlet';">
	<input type="submit" value="Generate Report" onclick="form.action='FirstServlet';">
</div>
<br>
</div>

</form>
</body>
</html>