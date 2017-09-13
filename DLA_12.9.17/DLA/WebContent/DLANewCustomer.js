/**
 * 
 */

var excel = new ActiveXObject("Excel.Application");
var cpudata = [];
var mul_factor = [];
var osdata = []; 
var productdata = [];
var prod_user = [];
var prod_usersupp = [];
var prod_proc = [];
var prod_procsupp = [];
var optiondata = [];
var option_user = [];
var option_usersupp = [];
var option_usertotal = [];
var option_proctotal = [];
var option_proc = [];
var option_procsupp = [];
var excel_file = excel.Workbooks.Open("D:\\DLA\\masterTables.xls");


/**
 * This Function is for validation of the Client Name Field
 */

function clientNameValidate() 
{
	if( document.clientDetails.clientName.value == "" )
	   {
	      alert( "Please provide Client name!" );
	      document.clientDetails.clientName.focus() ;
	      return false;
	   }
	else
	{
		return(true);
	}
}



   
/**
 *  
 */
function createOption(id, text, value) 
{
	var opt = document.createElement('option');
	opt.value = value;
	opt.text = text;
	id.options.add(opt);
}



/**
 *  
 */
function cpuReadFromExcel()
{
  var excel_sheet = excel_file.Worksheets("CpuType");
  var i=2;
  while((excel_sheet.Cells(i,2).Value)!= null)
  	{
	  cpudata.push(excel_sheet.Cells(i,2).Value);
	  i++;
  	}
  for (j=0;j<cpudata.length;j++)
  {
  	createOption(document.getElementById("cpu"), cpudata[j], cpudata[j]);
  }
  var k=2;
  while((excel_sheet.Cells(k,3).Value)!= null)
	{
	  mul_factor.push(excel_sheet.Cells(k,3).Value);
	  k++; 
	}
}







/**
 *  
 */
function osReadFromExcel()
{
   var excel_sheet = excel_file.Worksheets("OSDetails");
   var i=2;
   while((excel_sheet.Cells(i,2).Value)!= null)
   	{
 	  osdata.push(excel_sheet.Cells(i,2).Value);
 	  i++;
   	}
   
   for (j=0;j<osdata.length;j++)
   {
   	createOption(document.getElementById("os"), osdata[j], osdata[j]);
   }

}



/**
 *  
 */
function productReadFromExcel()
{
   var excel_sheet = excel_file.Worksheets("ProdInstalled");
   var i=2;
   while((excel_sheet.Cells(i,2).Value)!= null)
   	{
 	  productdata.push(excel_sheet.Cells(i,2).Value);
 	  i++;
   	}
   for (j=0;j<productdata.length;j++)
   {
   	createOption(document.getElementById("dbproc"), productdata[j], productdata[j]);
   }
   
   var a=2;
   while((excel_sheet.Cells(a,3).Value)!= null)
 	{
 	  prod_user.push(excel_sheet.Cells(a,3).Value);
 	  a++;
 	}
   var b=2;
   while((excel_sheet.Cells(b,4).Value)!= null)
 	{
 	  prod_proc.push(excel_sheet.Cells(b,4).Value);
 	  b++;
 	}
   
   var c=2;
   while((excel_sheet.Cells(c,5).Value)!= null)
 	{
 	  prod_usersupp.push(excel_sheet.Cells(c,5).Value);
 	  c++;
 	}
   var d=2;
   while((excel_sheet.Cells(d,6).Value)!= null)
 	{
 	  prod_procsupp.push(excel_sheet.Cells(d,6).Value);
 	  d++;
 	}

}



/**
 *  
 */

