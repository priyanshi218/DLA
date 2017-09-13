package servlets;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.beans.NewCustDataBean;

/**
 * Servlet implementation class NewCust
 */
@WebServlet("/NewCust")
public class NewCust extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewCust() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String cName = request.getParameter("clientName");
		HttpSession session=request.getSession(false);  
        session.setAttribute("cname",cName);  
        ArrayList<NewCustDataBean> dbList= new ArrayList<NewCustDataBean>();
        session.setAttribute("dbList", dbList);
		RequestDispatcher rd=request.getRequestDispatcher("NewCustomer.jsp");
		rd.include(request, response);		
		
	}

}
