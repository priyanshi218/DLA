########Logs################

New-Item D:\DLA\OracleTempFiles -type directory
$strLogPath = "D:/DLA/OracleTempFiles/"
        $strLogFile = "file.log"
       
        function Log
        {
                param([string]$content)
                Write-host $content
                $date = Get-Date -format G
                $content  = "[ $date ] $content" 
                Add-Content $objLogFiles $content
        }


        If (!(Test-Path $strLogPath))
        {
            #Log -content "Log Path Not Present. Creating a File at $strLogPath/$strLogFile"
	    New-Item $strLogPath -Type Directory > $Null  
        }
	    $objLogFiles = New-Item -Path $strLogPath -Name $strLogFile -Type File -Force
		

#Set-ExecutionPolicy RemoteSigned 
$inventoryPath=$args[0]
$outPath=$args[1]
$scriptPath=$args[6]
$softwarePath=$args[7]
$clientName=$args[8]
$folder="D:\DLA\LicenseReport\"+$clientName
$newPath=$folder+"\"+$clientName+"Data.xlsx"


$a="D:\DLA\LicenseReport\"+$clientName+"\"+$clientName+"Data.xlsx"

If(Test-Path $a)
{

Log -content "****** $clientName File Exists ******"

#Open the existing data file

$xl_op = New-Object -comobject Excel.Application
$xl_op.Visible = $false
$wb_op = $xl_op.Workbooks.Open($a)
$ws_op = $wb_op.Worksheets.Item(1)

$intRowMax_op =  ($ws_op.UsedRange.Rows).count
$intColMax_op =  ($ws_op.UsedRange.Columns).count



$FileName = $folder+"\"+$clientName+"_ErrorLog.xlsx"
if (Test-Path $FileName) 
	{
		Remove-Item $FileName
		$outputpath=$folder+"\"+$clientName+"_ErrorLog"
		$e = New-Object -comobject Excel.Application
		$e.Visible = $false
		$w = $e.Workbooks.Add()
		$ws1= $w.Worksheets.Item(1)
		$e.Columns.Item(1).columnWidth = 25
		$ws1.Cells.Item(1,1) = 'Machine IP'
		$ws1.Cells.Item(1,1).Font.Size = 14 
		$ws1.Cells.Item(1,1).Font.Bold=$True 

		$e.Columns.Item(2).columnWidth = 50
		$ws1.Cells.Item(1,2) = 'Error Log'
		$ws1.Cells.Item(1,2).Font.Size = 14 
		$ws1.Cells.Item(1,2).Font.Bold=$True 
		$RMaxx= 2
		$CMaxx= ($ws1.UsedRange.Columns).count
   
	}
 	 



 	         
}
else
{

If(!(Test-Path $folder))
{
New-Item $folder -type directory
}

Copy-Item $outPath $newPath     		#copy extractedData.xlsx to newly created file                 

#Open the extract data file

$xl_op = New-Object -comobject Excel.Application
$xl_op.Visible = $false
$wb_op = $xl_op.Workbooks.Open($newPath)
$ws_op = $wb_op.Worksheets.Item(1)


$intRowMax_op = 2
$intColMax_op = ($ws_op.UsedRange.Columns).count


$outputpath=$folder+"\"+$clientName+"_ErrorLog"
$e = New-Object -comobject Excel.Application
$e.Visible = $false
$w = $e.Workbooks.Add()
$ws1= $w.Worksheets.Item(1)

$e.Columns.Item(1).columnWidth = 25
$ws1.Cells.Item(1,1) = 'Machine IP'
$ws1.Cells.Item(1,1).Font.Size = 14 
$ws1.Cells.Item(1,1).Font.Bold=$True 

$e.Columns.Item(2).columnWidth = 50
$ws1.Cells.Item(1,2) = 'Error Log'
$ws1.Cells.Item(1,2).Font.Size = 14 
$ws1.Cells.Item(1,2).Font.Bold=$True 
$RMaxx= 2
$CMaxx= ($ws1.UsedRange.Columns).count





}



#Open the inventory excel
$xl = New-Object -COM "Excel.Application"
$xl.Visible = $false
$wb = $xl.Workbooks.Open($inventoryPath)
$ws = $wb.Worksheets.Item(1)
$intRowMax =  ($ws.UsedRange.Rows).count
$intColMax =  ($ws.UsedRange.Columns).count


