package service;
import java.sql.*;
public class StoreComment {
	private static String sql = "insert into comment(comment_user_id, comment_post_id, comment_text) values(?,?,?)";
	public static void store(int comment_user_id, int comment_post_id, String comment_text,Connection con) {
		try {
			PreparedStatement stat = con.prepareStatement(sql);
			stat.setInt(1, comment_user_id);
			stat.setInt(2, comment_post_id);
			stat.setString(3, comment_text);
			stat.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}