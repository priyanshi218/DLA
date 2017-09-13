/**
 * 
 */
function load()
{
	document.getElementById("submit").style.display="none";
	document.getElementById("loading2").style.display="block";
}

var _validFileExtensions = [".xlsx"]; 
//this function will validate whether user has uploaded excel sheet or not
function Validate(oForm) {
	var arrInputs = oForm.getElementsByTagName("input");
	for (var i = 0; i < arrInputs.length; i++) {
		var oInput = arrInputs[i];
		if (oInput.type == "file") {
			var sFileName = oInput.value;

			if (sFileName.length > 0) {
				var blnValid = false;
				for (var j = 0; j < _validFileExtensions.length; j++) {
					var sCurExtension = _validFileExtensions[j];
					//alert(sFileName)
					
					if (sFileName.substr(sFileName.length - sCurExtension.length, sCurExtension.length).toLowerCase() == sCurExtension.toLowerCase() && !(/\s/.test(sFileName)))
					{
						blnValid = true;
						break;
					}
					
				}

				if (!blnValid) {
					alert("Sorry, allowed extensions are: " + _validFileExtensions.join("")+" or your filename contains spaces");
					return false;
				}
			}
		}
	}
	load();
	return true;
}