package service;
import java.sql.*;
import java.util.List;
import org.hibernate.Query;
import org.hibernate.Session;
public class ValidateLogin {
	static String sql = "select * from user where email=? AND password=?";
	public static boolean validate(String email, String password,Session session) {
		session.beginTransaction();
                Query query = session.createQuery("from User where email= :email and password= :password");
                query.setString("email", email);
                query.setString("password", password);
                
                List result = query.list();
                if(result.isEmpty()){
                    return false;
                }else{
                    return true;
                }
	}
}
