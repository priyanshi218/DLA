

package servlets;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;

import org.w3c.dom.Document;
import org.xml.sax.SAXException;

/**
 * Servlet implementation class doLogin
 */
@WebServlet(name = "myLogin", urlPatterns = { "/myLogin" })
public class myLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public myLogin() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String tomcatPath = System.getenv("CATALINA_HOME");
		 String savePath = tomcatPath+"\\webapps\\DLA\\credentials.xml";
		File file = new File(savePath);
		DocumentBuilderFactory documentBuilderFactory = DocumentBuilderFactory
		        .newInstance();
		DocumentBuilder documentBuilder = null;
		Document document = null;
		try {
			documentBuilder = documentBuilderFactory.newDocumentBuilder();
		    document = documentBuilder.parse(file);
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		String usr = document.getElementsByTagName("user").item(0).getTextContent();
		String pwd = document.getElementsByTagName("password").item(0).getTextContent();
		String username= request.getParameter("username");
		String password= request.getParameter("password");
		if(username.equals(usr) && password.equals(pwd))   // validating user details with credentials 
		{
			HttpSession session=request.getSession();  // Generating session 
	        session.setAttribute("name",username);  
			RequestDispatcher rd=request.getRequestDispatcher("customer.jsp");
			rd.include(request, response);
		}
		
		else
		{
			request.setAttribute("loginResult", true);
			RequestDispatcher rd=request.getRequestDispatcher("login.jsp");
			rd.include(request, response);
			
		}
		
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

}
