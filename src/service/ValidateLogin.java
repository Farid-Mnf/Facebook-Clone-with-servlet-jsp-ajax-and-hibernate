package service;
import java.sql.*;
public class ValidateLogin {
	static String sql = "select * from user where email=? AND password=?";
	public static boolean validate(String email, String password,Connection con) {
		try {
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setString(1, email);
			stat.setString(2, password);
			
			ResultSet result = stat.executeQuery();
			if(result.next()) {
                            return true;
			}else{
                            return false;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return false;
		}
		
	}
}
