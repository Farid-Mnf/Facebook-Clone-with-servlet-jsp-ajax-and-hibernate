package service;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class DBConnect {

    public static SessionFactory connection() {
                SessionFactory sessionFactory = new Configuration().configure().buildSessionFactory();
        return sessionFactory;
    }
}
