package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.beans.NewCustDataBean;

/**
 * Servlet implementation class FirstServlet
 */
@WebServlet("/FirstServlet")
public class FirstServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FirstServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String oSystem = request.getParameter("oSystem");
	    String envType = request.getParameter("envType");
		int dbNo = Integer.parseInt(request.getParameter("dbServersCount")); ;
		String prodType = request.getParameter("dbProduct");
		double prodPrice =  Double.parseDouble(request.getParameter("prodPrice"));
	    double totPrice =  Double.parseDouble(request.getParameter("totalCost"));
	    double prodSuppCost =  Double.parseDouble(request.getParameter("ProdSuppCost"));
	    double optSuppCost =  Double.parseDouble(request.getParameter("OptionSuppCost"));
	    String options = request.getParameter("options");
		String subDivide[] = null ;
		ArrayList<String> optCost = new ArrayList<String>();
		ArrayList<String> optInstalled = new ArrayList<String>();
		String lines[] = options.split("\n");
		
		HashMap<String, String> opt= new HashMap<String,String>();
		for(int i=0;i<lines.length;i++)
		 {
			 subDivide = lines[i].split("---"); 
			 optInstalled.add(subDivide[0]);
			 optCost.add(subDivide[1]);
			 opt.put(subDivide[0], subDivide[1]); 
		 }
		
		NewCustDataBean dbData = new NewCustDataBean();
		
		dbData.setOperatingSystem(oSystem);
		dbData.setEnvironment(envType);
		dbData.setDbNo(dbNo);
		dbData.setProdType(prodType);
		dbData.setProdPrice(prodPrice);
		dbData.setTotPrice(totPrice);
		dbData.setProdSuppCost(prodSuppCost);
		dbData.setOptSuppCost(optSuppCost);
		dbData.setOptInstalled(optInstalled);
		dbData.setOptCost(optCost);
		
		ArrayList<NewCustDataBean> dbList= (ArrayList<NewCustDataBean>) request.getSession(false).getAttribute("dbList");
		
		dbList.add(dbData);
		
		System.out.println("******"+dbList);
		request.getSession(false).setAttribute("dbList", dbList);
		
		request.getRequestDispatcher("NewCustomerReport.jsp").forward(request,response);
	}

}
