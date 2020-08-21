package listeners;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;


@WebListener
public class ContextInitListener implements ServletContextListener {

    /**
     * Default constructor. 
     */
    public ContextInitListener() {
        // TODO Auto-generated constructor stub
    }

    @Override
    public void contextDestroyed(ServletContextEvent arg0)  { 
        try{
            ((java.sql.Connection)arg0.getServletContext().getAttribute("con")).close();
        }catch(Exception e){
            e.printStackTrace();
        }
         
    }


    @Override
    public void contextInitialized(ServletContextEvent arg0)  { 
    	java.sql.Connection con = service.DBConnect.connection();
    	arg0.getServletContext().setAttribute("con", con);
         System.out.println("Context initialized...............");
    }
	
}
