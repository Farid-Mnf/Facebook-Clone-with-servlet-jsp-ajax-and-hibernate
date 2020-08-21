package service;
import dto.Post;
import java.sql.*;
public class StorePost {
	
	static String sql = "insert into post(user_id, content) values(?,?)";
	public static void store(Post post, Connection con) {
		try {
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, post.getUser_id());
			stat.setString(2, post.getContent());
			stat.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