function optionReadFromExcel()
{
   var excel_sheet = excel_file.Worksheets("OptionInstalled");
   var i=2;
   while((excel_sheet.Cells(i,2).Value)!= null)
   	{
 	  optiondata.push(excel_sheet.Cells(i,2).Value);
 	  i++;
   	}  
   //alert(optiondata);
   var a=2;
   while((excel_sheet.Cells(a,3).Value)!= null)
 	{
 	  option_user.push(excel_sheet.Cells(a,3).Value);
 	  a++;
 	}
   //alert(option_user);
   var b=2;
   while((excel_sheet.Cells(b,4).Value)!= null)
 	{
 	  option_proc.push(excel_sheet.Cells(b,4).Value);
 	  b++;
 	}
   
   var c=2;
   while((excel_sheet.Cells(c,5).Value)!= null)
 	{
 	  option_usersupp.push(excel_sheet.Cells(c,5).Value);
 	  c++;
 	}
   var d=2;
   while((excel_sheet.Cells(d,6).Value)!= null)
 	{
 	  option_procsupp.push(excel_sheet.Cells(d,6).Value);
 	  d++;
 	}
   
     for (var i = 0; i < optiondata.length; ) 
     {
    	var br = document.createElement('br');
    	 for (var r = 0; r < 3; r++)
    	{
          var label = document.createElement('label');
          //var mybr = document.createElement('br');
          var alabel = document.getElementById('div2');
          var last = alabel[alabel.length - 1];
          label.htmlFor = "lbl"+i;
          label.appendChild(Createcheckbox(optiondata[i]));
          label.appendChild(document.createTextNode(optiondata[i]));
          //label.appendChild(mybr);
          document.getElementById('div2').appendChild(label);
          i++;
    	}
    	label.appendChild(br);
          
    }
	return optiondata;
	return option_user;
	return option_usersupp;
	return option_proc;
	return option_procsupp;
}

function Createcheckbox(chkboxid) 
{
    var checkbox = document.createElement('input');
    checkbox.type = "checkbox";
    checkbox.id = chkboxid;
    checkbox.value = chkboxid;
    checkbox.name = "optionsinstall";
    checkbox.onclick ="popTextArea();";

    return checkbox;
}


/**
 *  
 */
function add_optionCost()
{
	for(z=0;z < option_user.length;z++)
	{
		option_usertotal[z] = option_user[z] + option_usersupp[z];
		option_proctotal[z] = option_proc[z] + option_procsupp[z];
	}
}

function populateOptionList()
{
	
	cpuReadFromExcel();
	osReadFromExcel();
	productReadFromExcel();
	optionReadFromExcel();
	add_optionCost();	
}




/**
 *  
 */
function calcMulFactor(){
	var e = document.getElementById('cpu');
	var str = e.options[e.selectedIndex].value;
	for(l=0;l<cpudata.length;l++)
	{
		if(str==cpudata[l])
		{
			document.getElementById('mulFactor').innerHTML=mul_factor[l];
		}
	}
}



function calcProdPrice(){
	var e = document.getElementById('dbproc');
	var str = e.options[e.selectedIndex].value;
	var f = document.getElementById('licence');
	var lictype = f.options[f.selectedIndex].value;
	var prodSupSum = 0;
	
	for(l=0;l<productdata.length;l++)
	{
		if(str==productdata[l])
		{
			if(lictype == 'User')
			{
				document.getElementById('prodPrice').value = prod_user[l] + prod_usersupp[l];
				document.getElementById('prodSuppCost').value =  prod_usersupp[l];
			}
			else if(lictype == 'Processor')
			{
				document.getElementById('prodPrice').value=prod_proc[l] + prod_procsupp[l];
				document.getElementById('prodSuppCost').value =  prod_procsupp[l];
			}
			
		}
	}
}




function calcCpuLicCount()
{
	var e = document.getElementById('mulFactor');
	var f = document.getElementById('core');
	var mulFac = parseFloat(e.innerHTML);
	var core = parseFloat(f.value);
	var environment = document.getElementById('env');
	var vCPU = document.getElementById('vCPU');
	
	if(environment.value == "AWS")
		{
			if(document.getElementById("enableHT").checked)
				{
					document.getElementById('licenceCount').innerHTML= (vCPU.value)/2.0;
					//alert((vCPU.value)/2);
				}
			if(document.getElementById("disableHT").checked)
			{
				document.getElementById('licenceCount').innerHTML= (document.getElementById('vCPU').value);
				//alert((vCPU.value)/2);
			}
			
		}
	else
		{
			document.getElementById('licenceCount').innerHTML=(mulFac*core);
		}
}



/**
 *  
 */
