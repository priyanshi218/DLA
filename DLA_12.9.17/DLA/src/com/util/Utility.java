package com.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import javax.servlet.http.Part;

import com.beans.OptionDetails;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class Utility {

	// A Function to get the file name of the uploaded file

	public String extractFileName(Part part) {

		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length()-1);
			}
		}
		return "";
	}

	// A Function that executes the powershell file, which generates extractedData sheet

	public void executePowershell(String cmd,String inventoryPath,String outPath,String sudoUser,String sudoPass,String dbUser,String dbPass,String sqlPath,String softwarePath,String clientName)
	{

		String command = "C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe -ExecutionPolicy bypass "+cmd+" "+inventoryPath+" "+outPath+" "+sudoUser+" "+sudoPass+" "+dbUser+" "+dbPass+" "+sqlPath+" "+softwarePath+" "+clientName;
		// Executing the command

		Process powerShellProcess=null;
		try {
			powerShellProcess = Runtime.getRuntime().exec(command);

			// Getting the results to console 

			powerShellProcess.getOutputStream().close();
			String line;
			System.out.println("Standard Output:");
			BufferedReader stdout = new BufferedReader(new InputStreamReader(
					powerShellProcess.getInputStream()));
			while ((line = stdout.readLine()) != null) {
				System.out.println(line);
			}
			stdout.close();
			System.out.println("Standard Error:");
			BufferedReader stderr = new BufferedReader(new InputStreamReader(
					powerShellProcess.getErrorStream()));
			while ((line = stderr.readLine()) != null) {
				System.out.println(line);
			}
			stderr.close();
			System.out.println("Done");

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
	
	// A Function which calculates liccount,total cost,product cost,support cost by reading mastertables extractedData.
	
	public HashMap<String, ArrayList<OptionDetails>> getReport(String licType, String clientName) throws Exception
	{
		FileInputStream fis=null;
		XSSFWorkbook wb=null;
		XSSFSheet wsEx=null;
		FileInputStream fis2=null;
		HSSFWorkbook wb2=null;
		HSSFSheet wsEx2=null;
		HSSFSheet wsEx3=null;
		HSSFSheet wsEx4=null;

		HashMap<String, ArrayList<OptionDetails>> dictMap = new HashMap<String, ArrayList<OptionDetails>>();

		String tomcatPath = System.getenv("CATALINA_HOME");
		String savePath = tomcatPath+"\\webapps\\newDlaWar";
		String exPath = "D:\\DLA\\LicenseReport\\"+clientName+"\\"+clientName+"Data.xlsx"; // Path for generated excel sheet
		String exMaster = "D:\\DLA\\masterTables.xls";  // Path of MasterTables.xls, which must present in D:/DLA directory  


		try{
			File excel = new File(exPath);
			File excel2 = new File(exMaster);
			fis = new FileInputStream(excel);
			wb = new XSSFWorkbook(fis);
			wsEx = wb.getSheetAt(0);    // Opens Extracted data sheet
			fis2 = new FileInputStream(excel2);
			wb2 = new HSSFWorkbook(fis2);
			wsEx2 = wb2.getSheetAt(0);    // Opens Master Tables sheet no. 0
			wsEx3 = wb2.getSheetAt(1);	// Opens Master Tables sheet no. 1
			wsEx4 = wb2.getSheetAt(2);	// Opens Master Tables sheet no. 2
		}
		catch(Exception e)
		{   throw new Exception(e.getMessage());
		}


		int rowNum = wsEx.getLastRowNum() + 1;
		int colNum = wsEx.getRow(1).getLastCellNum();
		XSSFRow header = wsEx.getRow(1);
		for (int i = 2; i < rowNum; i++) {
			double prodCost=0;
			String dbname=null;
			XSSFRow row = wsEx.getRow(i);
			try{
				dbname = row.getCell(8).getStringCellValue();
			}
			catch(Exception e)
			{
				break;
			}
			String cpuType=row.getCell(4).getStringCellValue();
			System.out.println(cpuType);
			String product =row.getCell(10).getStringCellValue();
			String machineName=row.getCell(1).getStringCellValue();
			int cores =(int) row.getCell(5).getNumericCellValue();
			double licCount=((wsEx2.getRow(findRow(wsEx2, cpuType)).getCell(2).getNumericCellValue()) * cores);
			dictMap.putIfAbsent(dbname, null);
			ArrayList<OptionDetails> temp = new ArrayList<OptionDetails>();
			double sum=0;
			for(int j = 11;j<colNum;j++)
			{
				String optionName=null;
				double supportCost=0;
				OptionDetails op=new OptionDetails();

				try{
					optionName=header.getCell(j).getStringCellValue();
				}
				catch(Exception e)
				{
					break;
				}
				String optionValue=row.getCell(j).getStringCellValue();
				if(optionValue.equals("NOT INSTALLED"))
				{
					j=j+1;
					continue;
				}
				System.out.println(optionName+"  "+optionValue);
				j=j+1;
				try{
					String lastUsed=row.getCell(j).getStringCellValue();
					op.setLastUsed(lastUsed);
				}
				catch(Exception e)
				{
					op.setLastUsed("-");
				}

				int optionCost=findRow(wsEx3, optionName);
				if(licType.equals("named"))
				{
					supportCost = wsEx3.getRow(optionCost).getCell(4).getNumericCellValue();
					prodCost=(wsEx4.getRow(findRow(wsEx4, product)).getCell(4).getNumericCellValue());
					licCount = cores*25;
				}
				else
				{
					supportCost = wsEx3.getRow(optionCost).getCell(5).getNumericCellValue();
					prodCost=(wsEx4.getRow(findRow(wsEx4, product)).getCell(5).getNumericCellValue());
				}
				if(optionValue.equals("USED") || optionValue.equals("PAST USED"))
				{
					sum=sum+supportCost;
				}
				op.setOptionName(optionName);
				op.setCurrentStatus(optionValue);
				op.setProdType(product);
				op.setSupportCost(supportCost);

				op.setProductCost(prodCost);
				op.setTotalCost(0);
				op.setLicCount(licCount);
				op.setMachineName(machineName);
				System.out.println(op);
				temp.add(op);

			}
			Collections.sort(temp);

			dictMap.put(dbname, temp);
		}
		System.out.println(dictMap);
		return dictMap;


	}

	public static String cellToString(XSSFCell xssfCell) {

		int type;
		Object result = null;
		type = xssfCell.getCellType();

		switch (type) {

		case XSSFCell.CELL_TYPE_NUMERIC:
			result = BigDecimal.valueOf(xssfCell.getNumericCellValue())
			.toPlainString();

			break;
		case XSSFCell.CELL_TYPE_STRING:
			result = xssfCell.getStringCellValue();
			break;
		case XSSFCell.CELL_TYPE_BLANK:
			result = "";
			break;
		case XSSFCell.CELL_TYPE_FORMULA:
			result = xssfCell.getCellFormula();
		}

		return result.toString();
	}

	private  int findRow(HSSFSheet wsEx3, String cellContent) {
		for (Row row : wsEx3) {
			for (Cell cell : row) {
				if (cell.getCellType() == Cell.CELL_TYPE_STRING) {
					if (cell.getStringCellValue().contains(cellContent) || cell.getStringCellValue().equals(cellContent)) {
						return row.getRowNum();  
					}
				}
			}
		}               
		return 0;
	}


}
