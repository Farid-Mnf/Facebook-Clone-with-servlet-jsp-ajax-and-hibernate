package service;

import dto.User;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;

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
}
