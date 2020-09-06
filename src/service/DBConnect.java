package service;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class DBConnect {

    private static SessionFactory sessionFactory;

    public static SessionFactory connection() {
        sessionFactory = new Configuration().configure().buildSessionFactory();
        return sessionFactory;
    }
}
