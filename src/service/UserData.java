package service;

import model.User;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class UserData {

    public static User getUser(String email, String password, Session session) {
        session.beginTransaction();
        Query query = session.createQuery("from User where email= :email and password= :password");
        query.setString("email", email);
        query.setString("password", password);
        List list = query.list();
        if (!list.isEmpty()) {
            session.getTransaction().commit();
            session.close();
            return (User) list.get(0);
        } else {
            session.getTransaction().commit();
            session.close();
            return null;
        }
    }
    public static boolean checkIfExists(String email, HttpServletRequest request) {
        SessionFactory sessionFactory = (SessionFactory) request.getServletContext().getAttribute("sessionFactory");
        Session session = sessionFactory.openSession();
        session.beginTransaction();
        Query query = session.createQuery("from User where email= :email");
        query.setString("email", email);
        Object result = query.uniqueResult();
        session.getTransaction().commit();
        session.close();
        if (result != null) {
            return true;
        } else {
            return false;
        }
    }
}
