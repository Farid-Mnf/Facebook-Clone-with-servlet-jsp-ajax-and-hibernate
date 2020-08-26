package listeners;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import org.hibernate.Session;
import org.hibernate.SessionFactory;


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
        Session session = (Session) arg0.getServletContext().getAttribute("session");
        session.close();
    }


    @Override
    public void contextInitialized(ServletContextEvent arg0)  { 

        
        SessionFactory sessionFactory = service.DBConnect.connection();
    	arg0.getServletContext().setAttribute("session", sessionFactory.openSession());
        System.out.println("Context initialized with Session...............");
    }
	
}