try{
	#Search MachineName index
	$Searcher = $ws.usedrange.find("MachineName")
	$target = $Searcher.offset(0,0)
	$machineR=$target.Row
	$machineC=$target.Column
	
	#Search OperatingSystem index
	$Searcher = $ws.usedrange.find("OperatingSystem")
	$target = $Searcher.offset(0,0)
	$osR=$target.Row
	$osC=$target.Column
	
	#Search Flag index
	$Searcher = $ws.usedrange.find("Flag")
	$target = $Searcher.offset(0,0)
	$flagR=$target.Row
	$flagC=$target.Column
	Log -content "****** flag index is $flagC ******"
}
 catch
{
	kill -processname excel
	Move-Item -Path 'D:\DLA\OracleTempFiles\*' $folder
	Remove-Item 'D:\DLA\OracleTempFiles'
	$ws1.Cells.Item(2,2) = 'Improper Inventory file !!! Exiting.. !!!'
	$ws1.Cells.Item(2,2).Font.Size = 14 
	$ws1.Cells.Item(2,2).Font.Bold=$True 
	Log -content "****** Improper Inventory file !!! Exiting.. !!! ******"
	exit

}

#Variables Declaration
$i=2
$machine_os = @{}
$slNo = 1
$linuxUser=$args[2]
$linuxPassword=$args[3]
$dbUser=$args[4]
$dbPass=$args[5]
$winUsername = '.\administrator'
$winPassword = 'cloud@123'