function popTextArea()
{
	var textArea=[];
	var f = document.getElementById('licence');
	var lictype = f.options[f.selectedIndex].value;
	var sum = 0;
	var optSuppSum = 0;
	for(i=0;i<optiondata.length;i++)
	{

	     if( document.getElementById(optiondata[i]).checked==true)
	     {
	    	 if(lictype == 'User')
			 {	    	 
	    		 sum = sum + option_usertotal[i];
	    		 textArea.push(document.getElementById(optiondata[i]).value + " --- $"+option_usertotal[i]);
	    		 
	    		 optSuppSum = optSuppSum + option_usersupp[i];
	       	 }
	    	 
	    	 else if(lictype == 'Processor')
			 {	    	 
	    		 sum = sum + option_proctotal[i];
	    		 textArea.push(document.getElementById(optiondata[i]).value + " --- $"+option_proctotal[i]);
	    		 optSuppSum = optSuppSum + option_procsupp[i];
	    	 }
		}
	     
		var textarea = document.getElementById("txarea");
		textarea.value = textArea.join("\n");
	}
	
	document.getElementById("optSuppCost").value = optSuppSum;
	var totalSum = sum;
	var licCount = parseFloat(document.getElementById('licenceCount').innerHTML);
	var prodPr = parseFloat(document.getElementById('prodPrice').value);
	var dbNum = parseInt(document.getElementById('dbno').value);
	var cores = parseInt(document.getElementById('core').value);
	
	
	if(lictype == 'User')
	 {	
		//var tempTotalCost = ((((totalSum + prodPr)*cores)*dbNum)*25);
		document.getElementById("totalCost").value = ((((totalSum + prodPr)*cores)*dbNum)*25);
		//document.getElementById("totalCost").value = numberWithCommas(tempTotalCost);
		
		/*var tempDiscCost = ((70*tempTotalCost)/100);
		document.getElementById("discCost").value = numberWithCommas(tempDiscCost);*/
	 }
	
	else if(lictype == 'Processor')
	 {	
		//var tempTotalCost = (((totalSum + prodPr)*licCount)*dbNum);
		document.getElementById("totalCost").value = (((totalSum + prodPr)*licCount)*dbNum);
//		document.getElementById("totalCost").value = numberWithCommas(tempTotalCost);
		//document.getElementById("totalCost").value = tempTotalCost;
		
		/*var tempDiscCost = ((70*tempTotalCost)/100);
		document.getElementById("discCost").value = numberWithCommas(tempDiscCost);
		document.getElementById("discCost").value = (tempDiscCost);*/
	 }
}

/*function numberWithCommas(x) {
	
    var parts = x.toString().split(".");
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
}*/




/**
 *  
 */
function validate()
{

   if( document.newCustomer.clientName.value == "" )
   {
      alert( "Please provide Client name!" );
      document.newCustomer.clientName.focus() ;
      return false;
   }
   
   
   if( document.newCustomer.core.value == "" )
   {
      alert( "Please provide No. of Cores" );
      document.newCustomer.core.focus() ;
      return false;
   }
   
   if( document.newCustomer.dbServersCount.value == "" )
   {
      alert( "Please provide No. of DB Servers" );
      document.newCustomer.dbServersCount.focus() ;
      return false;
   }
   return( true );
}

function isNumber(evt) {
    evt = (evt) ? evt : window.event;
    var charCode = (evt.which) ? evt.which : evt.keyCode;
    if (charCode > 31 && (charCode < 48 || charCode > 57)) {
        return false;
    }
    return true;
}




function environmentType()
{   
    var ddl = document.getElementById("env");
    var selectedValue = ddl.options[ddl.selectedIndex].value;
    var licenseType1 = ["User","Processor"];
    var licenseType2 = ["Processor"];

    if (selectedValue == "Virtual" || selectedValue == "Physical")
    {   
    	
    	document.getElementById("division1").style.display = "none";
    	document.getElementById("division2").style.display = "block";
    	
    	document.getElementById('licence').options.length = 0;
    	for (j=0;j<licenseType1.length;j++)
    	  {
    	  	createOption(document.getElementById("licence"), licenseType1[j], licenseType1[j]);
    	  }
    	
    }
    if(selectedValue == "AWS" || selectedValue == "Azure")
    {
    	
       document.getElementById("division1").style.display = "block";
       document.getElementById("division2").style.display = "none";

       document.getElementById('licence').options.length = 0;
       for (j=0;j<licenseType2.length;j++)
	 	  {
	    	   createOption(document.getElementById("licence"), licenseType2[j], licenseType2[j]);
	 	  }
	  
    }
    if(selectedValue == "")
    {
    	
       document.getElementById("division1").style.display = "none";
       document.getElementById("division2").style.display = "none";
       //document.getElementById("hyperThreading").style.display = "block";
    }
}
function calcDiscCost()
{
	var discount = document.getElementById("discRate");
	var discRate = parseFloat(discount.options[discount.selectedIndex].value);
	var year1cost = parseFloat(document.getElementById("y1cost").innerHTML);
	var discountedPrice = year1cost-(discRate*year1cost)/100;
	document.getElementById("discounted").innerHTML=discountedPrice;
}
