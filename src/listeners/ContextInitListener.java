package listeners;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import org.hibernate.SessionFactory;


@WebListener
public class ContextInitListener implements ServletContextListener {


    public ContextInitListener() {}

    @Override
    public void contextDestroyed(ServletContextEvent arg0)  { 
        SessionFactory sessionFactory = (SessionFactory) arg0.getServletContext().getAttribute("sessionFactory");
        sessionFactory.close();
    }


    @Override
    public void contextInitialized(ServletContextEvent arg0)  { 

        
        SessionFactory sessionFactory = service.DBConnect.connection();
    	arg0.getServletContext().setAttribute("sessionFactory", sessionFactory);
        System.out.println("Context initialized with -((.Session Factory.))- ...............");
    }
	
}