for($z=$machineR+1; $z -le ($ws.UsedRange.Rows).count ; $z++){
                try{
                                $var = $machine_os.Add($ws.Cells.Item($z,$machineC).Value(),$ws.Cells.Item($z,$osC).Value())
                }
                catch{
                                continue
                }
                         
}
#Fetch machine Details
foreach ($h in $machine_os.GetEnumerator()) {
                $rowcount = 2 
                $computer=$($h.Name);
					if(!(Test-Connection -Cn $computer -BufferSize 16 -Count 1 -ea 0 -quiet))

						{
							$ws1.Cells.Item($RMaxx,1) = $computer
							$ws1.Cells.Item($RMaxx,2) = 'Error While Connecting to this Machine !! '
							Log -content "****** Could not connect to machine $computer ******"
							$RMaxx = $RMaxx + 1
							continue;
						}
                $os =$($h.Value)
                if($os.Contains('Windows')){
                    $DBInst = New-Object System.Collections.ArrayList
			        $pw   = ConvertTo-SecureString $winPassword -AsPlainText -Force
			        $cred = New-Object Management.Automation.PSCredential ($winUsername, $pw)
					
					$osname=(Get-WmiObject -computername $computer -credential $cred -class Win32_OperatingSystem).Caption
			        $osversion=((Get-WmiObject  -computername $computer -credential $cred -class Win32_OperatingSystem).Version)
			        $noOfCores=(Get-WmiObject  -ComputerName $computer -credential $cred -class win32_processor).count
			        $memory=Get-WmiObject CIM_PhysicalMemory -ComputerName $computer -credential $cred | Measure-Object -Property capacity -sum | % {[math]::round(($_.sum / 1GB),2)} 
			        if($noOfCores -ne $null)
			        {
			        	$noOfCores=$noOfCores*(Get-WmiObject  -ComputerName $computer -credential $cred -class win32_processor)[0].NumberOfCores
			        }
			        else
			        {
			        	$noOfCores=$noOfCores.NumberOfCores
			        }
			        $cputypeArr=((Get-WmiObject  -ComputerName $computer -credential $cred -class win32_processor)[0].Name).Split(' ')
			        $cputype= $cputypeArr[0]+' '+$cputypeArr[1]
			        $noOfSockets=(Get-WmiObject  -ComputerName $computer -credential $cred -class win32_processor).count
			        $var6 = (Get-WMIObject Win32_Service -computer $computer -credential $cred |select Name | where-object {$_.name -like 'OracleService*'}) 
			        foreach($var in $var6){
			                        $temp=($var.Name)
			                        $flag = $DBInst.Add($temp.SubString(13))
			        }
                }
                else{
	                $DBInst = New-Object System.Collections.ArrayList
	                
	                $copyString = $linuxUser+'@'+$computer+':/tmp/'
	               	$testingPath = $scriptPath+"\linuxScript.sh"
	               	$pscpPath = $softwarePath+"\pscp.exe"
	               	$plinkPath = $softwarePath+"\plink.exe"
	                Set-Location -Path $softwarePath
					
						$a=Start-Process $pscpPath -NoNewWindow -ArgumentList ("-scp -pw $linuxPassword $testingPath $copyString") -Wait
						$a=.\\plink -ssh -l $linuxUser -P 22 -pw $linuxPassword $computer command "sed -e 's/\r//g' /tmp/linuxScript.sh > /tmp/testing1.sh"
						$var3 =.\\plink -ssh -l $linuxUser -P 22 -pw $linuxPassword $computer command "sh /tmp/testing1.sh" 
						 write-host $var3 "-------var3---------"
	               				$var4 = $var3.count-1
	                			$var5 = $var3[7..$var4]
	               				 $var6 = $var5 -Split("ora_pmon_")
	                			$var6 = $var6 | ? {$_}
	
	                			foreach($j in $var6){
	                                		$DBInst.Add($j)
	                                	} 
	                			$cputype = $var3[0]
	                			$osversion = $var3[2]
	                			$osname = $var3[3]
	               			 	$noOfSockets = $var3[5]
	                			$noOfCores = $var3[6]
								$memory = $var3[4]
	               
                }  
                 #Fetch db details of each db instance
                foreach($dbname in $DBInst){
                
				
				try
					{
						#Search dbname index
						$Searcher = $ws.usedrange.find($dbname)
						$target = $Searcher.offset(0,0)
						$dbnameR=$target.Row
						$dbnameC=$target.Column
						$fvalue=$ws.Cells.Item($dbnameR,$flagC).Value()
						Write-Host " db row is $dbnameR .... flagc is $flagC .........Flag is $fvalue"
						if($fvalue -match 'yes')
						{
							Log -content "******Executed for $dbname ******"
							continue
						}
						else
						{
						Log -content "--------------Executing for $dbname-------------"
						}
					}
				catch
					{		$srNo = 1
					    for($y=2;$y -le $intRowMax+1;$y++)
						{
							$ws.Cells.Item($y,1) = $srNo
							$srNo = $srNo +1
						}
							
							
						$ws.Cells.Item($intRowMax+1,3) = $dbname
						$ws.Cells.Item($intRowMax+1,4) = $dbname
						$ws.Cells.Item($intRowMax+1,8) = $computer
						
						 if($os.Contains('Windows'))
						 {
							$ws.Cells.Item($intRowMax+1,9) = 'Windows'	
						 }
						 else
						 {
							$ws.Cells.Item($intRowMax+1,9) = $osname	
						 }
						 
				
						$dbnameR=$intRowMax+1	
						$intRowMax=$intRowMax+1
					}
                $dbDetails = New-Object System.Collections.ArrayList
                $dbDetails.Add($slNo)
                $dbDetails.Add($computer)
                $dbDetails.Add($osname)
                $dbDetails.Add($osVersion)
                $dbDetails.Add($cputype)
                $dbDetails.Add($noOfCores)
                $dbDetails.Add($noOfSockets)
				$dbDetails.Add($memory)
                $dbDetails.Add($dbname)
                $intRowMax_op=$intRowMax_op+1
                try{
                                $connectionString = 'Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST='+$computer+')(PORT=1521))(CONNECT_DATA=(SERVICE_NAME='+$dbname+')));User Id='+$dbUser+';Password='+$dbPass+';'
                                [System.Reflection.Assembly]::LoadWithPartialName("System.Data.OracleClient") | Out-Null 
                                $connection = New-Object System.Data.OracleClient.OracleConnection($connectionString) 
                                $connection.Open() 
								 Log -content "****** Connected to database instance $dbname inside $computer ******"
                }
                catch{
                				$intRowMax_op=$intRowMax_op-1
                                Write-Host "not connecting to " $dbname
								$ws1.Cells.Item($RMaxx,1) = $computer
								$ws1.Cells.Item($RMaxx,2) = 'Error While Connecting to Database Instance : ' + $dbname
								$RMaxx = $RMaxx + 1
								Log -content "****** Could not connect to database instance $dbname inside $computer ******"
                                continue;
                }
                #------------Get db version--------------
                $queryString = 'SELECT version from v$instance'
                $command = new-Object System.Data.OracleClient.OracleCommand($queryString, $connection) 

                $result = $command.ExecuteReader() 
                while ($result.Read()) {
                                $version = $result.GetString(0);
                                                                                
                }
                #-------Get db product------------------
                $queryString = 'SELECT banner from v$version'
                $command = new-Object System.Data.OracleClient.OracleCommand($queryString, $connection) 
                $result = $command.ExecuteReader() 
                while ($result.Read()) {
                                $banner = $result.GetString(0);
                                break;
                }
                if ($banner.Contains('Enterprise')){
                                                                                $banner = 'Enterprise'
                }
                elseif ($banner.Contains('Standard')){
                                                                                $banner = 'Standard'
                }
                elseif ($banner.Contains('Personal')){
                                                                                $banner = 'Personal'
                }
                elseif ($banner.Contains('Mobile')){
                                                                                $banner = 'Mobile'
                }
                else{
                                $banner = 'NoSQL Enterprise'
                }
                $dbDetails.Add($version)
                $dbDetails.Add($banner)
                Set-Location -Path $scriptPath
				Log -content "****** Executing SQL script for $dbname ******"
				 Log -content "------------------------------------------------------------------------"
                echo exit | sqlplus $dbUser/$dbPass@$dbname '@opt_usage_stats_new1.sql'
                
                #Open the SQL output file
                $path="D:\DLA\OracleTempFiles\"+$dbname+"options_usage.csv"
                
                $xl_sql = New-Object -comobject Excel.Application
                $xl_sql.Visible = $false
                $wb_sql = $xl_sql.Workbooks.Open($path)
                $ws_sql = $wb_sql.Worksheets.Item(1)
                $startRow = ($ws_sql.UsedRange.find("<<Begin Usage>>")).Row + 4
                $endRow = ($ws_sql.UsedRange.find("<<End USAGE>>")).Row-2
                $productR = $startRow
                $productC = 1
                $usageR = $startRow
                $usageC = 2
				$lastUsageC = 5
                $product_usage = @{}
				
                for($m=$productR+1; $m -le $endRow ; $m++){
                                try{
                                $var = $product_usage.Add($ws_sql.Cells.Item($m,$productC).Value(),$ws_sql.Cells.Item($m,$usageC).Value()+":"+$ws_sql.Cells.Item($m,$lastUsageC).Value())
                                }
                                catch{
                                continue
                                }                              
                }
				
                $optionNames=2
                $wb_sql.Save()
                
        
                for($m = 12 ; $m -le $intColMax_op ; $m+=2)
                {
                                $flag=0
                   $val =  $ws_op.Cells.Item($optionNames,$m).Value()
                   foreach($h1 in $product_usage.GetEnumerator()){
												$usage=($h1.Value).Split(":")[0]
												$date=($h1.Value).Split(":")[1]
												$date = $date.Split('_')[0]
                                                if( $h1.Name -match $val) {
                                                                if($usage -match "NO_USAGE"){
                                                                                $dbDetails.Add("NOT USED")
                                                                }
                                                                if($usage -match "CURRENT_USAGE"){
                                                                                $dbDetails.Add("USED")
                                                                }
                                                                if($usage -match "PAST_USAGE"){
																				
																				$dateArr=$date.Split('.')
																				$months = ((Get-Date).year-$dateArr[0])*12 + ((Get-date).month - $dateArr[1])
																				if($months -le 24)
																				{
																				 $dbDetails.Add("USED")
																				}
																				else
																				{
																				 $dbDetails.Add("PAST USED")
																				}
                                                                }
																$dbDetails.Add($date)
                                                                $flag=1
                                                                break;
                                                }
												
                                }
                                if($flag -eq 0){
                                $dbDetails.Add("NOT INSTALLED")
								$dbDetails.Add("-")
                                }
								
                }
                
                
                for($x=1;$x -le $intColMax_op;$x++){
                $ws_op.Cells.Item($intRowMax_op,$x) = $dbDetails[$x-1]
                }
                $slNo = $slNo +1 
                Write-Host "-------------------------------------------------"
				$ws.Cells.Item($dbnameR,$flagC) = 'yes'
				
                }
                                                         
}

	
    Log -content "****** ExtractData.xlsx generated*************"

    try{     
$wb.Save()
$wb.Close()
$xl.Quit()
$wb_op.Save()
$wb_op.Close()
$xl_op.Quit()
$w.SaveAs($outputpath) 
$e.Quit()

Log -content "****** Killing process*************"
kill -processname excel
Log -content "****** Process Killed *************"
Move-Item -Path 'D:\DLA\OracleTempFiles\*' $folder -Force
Remove-Item D:/DLA/OracleTempFiles -Force -Recurse
}
catch{
	exit
}



