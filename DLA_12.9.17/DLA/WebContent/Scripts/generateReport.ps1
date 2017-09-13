$licType=$args[0]
$excelPath=$args[1]

$dbname='dbw01'
Set-Location -Path $excelPath
#Open the extract data file
$xl = New-Object -comobject Excel.Application
$xl.Visible = $false
$wb_op = $xl.Workbooks.Open($excelPath+"\"+"extractedData.xlsx")
$ws_op = $wb_op.Worksheets.Item(1)

#Open the options file
$wb_options = $xl.Workbooks.Open($excelPath+"\"+"OPTION_INST.xls")
$ws_options = $wb_options.Worksheets.Item(1)

#Open the CPU file
$wb_cpu = $xl.Workbooks.Open($excelPath+"\"+"CPU_TYPE1.xls")
$ws_cpu = $wb_cpu.Worksheets.Item(1)

#Open the PRODUCT file
$wb_prod = $xl.Workbooks.Open($excelPath+"\"+"PRODUCT_INST.xls")
$ws_prod = $wb_prod.Worksheets.Item(1)


#Creating output Report
$wb_report = $xl.Workbooks.Add()

for($i=3;$i -le ($ws_op.UsedRange.Rows).count;$i++){
	
	$ws_report = $wb_report.Worksheets.Add()
	$dbname = $ws_op.Cells.Item($i,9).Value()
	$osName = $ws_op.Cells.Item($i,3).Value()
	$cpuType = $ws_op.Cells.Item($i,5).Value()
	$noOfCores = $ws_op.Cells.Item($i,6).Value()
	$dbProduct = $ws_op.Cells.Item($i,11).Value()
	$Searcher = $ws_cpu.usedrange.find($cpuType)
	$target = $Searcher.offset(0,0)
	$opR=$target.Row
	$coreFactor=$ws_prod.Cells.Item($opR,3).Value()
	$licCount = $noOfCores*$coreFactor
	$licCount
	$filename=$dbname+'options_usage.csv'
		
	#open the options usage file
	$wb_temp = $xl.Workbooks.Open('D:\'+$filename)
	$ws_temp = $wb_temp.Worksheets.Item(1)
	
	$Searcher = $ws_prod.usedrange.find($dbProduct)
	$target = $Searcher.offset(0,0)
	$opR=$target.Row
	$namedProdCost=$ws_prod.Cells.Item($opR,5).Value()
	$cpuProdCost=$ws_prod.Cells.Item($opR,6).Value()
		
	$ws_report.name = $dbname+'Report'
	$date=Get-Date
	$ws_report.Cells.Item(1,3)='     '+$dbname+'   as on   '+$date
	$ws_report.Cells.Item(1,3).Interior.ColorIndex =15
	$ws_report.Cells.Item(1,3).Font.Bold=$True
	$ws_report.Cells.Item(1,3).Font.Size=18
	$range = $ws_report.Range("a1","p1")
	$range.Merge() | Out-Null
	$range.VerticalAlignment = -4160
	
	$ws_report.Cells.Item(3,3)='Operating System -> '+$osName+'     CPU -> '+$cpuType+'     Licsense -> '+$licType
	$ws_report.Cells.Item(3,3).Interior.ColorIndex =15
	$ws_report.Cells.Item(3,3).Font.Bold=$True
	$ws_report.Cells.Item(3,3).Font.Size=12
	$range = $ws_report.Range("a3","p3")
	$range.Merge() | Out-Null
	$range.VerticalAlignment = -4160
	
	$ws_report.Cells.Item(5,1)='S.No'
	$ws_report.Cells.Item(5,1).Font.Bold=$True
	$ws_report.Cells.Item(5,1).Font.Size=12
	$ws_report.Cells.Item(5,2)='Option Installed'
	$ws_report.Cells.Item(5,2).Font.Bold=$True
	$ws_report.Cells.Item(5,2).Font.Size=12
	$ws_report.Cells.Item(5,3)='Last Usage Date'
	$ws_report.Cells.Item(5,3).Font.Bold=$True
	$ws_report.Cells.Item(5,3).Font.Size=12
	$ws_report.Cells.Item(5,4)='Current Status'
	$ws_report.Cells.Item(5,4).Font.Bold=$True
	$ws_report.Cells.Item(5,4).Font.Size=12
	$ws_report.Cells.Item(5,5)='Support Cost($)'
	$ws_report.Cells.Item(5,5).Font.Bold=$True
	$ws_report.Cells.Item(5,5).Font.Size=12
	
	$srno=1
	$row=7
	$totalCost=0
	$totalOpCost=0
	for($j=13;$j -le ($ws_op.UsedRange.Columns).count;$j++){
	
		$optionName= $ws_op.Cells.Item(2,$j).Value()
		$optionValue = $ws_op.Cells.Item($i,$j).Value()
		$Searcher = $ws_options.usedrange.find($optionName)
		$target = $Searcher.offset(0,0)
		$opR=$target.Row
		$namedOptionCost=$ws_options.Cells.Item($opR,5).Value()
		$cpuOptionCost=$ws_options.Cells.Item($opR,6).Value()
		if($optionValue -match 'NOT INSTALLED')
		{
		continue
		}
		$ws_report.Cells.Item($row,1).Value()=$srno
		$ws_report.Cells.Item($row,2).Value()=$optionName
		
		$Searcher = $ws_temp.usedrange.find($optionName)
		$target = $Searcher.offset(0,0)
		$opR=$target.Row
		$lastUsedDate=($ws_temp.Cells.Item($opR,5).Value())
		if($lastUsedDate -eq $null){
			$lastUsedDate='-'
		}
		$lastUsedDate = $lastUsedDate.Split('_')[0]
		$ws_report.Cells.Item($row,3).Value()=$lastUsedDate
		if($optionValue -match 'PAST USED')
		{
			$dateArr=$lastUsedDate.Split('.')
			$months = ((Get-Date).year-$dateArr[0])*12 + ((Get-date).month - $dateArr[1])
			if($months -le 24)
			{
				$optionValue='USED'
			}
		}
		$ws_report.Cells.Item($row,4).Value()=$optionValue
		$Searcher = $ws_options.usedrange.find($optionName)
		$target = $Searcher.offset(0,0)
		$opR=$target.Row
		$namedOptionCost=$ws_options.Cells.Item($opR,5).Value()
		$cpuOptionCost=$ws_options.Cells.Item($opR,6).Value()
		
		
		if($licType -match 'cpu')
		{
			$optionCost=$cpuOptionCost
		}
		else
		{
			$optionCost=$namedOptionCost
		}
		$ws_report.Cells.Item($row,5).Value()=$optionCost
		$totalOpCost+=$optionCost
		$srno+=1
		$row+=1
		
	}
	$wb_temp.close()
	if($licType -match 'cpu')
		{
			$prodCost=$cpuProdCost
			$totalCost=($prodCost+$totalOpCost)
		}
		else
		{
			$prodCost=$namedProdCost
			$totalCost=($prodCost+$totalOpCost)*$noOfCores*25
		}
	$ws_report.Cells.Item(20,3)='  Database Product Type   ->   '+$dbProduct+'      Support Cost($)   ->   '+$prodCost
	$ws_report.Cells.Item(20,3).Interior.ColorIndex =15
	$ws_report.Cells.Item(20,3).Font.Bold=$True
	$ws_report.Cells.Item(20,3).Font.Size=12
	$range = $ws_report.Range("a20","p20")
	$range.Merge() | Out-Null
	$range.VerticalAlignment = -4160
	
	$ws_report.Cells.Item(22,3)='  Total Cost   ->   '+$totalCost
	$ws_report.Cells.Item(22,3).Interior.ColorIndex =15
	$ws_report.Cells.Item(22,3).Font.Bold=$True
	$ws_report.Cells.Item(22,3).Font.Size=18
	$range = $ws_report.Range("a22","p22")
	$range.Merge() | Out-Null
	$range.VerticalAlignment = -4160
	
	$a=$ws_report.UsedRange.EntireColumn.Autofit()
	
}

$wb_report.Save()


