package servlets;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.poi.EncryptedDocumentException;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;

import com.beans.OptionDetails;
import com.util.Utility;
@MultipartConfig

/**
 * Servlet implementation class CalculateReport
 */
@WebServlet("/CalculateReport")
public class CalculateReport extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR = "uploadFiles";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CalculateReport() {
		super();
		// TODO Auto-generated constructor stub
	}
	public void init()
	{}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String exMaster = "D:\\DLA\\masterTables.xls";
		HashMap<String, ArrayList<OptionDetails>> dictMap = null;
		try{
			File excel2 = new File(exMaster);
		}
		catch(Exception e)
		{
			request.getRequestDispatcher("viewReport.jsp").forward(request,response);
		}
		// TODO Auto-generated method stub
		String clientName=request.getParameter("clientName");
		String purpose=request.getParameter("purpose");
		String sudoUser=request.getParameter("sudoUser");
		String sudoPass=request.getParameter("sudoPass");
		String dbUser=request.getParameter("dbUser");
		String dbPass=request.getParameter("dbPass");
		String licType=request.getParameter("licType");
		Part part=request.getPart("inventory");
		//String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();
		String tomcatPath = System.getenv("CATALINA_HOME");
		String savePath = tomcatPath+"\\webapps\\DLA";

		String fileName = new Utility().extractFileName(part);   // extract file name of the uploaded file from utility class
		fileName = new File(fileName).getName();                 // create new file with the same name
		part.write(savePath + File.separator + fileName);		// writes that file in given location
		String scriptPath= savePath+"\\Scripts\\scriptIntegrated.ps1";
		String inventoryPath= savePath + File.separator + fileName;
		String outPath= savePath+"\\Excels\\extractedData.xlsx";  // path for blank sheet which requires to be filled further 
		String sqlPath=savePath+"\\Scripts";
		String softwarePath=savePath+"\\Softwares";
		// executePowershell function to generate extractedData sheet
		new Utility().executePowershell(scriptPath,inventoryPath,outPath,sudoUser,sudoPass,dbUser,dbPass,sqlPath,softwarePath,clientName);
		//String scriptPath2= savePath+"\\Scripts\\generateReport.ps1";           // Not used anywhere
		String excelPath= savePath+"\\Excels";
		
		try {
			dictMap = new Utility().getReport(licType,clientName);
		} catch (Exception e) {
			request.getRequestDispatcher("viewReport.jsp").forward(request,response);
		}
		
		for(String db: dictMap.keySet())
		{
			ArrayList<OptionDetails> op = dictMap.get(db);
			double sum=op.get(0).getProductCost();
			for(OptionDetails temp: op)
			{
				sum=sum+temp.getSupportCost();
				temp.setTotalCost(sum);
			}
			System.out.println(db+"   "+sum);

		}
		
		String exUrl = "file:///D:\\DLA\\LicenseReport\\"+clientName+"\\"+clientName+"Data.xlsx"; // Path for generated excel sheet
		request.getSession(false).setAttribute("finalMap", dictMap);
		request.getSession(false).setAttribute("clientName", clientName);
		request.getSession(false).setAttribute("exUrl", exUrl);
		request.getSession(false).setAttribute("file", fileName);
		request.getRequestDispatcher("viewReport.jsp").forward(request,response);


	}






}
