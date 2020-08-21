
package service;

import dto.Post;
import java.util.*;
import java.sql.*;
public class TimelinePosts {
    static List<Post> posts;
    public static List<Post> getPosts(Connection con, int id){
        posts = new ArrayList<>();
        try{
            String sql = "select * from post where not user_id=? order by post_date desc";
            PreparedStatement stat = con.prepareStatement(sql);
            stat.setInt(1, id);
            ResultSet result = stat.executeQuery();
            Post post;
            while(result.next()){
                post = new Post();
                post.setPost_id(result.getInt(1));
                post.setUser_id(result.getInt(2));
                post.setContent(result.getString(3));
                post.setDate(result.getString(4));
                posts.add(post);
            }
            return posts;
        }catch(Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
