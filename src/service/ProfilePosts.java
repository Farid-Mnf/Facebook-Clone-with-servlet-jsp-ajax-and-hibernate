package service;
import dto.*;
import java.util.*;
import java.sql.*;
public class ProfilePosts {
	private static List<Post> profilePosts;
	public static List<Post> getProfilePosts(int userId,Connection con){
		profilePosts = new ArrayList<>(); 
		try {
			PreparedStatement stat = con.prepareStatement("select * from post where user_id=?");
			stat.setInt(1, userId);
			ResultSet result = stat.executeQuery();
			while(result.next()) {
				Post post = new Post();
				post.setPost_id(result.getInt(1));
				post.setUser_id(result.getInt(2));
				post.setContent(result.getString(3));
				post.setDate(result.getString(4));
				System.out.println(post.getPost_id()+":"+post.getUser_id()+":"+post.getContent());
				profilePosts.add(post);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
                
		return profilePosts;
	}
}
