package service;
import dto.User;
import java.sql.*;
public class SignUp {
	public static void signUp(User user,Connection con) {
		try {
			PreparedStatement stat = con.prepareStatement(
					"insert into user("
					+ "fname,lname,email,password,gender,month,day,year) "
					+ "values(?,?,?,?,?,?,?,?)");
			stat.setString(1, user.getFirstName());
			stat.setString(2, user.getLastName());
			stat.setString(3, user.getEmail());
			stat.setString(4, user.getPassword());
			stat.setString(5, user.getGender());
			stat.setString(6, user.getMonth());
			stat.setString(7, user.getDay());
			stat.setString(8, user.getYear());
			stat.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
