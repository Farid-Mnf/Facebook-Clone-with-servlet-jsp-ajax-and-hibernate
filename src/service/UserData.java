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
            session.close();
            return (User) list.get(0);
        } else {
            session.close();
            return null;
        }

    }

//    public static dto.User getUserById(int id, Connection con) {
//        try {
//            System.out.println("statement prepare stat");
//            java.sql.PreparedStatement stat = con.prepareStatement("select * from user where id=?");
//            stat.setInt(1, id);
//            System.out.println("user id is" + id);
//            java.sql.ResultSet result = stat.executeQuery();
//            System.out.println("result set is done size is: ");
//            if (result.next()) {
//                System.out.println("result next");
//                dto.User user = new dto.User();
//                user.setFirstName(result.getString(1));
//                user.setLastName(result.getString(2));
//                user.setEmail(result.getString(3));
//                user.setPassword(result.getString(4));
//                user.setGender(result.getString(5));
//                user.setMonth(result.getString(6));
//                user.setDay(result.getString(7));
//                user.setYear(result.getString(8));
//                user.setId(Integer.parseInt(result.getString(9)));
//                System.out.println("User id from getUserById=" + user.getId());
//                return user;
//            } else {
//                return null;
//            }
//        } catch (SQLException e) {
//            e.printStackTrace();
//            return null;
//        }
//    }

}
